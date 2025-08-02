// amix-syscalls.c - Using your specific TRAP #0 convention
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/times.h>
#include <sys/errno.h>
#include <sys/time.h>
#include <stdio.h>

// External assembly functions
extern long syscall_trap0(long syscall_num, long param);
extern void sys_print_screen(char c);
extern void sys_print_uart(char c);
extern char sys_get_keyboard(void);
extern int sys_write_screen_string(const char *str, int len);
extern int sys_write_uart_string(const char *str, int len);
extern int sys_read_keyboard_string(char *buf, int maxlen);

// File descriptor definitions
#define STDIN_FILENO    0
#define STDOUT_FILENO   1
#define STDERR_FILENO   2
#define UART_FILENO     3    // Custom: UART output

// Newlib system calls using your TRAP #0 interface
int _write_r(struct _reent *r, int fd, const char *buf, size_t len) {
    int result = 0;
    
    switch (fd) {
        case STDOUT_FILENO:
            result = sys_write_screen_string(buf, len);
            break;
        case STDERR_FILENO:
            // Write to screen
            result = sys_write_screen_string(buf, len);
            break;
            
        case UART_FILENO:
            // Write to UART
            result = sys_write_uart_string(buf, len);
            break;
            
        default:
            r->_errno = EBADF;
            return -1;
    }
    
    return result;
}

int _read_r(struct _reent *r, int fd, char *buf, size_t len) {
    if (fd == STDIN_FILENO) {
        // Read from keyboard
        return sys_read_keyboard_string(buf, len);
    } else {
        r->_errno = EBADF;
        return -1;
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
