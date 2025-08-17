// amix-syscalls.c - Using your specific TRAP #0 convention
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/times.h>
#include <sys/errno.h>
#include <sys/time.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/reent.h>  // For struct _reent
#include <fcntl.h>
//Sys stuff
#include<sys_amix.h>

// File descriptor definitions
#define STDIN_FILENO    0
#define STDOUT_FILENO   1
#define STDERR_FILENO   2
#define UART_FILENO     3    // Custom: UART i/os

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



// Process control - minimal implementations
int _getpid_r(struct _reent *r) { return 1; }
int _kill_r(struct _reent *r, int pid, int sig) { r->_errno = ENOSYS; return -1; }
int _link_r(struct _reent *r, const char *old, const char *new) { r->_errno = EMLINK; return -1; }
int _unlink_r(struct _reent *r, const char *name) { r->_errno = ENOENT; return -1; }
int _gettimeofday_r(struct _reent *r, struct timeval *tp, struct timezone *tzp) { return 0; }

enum {
    SYSCALL_OPEN  = 0,
    SYSCALL_CLOSE,
    SYSCALL_READ,
    SYSCALL_WRITE,
    SYSCALL_LSEEK,
    SYSCALL_FSTAT,
    SYSCALL_ISTTY,
    SYSCALL_STAT
};

//kernel SYS calls

static inline int syscall_trap1(uintptr_t r, int callno, uintptr_t arg1, uintptr_t arg2, uintptr_t arg3) //arg4 is ussaly reerant
{
    int ret;
    //printf("Fname add sent:\n %lx",arg1);
    __asm__ volatile (
        "move.l %1, %%d0\n\t"
        "move.l %2, %%d1\n\t"
        "move.l %3, %%d2\n\t"
        "move.l %4, %%d3\n\t"
        "move.l %5, %%d4\n\t"
        "trap #1\n\t"
        "move.l %%d0, %0\n\t"
        : "=r"(ret)
        : "r"(callno), "r"(arg1), "r"(arg2), "r"(arg3), "r"(r)
        : "d0", "d1", "d2", "d3", "d4", "memory"
    );
    //printf("ret got= %d\n",ret);
    return ret;
}


// _open_r: open file
int _open_r(struct _reent *r, const char *name, int flags, int mode) {
    return syscall_trap1((uintptr_t)r, SYSCALL_OPEN, (uintptr_t)name, (uintptr_t)flags, (uintptr_t)mode);
}

// _close_r: close file descriptor
int _close_r(struct _reent *r, int fd) {
    return syscall_trap1((uintptr_t)r, SYSCALL_CLOSE, (uintptr_t)fd, 0, 0);
}

// _read_r: read from fd into buffer
int _read_r(struct _reent *r, int fd, void *buf, size_t count) {
    return syscall_trap1((uintptr_t)r, SYSCALL_READ, (uintptr_t)fd, (uintptr_t)buf, (uintptr_t)count);
}

// _write_r: write to fd from buffer
int _write_r(struct _reent *r, int fd, const void *buf, size_t count) {
    return syscall_trap1((uintptr_t)r, SYSCALL_WRITE, (uintptr_t)fd, (uintptr_t)buf, (uintptr_t)count);
}

// _lseek_r: seek fd
int _lseek_r(struct _reent *r, int fd, int offset, int whence) {
    return syscall_trap1((uintptr_t)r, SYSCALL_LSEEK, (uintptr_t)fd, (uintptr_t)offset, (uintptr_t)whence);
}

// _fstat_r: stat file descriptor
int _fstat_r(struct _reent *r, int fd, void *statbuf) {
    return syscall_trap1((uintptr_t)r, SYSCALL_FSTAT, (uintptr_t)fd, (uintptr_t)statbuf, 0);
}

// _isatty_r: test if fd is tty
int _isatty_r(struct _reent *r, int fd) {
    return syscall_trap1((uintptr_t)r, SYSCALL_ISTTY, (uintptr_t)fd, 0, 0);
}

// _stat_r: stat a filename
int _stat_r(struct _reent *r, const char *name, void *statbuf) {
    return syscall_trap1((uintptr_t)r, SYSCALL_STAT, (uintptr_t)name, (uintptr_t)statbuf, 0);
}