#include <sys/unistd.h>

#ifndef KERNEL_SYSCALL
#define KERNEL_SYSCALL

void trap1_init(void);
int syscall_trap1(uintptr_t r, int callno, uintptr_t arg1, uintptr_t arg2, uintptr_t arg3);

#endif