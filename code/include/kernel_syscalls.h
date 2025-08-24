#include <sys/unistd.h>


void trap1_init(void);
//extern inline int syscall_trap1(uintptr_t r, int callno, uintptr_t arg1, uintptr_t arg2, uintptr_t arg3);
enum {
    SYSCALL_OPEN  = 0,
    SYSCALL_CLOSE,
    SYSCALL_READ,
    SYSCALL_WRITE,
    SYSCALL_LSEEK,
    SYSCALL_FSTAT,
    SYSCALL_ISTTY,
    SYSCALL_STAT,
    SYSCALL_TIME,
    SYSCALL_CWD,
    SYSCALL_CD,
    SYSCALL_OPENDIR,
    SYSCALL_CLOSEDIR,
    SYSCALL_READDIR
};

