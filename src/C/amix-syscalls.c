// amix-syscalls.c - Using your specific TRAP #0 convention
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/times.h>
#include <sys/errno.h>
#include <sys/time.h>
#include <stdio.h>

//Sys stuff
#include<sys_amix.h>

// File descriptor definitions
#define STDIN_FILENO    0
#define STDOUT_FILENO   1
#define STDERR_FILENO   2
#define UART_FILENO     3    // Custom: UART output

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

/* Reentrant write stub using TRAP #0 */
int _write_r(struct _reent *r, int fd, const void *buf, size_t count) {
    const char *cbuf = buf;
    size_t i;
    
    switch (fd) {
    case STDOUT_FILENO:
    case STDERR_FILENO:
        for (i = 0; i < count; i++) {
            /* TRAP #0, D1 = syscall number (0 = write char),
               D0 = character, A0 = unused here */
            syscall_trap0(0L, (long)(unsigned char)cbuf[i], 0L);
        }
        return (int)count;  /* Number of bytes written */

    default:
        r->_errno = EBADF;
        return -1;
    }
}
// Memory management
void *_sbrk_r(struct _reent *r, ptrdiff_t incr) {
    extern char _end;
    static char *heap_end = 0;
    
    if (heap_end == 0) {
        heap_end = &_end;
    }
    
    char *prev_heap_end = heap_end;
    heap_end += incr;
    return (void *)prev_heap_end;
}

// File operations - minimal implementations
int _close_r(struct _reent *r, int fd) { 
    return 0; // Always succeed for now
}

int _fstat_r(struct _reent *r, int fd, struct stat *st) { 
    st->st_mode = S_IFCHR;  // Character device
    return 0;
}

int _isatty_r(struct _reent *r, int fd) { 
    return (fd >= 0 && fd <= 3) ? 1 : 0;  // stdin, stdout, stderr, uart are ttys
}

int _lseek_r(struct _reent *r, int fd, off_t pos, int whence) { 
    return 0; 
}


// Process control - minimal implementations
int _getpid_r(struct _reent *r) { return 1; }
int _kill_r(struct _reent *r, int pid, int sig) { r->_errno = ENOSYS; return -1; }
int _link_r(struct _reent *r, const char *old, const char *new) { r->_errno = EMLINK; return -1; }
int _unlink_r(struct _reent *r, const char *name) { r->_errno = ENOENT; return -1; }
int _stat_r(struct _reent *r, const char *file, struct stat *st) { st->st_mode = S_IFCHR; return 0; }
int _gettimeofday_r(struct _reent *r, struct timeval *tp, struct timezone *tzp) { return 0; }


/* POSIX‐style _write stub that calls the reentrant version */
int _write(int fd, const void *buf, size_t count) {
    const char *cbuf = buf;
    size_t i;
    switch (fd) {
    case STDOUT_FILENO:
    case STDERR_FILENO:
        for (i = 0; i < count; i++) {
            // Using newlib’s reentrant stub:
            _write_r(_REENT, fd, &cbuf[i], 1);
            // Or if you bypass it:
            // syscall_trap0(3, (long)cbuf[i], 0);
        }
        return count;   // Return bytes written

    default:
        // Indicate unsupported FD
        errno = EBADF;
        return -1;
    }
}

int _read(int fd, char *buf, size_t len) {
    if (fd == STDIN_FILENO) {
        // Read from keyboard
        return sys_read_keyboard_string(buf, len);
    } else {
        return -1;
    }
}