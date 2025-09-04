// amix-syscalls.c - Using your specific TRAP #0 convention
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/times.h>
#include <sys/errno.h>
#include <sys/time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fs/ext4.h>          // lwext4 header
#include <fs/ext4_inode.h>
#include <fs/ext4_fs.h>
#include <sys/unistd.h>  // For ssize_t etc.
#include <unistd.h>
#include <stddef.h>
#include <errno.h>
#include <RTC.h>
#include <debug.h>
//Sys stuff
#include<sys_amix.h>
#include <stdint.h>

// File descriptor definitions
#define STDIN_FILENO    0
#define STDOUT_FILENO   1
#define STDERR_FILENO   2


#define STD_FD_COUNT 3
#define MAX_OPEN_FILES 8

#define MAX_PATH_LEN 255
extern int chek_path_dir(const char* path);
extern int chek_path_file(const char* path);
extern char* format_path(char *path, char *ret_path);
static ext4_file *fd_table[MAX_OPEN_FILES] = {0}; // Maps fd -> FIL*
static char fd_paths[MAX_OPEN_FILES][MAX_PATH_LEN+1];
extern inline void asm_STI(void) {
    __asm__ volatile ("move.w #0x2700, %%sr" ::: "memory");
}

extern inline void asm_CLI(void) {
    __asm__ volatile ("move.w #0x2200, %%sr" ::: "memory");
}



void _exit(int status) {
    // Print exit message to screen
    const char msg[] = "\nProgram exited with code: ";
    sys_write_screen_string(msg, sizeof(msg) - 1);
    
    // Print exit code (simple digit conversion)
    if (status >= 0 && status <= 9) {
        sys_print_screen('0' + status);
    } else {
        sys_print_screen('?');
    }
    sys_print_screen('\n');
    
    // Halt system (you may want to implement SYS_EXIT in your TRAP handler)
    while(1) {
        
    }
}

// Memory management
void *_sbrk_r(struct _reent *r, ptrdiff_t incr) {
    extern char _heap_start;
    static uintptr_t heap_end = 0;
    asm_STI();
    if (heap_end == 0) {
        heap_end = (uintptr_t)&_heap_start;
        // align initial heap_end up to next 4-byte boundary
        heap_end = (heap_end + 3) & ~((uintptr_t)3);
    }

    // calculate new end, then align it
    uintptr_t new_end = heap_end + incr;
    new_end = (new_end + 3) & ~((uintptr_t)3);

    uintptr_t prev = heap_end;
    heap_end = new_end;

    //printf("\nSBRK last 0x%08lx new 0x%08lx\n",prev, new_end);
    asm_CLI();
    return (void *)prev;
}

// _stat_r: info about a file path (not necessarily open)
int _stat_r(struct _reent *r, const char *path, struct stat *st) {
    char f_path[256];
    char* p_ptr = format_path((char*)path, f_path);
    DBG_PRINTF("Path: %s -> %s\n",path,p_ptr);
    if(p_ptr == NULL)
    {
        DBG_PRINTF("Stat error! path: %s\n",p_ptr);
        return -1;
    }
    
    if(chek_path_file(p_ptr) != EOK)
    {
        r->_errno = EINVAL;
        return -1;
    }

    struct ext4_inode ino;
    uint32_t inode;
    if((r->_errno = ext4_raw_inode_fill(p_ptr, &inode, &ino)))
        return -1;
    

    st->st_atime = ino.access_time;
    st->st_ctime = ino.crtime;
    st->st_mtime = ino.modification_time;

    st->st_ino = inode;
    st->st_gid = ino.gid;
    st->st_dev = ext4_inode_get_dev(&ino);

    

    st->st_mode = ino.mode;
    st->st_blksize = 1024;
    st->st_blocks = (ino.size_lo + 512 - 1) / 512;

    st->st_uid = ino.uid;
    st->st_size = ino.size_lo;
    st->st_rdev = -1;
    st->st_nlink = ino.links_count;

    return 0;
}

// _fstat_r: info about an open file descriptor
int _fstat_r(struct _reent *r, int fd, struct stat *st) {
    return _stat_r(r,fd_paths[fd], st);
}


int _isatty_r(struct _reent *r, int fd) { 
    return (fd >= 0 && fd <= 2) ? 1 : 0;  // stdin, stdout, stderr, uart are ttys
}

// _lseek_r
off_t _lseek_r(struct _reent *r, int fd, off_t offset, int whence) {
    if (fd < 3) return -1; // Not a file
    if(fd_table[fd] == NULL)
    {
        r->_errno = EINVAL;
        return -1;
    }
    ext4_file *fp = fd_table[fd];
    
    switch (whence) {
        case SEEK_SET: break;
        case SEEK_CUR: break;
        case SEEK_END: break;
        default: return -1;
    }
    
    
    
    if ((r->_errno = ext4_fseek(fp, offset, whence)))
    {
        return -1;
    }
        
    return fp->fpos;
}


long rtc_to_unix_epoch(int year, int mon, int day, int hour, int min, int sec) {
    // Simple table for days before each month; adjust for leap years
    static const int days_before_month[12] = { 0,31,59,90,120,151,181,212,243,273,304,334 };
    int y = year - 1970;
    int leap_days = (y + 2) / 4 - (y + 70) / 100 + (y + 370) / 400;
    int days = y * 365 + leap_days + days_before_month[mon-1] + (day-1);

    // Leap year adjustment
    if ((mon > 2) && ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))) {
        days++;
    }

    return ((long)days * 24 * 3600) + (hour * 3600) + (min * 60) + sec;
}



// Unlink (delete) file syscall replacement for newlib with lwext4
int _unlink_r(struct _reent *r, const char *path) {
    char f_path[256];
    char* p_ptr = format_path((char*)path, f_path);
    if(chek_path_dir(p_ptr) != EOK)
    {
        r->_errno = EINVAL;
        return r->_errno;
    }

    r->_errno = ext4_fremove(p_ptr);
    

    return r->_errno;
}
int _gettimeofday_r(struct _reent *r, struct timeval *tp, struct timezone *tzp) 
{ 
    uint8_t year, date, mon, sec, min, hr, day;
    rtc_get_time(&sec, &min, &hr, &day, &date, &mon, &year);
    int full_year = year+2000;
    long epoch = rtc_to_unix_epoch(full_year, mon, date, hr, min, sec);

    if(tp)
    {
        tp->tv_sec = epoch;
        tp->tv_usec = 0; //no micro seconds!
    }
    return 0; 
}


// Map ANSI foreground colors (30-37 and 90-97) to 4-bit color values (0-15)
uint8_t ansi_fg_code_to_pc_color(int code) {
    switch(code) {
        case 30: return 0x0;  // Black
        case 31: return 0x4;  // Red
        case 32: return 0x2;  // Green
        case 33: return 0x6;  // Yellow (brown)
        case 34: return 0x1;  // Blue
        case 35: return 0x5;  // Magenta
        case 36: return 0x3;  // Cyan
        case 37: return 0x7;  // Light gray
        case 90: return 0x8;  // Dark gray
        case 91: return 0xC;  // Bright red
        case 92: return 0xA;  // Bright green
        case 93: return 0xE;  // Bright yellow
        case 94: return 0x9;  // Bright blue
        case 95: return 0xD;  // Bright magenta
        case 96: return 0xB;  // Bright cyan
        case 97: return 0xF;  // White
        default: return 0x7;  // Default light gray
    }
}

// Map ANSI background colors (40-47 and 100-107) to 4-bit color values (0-15)
uint8_t ansi_bg_code_to_pc_color(int code) {
    switch(code) {
        case 40: return 0x0;  // Black
        case 41: return 0x4;  // Red
        case 42: return 0x2;  // Green
        case 43: return 0x6;  // Yellow (brown)
        case 44: return 0x1;  // Blue
        case 45: return 0x5;  // Magenta
        case 46: return 0x3;  // Cyan
        case 47: return 0x7;  // Light gray
        case 100: return 0x8; // Dark gray
        case 101: return 0xC; // Bright red
        case 102: return 0xA; // Bright green
        case 103: return 0xE; // Bright yellow
        case 104: return 0x9; // Bright blue
        case 105: return 0xD; // Bright magenta
        case 106: return 0xB; // Bright cyan
        case 107: return 0xF; // White
        default: return 0x0;  // Default black
    }
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// Dummy color map functions (replace with your implementation)
uint8_t ansi_fg_code_to_pc_color(int code);
uint8_t ansi_bg_code_to_pc_color(int code);

// Main function: converts input char buffer with ANSI color escapes into WORD buffer with color attributes
size_t _byte_to_word_string(const char* buf, size_t count, uint16_t *wbuf)
{
    uint8_t _text_color_foreground = 0x02;  // green default fg
    uint8_t _text_color_background = 0x00;  // black default bg
    size_t out_count = 0;

    while (count > 0 && *buf)
    {
        if (*buf == '\033' && buf[1] == '[')
        {
            // Parse the end of the escape sequence (ending with 'm')
            const char *esc = buf + 2;
            char code[32] = {0};
            int i = 0;

            while (count > 0 && *esc && *esc != 'm' && i < (int)(sizeof(code) - 1))
            {
                code[i++] = *esc++;
                count--;
            }
            if (*esc == 'm')
            {
                code[i] = '\0';  // Null terminate codes string

                // Tokenize by ';' and update fg/bg colors
                char *token;
                char *saveptr;
                char codetmp[32];
                strncpy(codetmp, code, sizeof(codetmp)-1);
                codetmp[sizeof(codetmp)-1] = '\0';

                token = strtok_r(codetmp, ";", &saveptr);
                while (token)
                {
                    int val = atoi(token);
                    if ((val >= 30 && val <= 37) || (val >= 90 && val <= 97))
                        _text_color_foreground = ansi_fg_code_to_pc_color(val);
                    else if ((val >= 40 && val <= 47) || (val >= 100 && val <= 107))
                        _text_color_background = ansi_bg_code_to_pc_color(val);
                    else if (val == 0)
                    {
                        // Reset to defaults
                        _text_color_foreground = 0x07;
                        _text_color_background = 0x00;
                    }
                    token = strtok_r(NULL, ";", &saveptr);
                }

                // Advance buf and count past full escape sequence: \033[ ... m
                size_t esc_len = (esc - buf) + 1;
                buf += esc_len;
                count -= esc_len;
                continue; // do not output escape sequences as characters
            }
            else
            {
                // Malformed escape, output as normal char and advance
                *wbuf++ = *buf++ | ((_text_color_background << 4 | _text_color_foreground) << 8);
                out_count++;
                count--;
                continue;
            }
        }
        else
        {
            *wbuf++ = *buf++ | ((_text_color_background << 4 | _text_color_foreground) << 8);
            out_count++;
            count--;
        }
    }

    return out_count;
}

/* POSIX‐style _write stub that calls the reentrant version */
int _write_r(struct _reent *r, int fd, const void *buf, size_t count) {
    uint16_t *wbuf;
    size_t cnt = count;
    switch (fd) {
    case STDOUT_FILENO:
    case STDERR_FILENO:
        wbuf = malloc(count*sizeof(uint16_t));
        cnt = _byte_to_word_string(buf, cnt, wbuf);
        asm_STI();
        //if(count != 0){syscall_trap0(0xFL, count, (void *)buf);} //print byte buffer
        //asm_CLI();
        //asm_STI();
        if(count != 0){syscall_trap0(0x14L, cnt, (void *)wbuf);} //print word buffer
        asm_CLI();
        free(wbuf);
        return count;   // Return bytes written
    default:
    
        if (fd >= STD_FD_COUNT && fd < MAX_OPEN_FILES && fd_table[fd])
        {
            size_t bw;
            
            if ((r->_errno = ext4_fwrite(fd_table[fd], buf, count, &bw)))
                return -1;
            
            return bw;
        }
        if(fd > MAX_OPEN_FILES)
        {
            printf("Too many open files!\n");
        }
        if(!fd_table[fd])
        {
            printf("No FD in table\n");
        }
        if(fd < STD_FD_COUNT)
        {
            printf("Wierd STD stream?\n");
        }
        r->_errno = EBADF;
        
        return -1;
    }
}

int _read_r(struct _reent *r, int fd, char *buf, size_t count) {
    size_t i;
    long result;
    if (!r) return -1;  // Defensive
    switch (fd) {
    case STDIN_FILENO:
        for (i = 0; i < count; i++) {
            /* TRAP #0, D1 = syscall number (8 = read char from keyboard),
               D0 = unused, A0 = unused, returns char in D0 */
            result = syscall_trap0(8L, 0L, 0L);
            syscall_trap0(0L,(long)result,0L); //echo
            buf[i] = (char)(result & 0xFF);
            
            /* Stop on newline/carriage return for line-buffered input */
            if (buf[i] == '\n' || buf[i] == '\r') {
                return (int)(i + 1);
            }
        }
        return (int)count;  /* Number of bytes read */
    default:
    
        if (fd >= STD_FD_COUNT && fd < MAX_OPEN_FILES && fd_table[fd]) {
            size_t br;
            
            if ((r->_errno = ext4_fread(fd_table[fd], buf, count, &br)))
                return -1;
            
            return br;
        }
        if(fd > MAX_OPEN_FILES)
        {
            printf("Too many open files!\n");
        }
        if(!fd_table[fd])
        {
            printf("No FD in table\n");
        }
        if(fd < STD_FD_COUNT)
        {
            printf("Wierd STD stream?\n");
        }
        r->_errno = EBADF;
        
        return -1;
    }
}





// Helper to allocate a file descriptor
static int allocate_fd(ext4_file *fp, const char* path) {
    for (int i = STD_FD_COUNT; i < MAX_OPEN_FILES; ++i) {
        if (!fd_table[i] || chek_path_file(path)) {
            fd_table[i] = fp;
            strcpy(fd_paths[i], path);
            return i;
        }
    }
    return -1; // No free descriptors
}
// Helper to free a file descriptor
static void free_fd(int fd) {
    if (fd >= 0 && fd < MAX_OPEN_FILES) {
        fd_table[fd] = NULL;
        memset(fd_paths[fd], 0, sizeof(*fd_paths));
    }
}


// _open_r implementation (newlib uses this form)
int _open_r(struct _reent *r, const char *path, int flags, int mode) {
    (void)mode; //TODO: make mode work!    
    char f_path[256];
    char *p_ptr = format_path((char*)path, f_path);
    ext4_file *fp = malloc(sizeof(ext4_file));
    if (!fp) {
        r->_errno = ENOMEM;
        return -1;
    }

    if ((r->_errno = ext4_fopen2(fp, p_ptr, flags))) {
        DBG_PRINTF("Kaj si izmislio ): %d\n", r->_errno);
        free(fp);
        return -1;
    }
    int fd = allocate_fd(fp, path);
    if (fd < 0) {
        ext4_fclose(fp); free(fp);
        r->_errno = EMFILE;
        return -1;
    }
    r->_errno = 0;
    return fd;
}

// _close_r implementation
int _close_r(struct _reent *r, int fd) {
    if (fd < STD_FD_COUNT || fd >= MAX_OPEN_FILES || !fd_table[fd]) {
        r->_errno = EBADF;
        return -1;
    }
    r->_errno = ext4_fclose(fd_table[fd]);
    free(fd_table[fd]);
    free_fd(fd);
    if(r->_errno)
        return -1;
    return 0;
}


// Process control - minimal implementations
int _getpid_r(struct _reent *r) { return 1; }
int _kill_r(struct _reent *r, int pid, int sig) { r->_errno = ENOSYS; return -1; }
int _link_r(struct _reent *r, const char *old, const char *new) { r->_errno = EMLINK; return -1; }