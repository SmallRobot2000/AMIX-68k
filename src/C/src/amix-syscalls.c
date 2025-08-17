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

// Process control - minimal implementations
int _getpid_r(struct _reent *r) { return 1; }
int _kill_r(struct _reent *r, int pid, int sig) { r->_errno = ENOSYS; return -1; }
int _link_r(struct _reent *r, const char *old, const char *new) { r->_errno = EMLINK; return -1; }
int _unlink_r(struct _reent *r, const char *name) { r->_errno = ENOENT; return -1; }
int _gettimeofday_r(struct _reent *r, struct timeval *tp, struct timezone *tzp) { return 0; }

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

/* POSIX‐style _write stub that calls the reentrant version */
int _write_r(struct _reent *r, int fd, const void *buf, size_t count) {
    switch (fd) {
    case STDOUT_FILENO:
    case STDERR_FILENO:
        if(count != 0){syscall_trap0(0xFL, count, (void *)buf);} //print string
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