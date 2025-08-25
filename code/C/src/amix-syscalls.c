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
#include <ff.h>          // FatFs header
#include <sys/unistd.h>  // For ssize_t etc.
#include <unistd.h>
#include <stddef.h>
#include <errno.h>
#include <RTC.h>
//Sys stuff
#include<sys_amix.h>
#include <stdint.h>

// File descriptor definitions
#define STDIN_FILENO    0
#define STDOUT_FILENO   1
#define STDERR_FILENO   2


#define STD_FD_COUNT 3
#define MAX_OPEN_FILES 8

static FIL *fd_table[MAX_OPEN_FILES] = {0}; // Maps fd -> FIL*

int fatfs_to_errno(FRESULT res) {
    switch(res) {
        case FR_OK:                 return 0;
        case FR_DISK_ERR:           return EIO;
        case FR_INT_ERR:            return EFAULT;
        case FR_NOT_READY:          return ENODEV;
        case FR_NO_FILE:            return ENOENT;
        case FR_NO_PATH:            return ENOENT;
        case FR_INVALID_NAME:       return EINVAL;
        case FR_DENIED:             return EACCES;
        case FR_EXIST:              return EEXIST;
        case FR_INVALID_OBJECT:     return EBADF;
        case FR_WRITE_PROTECTED:    return EROFS;
        case FR_INVALID_DRIVE:      return ENODEV;
        case FR_NOT_ENABLED:        return ENODEV;
        case FR_NO_FILESYSTEM:      return ENODEV;
        case FR_MKFS_ABORTED:       return EFAULT;
        case FR_TIMEOUT:            return ETIMEDOUT;
        case FR_LOCKED:             return EACCES;
        case FR_NOT_ENOUGH_CORE:    return ENOMEM;
        case FR_TOO_MANY_OPEN_FILES:return EMFILE;
        case FR_INVALID_PARAMETER:  return EINVAL;
        default:                   return EIO;  // Unknown error mapped to I/O error
    }
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
    
    return (void *)prev;
}

static void fill_stat_from_file(struct stat *st, DWORD fsize) {
    memset(st, 0, sizeof(struct stat));
    st->st_mode = S_IFREG | 0444;   // Regular file, read-only as default
    st->st_nlink = 1;
    st->st_size = fsize;
    // Set additional fields if needed; mtime/atime/ctime can be set if you extract from FILINFO.fdate/ftime
}

// _fstat_r: info about an open file descriptor
int _fstat_r(struct _reent *r, int fd, struct stat *st) {
    if (!st) {
        if (r) r->_errno = EINVAL;
        return -1;
    }
    if (fd >= 0 && fd < STD_FD_COUNT) {
        // stdin/out/err — character device
        memset(st, 0, sizeof(struct stat));
        st->st_mode = S_IFCHR;
        st->st_nlink = 1;
        return 0;
    }
    if (fd >= STD_FD_COUNT && fd < MAX_OPEN_FILES && fd_table[fd]) {
        // For simplicity, fill only st_size and st_mode as regular file
        fill_stat_from_file(st, f_size(fd_table[fd]));
        return 0;
    }
    if (r) r->_errno = EBADF;
    return -1;
}


int _isatty_r(struct _reent *r, int fd) { 
    return (fd >= 0 && fd <= 2) ? 1 : 0;  // stdin, stdout, stderr, uart are ttys
}

// _lseek_r
off_t _lseek_r(struct _reent *r, int fd, off_t offset, int whence) {
    if (fd < 3) return -1; // Not a file
    FIL *fp = fd_table[fd];
    DWORD newpos;
    switch (whence) {
        case SEEK_SET: newpos = offset; break;
        case SEEK_CUR: newpos = f_tell(fp) + offset; break;
        case SEEK_END: newpos = f_size(fp) + offset; break;
        default: return -1;
    }
    FRESULT fres = f_lseek(fp, newpos);
    if (fres != FR_OK)
    {
        errno = fatfs_to_errno(fres);
        return -1;
    }
    return newpos;
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

// Process control - minimal implementations
int _getpid_r(struct _reent *r) { return 1; }
int _kill_r(struct _reent *r, int pid, int sig) { r->_errno = ENOSYS; return -1; }
int _link_r(struct _reent *r, const char *old, const char *new) { r->_errno = EMLINK; return -1; }

// Unlink (delete) file syscall replacement for newlib with FATfs
int _unlink_r(struct _reent *r, const char *path) {
    FILINFO fno;
    FRESULT res;

    res = f_stat(path, &fno);
    if (res != FR_OK) {
        r->_errno = fatfs_to_errno(res);
        return -1;
    }

    if (fno.fattrib & AM_DIR) {
        r->_errno = EISDIR;
        return -1;
    }

    res = f_unlink(path);
    if (res != FR_OK) {
        r->_errno = fatfs_to_errno(res);
        return -1;
    }

    return 0;
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

// _stat_r: info about a file path (not necessarily open)
int _stat_r(struct _reent *r, const char *path, struct stat *st) {
    if (!st || !path) {
        if (r) r->_errno = EINVAL;
        return -1;
    }

    FILINFO finfo;
#if _USE_LFN
    TCHAR lfn_buf[FF_MAX_LFN + 1];
    finfo.lfname = lfn_buf;
    finfo.lfsize = sizeof(lfn_buf) / sizeof(lfn_buf[0]);
#endif
    FRESULT fres = f_stat(path, &finfo);
    if (fres == FR_OK) {
        memset(st, 0, sizeof(struct stat));
        if (finfo.fattrib & AM_DIR) {
            st->st_mode = S_IFDIR | 0555;
        } else {
            st->st_mode = S_IFREG | 0444;
        }
        st->st_nlink = 1;
        st->st_size = finfo.fsize;
        // Optionally, decode finfo.fdate/finfo.ftime for times here
        return 0;
    } else {
        if (r) r->_errno = ENOENT;
        return -1;
    }
}
// Map ANSI foreground colors (30-37 and 90-97) to 4-bit color values (0-15)
BYTE ansi_fg_code_to_pc_color(int code) {
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
BYTE ansi_bg_code_to_pc_color(int code) {
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

typedef unsigned char BYTE;
typedef unsigned short WORD;

// Dummy color map functions (replace with your implementation)
BYTE ansi_fg_code_to_pc_color(int code);
BYTE ansi_bg_code_to_pc_color(int code);

// Main function: converts input char buffer with ANSI color escapes into WORD buffer with color attributes
size_t _byte_to_word_string(const char* buf, size_t count, WORD *wbuf)
{
    BYTE _text_color_foreground = 0x02;  // green default fg
    BYTE _text_color_background = 0x00;  // black default bg
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
    WORD *wbuf;
    size_t cnt = count;
    switch (fd) {
    case STDOUT_FILENO:
    case STDERR_FILENO:
        wbuf = malloc(count*sizeof(WORD));
        cnt = _byte_to_word_string(buf, cnt, wbuf);

        //if(count != 0){syscall_trap0(0xFL, count, (void *)buf);} //print byte buffer
        if(count != 0){syscall_trap0(0x14L, cnt, (void *)wbuf);} //print word buffer
        free(wbuf);
        return count;   // Return bytes written
    default:
        if (fd >= STD_FD_COUNT && fd < MAX_OPEN_FILES && fd_table[fd])
        {
            UINT bw;
            FRESULT fres = f_write(fd_table[fd], buf, count, &bw);
            if (fres != FR_OK)
            {
                r->_errno = fatfs_to_errno(fres);
                return -1;
            }
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
            UINT br;
            FRESULT fres = f_read(fd_table[fd], buf, count, &br);
            if (fres != FR_OK) {
                r->_errno = fatfs_to_errno(fres);
                return -1;
            }
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
static int allocate_fd(FIL *fp) {
    for (int i = STD_FD_COUNT; i < MAX_OPEN_FILES; ++i) {
        if (!fd_table[i]) {
            fd_table[i] = fp;
            return i;
        }
    }
    return -1; // No free descriptors
}
// Helper to free a file descriptor
static void free_fd(int fd) {
    if (fd >= 0 && fd < MAX_OPEN_FILES) {
        fd_table[fd] = NULL;
    }
}


// _open_r implementation (newlib uses this form)
int _open_r(struct _reent *r, const char *path, int flags, int mode) {
    (void)mode; // FatFs doesn't use mode
    BYTE fatfs_mode = 0;
    if (flags & O_WRONLY) fatfs_mode |= FA_WRITE;
    if (flags & O_RDWR)   fatfs_mode |= FA_READ | FA_WRITE;
    if (flags & O_CREAT)  fatfs_mode |= FA_OPEN_ALWAYS;
    if (!(flags & O_WRONLY)) fatfs_mode |= FA_READ;

    FIL *fp = malloc(sizeof(FIL));
    if (!fp) {
        r->_errno = ENOMEM;
        return -1;
    }

    FRESULT fres = f_open(fp, path, fatfs_mode);
    if (fres != FR_OK) {
        free(fp);
        r->_errno = ENOENT; // Or other mapping
        return -1;
    }
    int fd = allocate_fd(fp);
    if (fd < 0) {
        f_close(fp); free(fp);
        r->_errno = EMFILE;
        return -1;
    }
    return fd;
}

// _close_r implementation
int _close_r(struct _reent *r, int fd) {
    if (fd < STD_FD_COUNT || fd >= MAX_OPEN_FILES || !fd_table[fd]) {
        r->_errno = EBADF;
        return -1;
    }
    f_close(fd_table[fd]);
    free(fd_table[fd]);
    free_fd(fd);
    return 0;
}