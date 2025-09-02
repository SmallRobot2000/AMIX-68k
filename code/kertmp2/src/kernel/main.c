#include<stdio.h>
#include<stdint.h>
#include <sys/types.h>
#include <string.h>
#include <ext4.h>
#include <malloc.h>
#include <sys_amix.h>
#include <kernel_syscalls.h>
static inline int syscall_trap1(uintptr_t r, int callno, uintptr_t arg1, uintptr_t arg2, uintptr_t arg3)
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
extern void init_stubs();
extern int init_FS();
extern int init_proc();

extern void asm_STI();
extern void scheduler_init();
extern int xmodem_receive(char* fname);
extern void* tasks;
extern void init_catcher();

int is_supervisor(void) {
    uint16_t sr;
    
    /* Read the full Status Register into sr */
    asm volatile (
        "move.w %%sr, %0\n"
        : "=d"(sr)
        :
        : "memory"
    );

    return (sr & 0x2000) ? 1 : 0;
}
//extern int _write_r(struct _reent *r, int fd, const void *buf, size_t count);
//We are a fake process, we initialize non process nedded stuff, like processes and syscalls and FS, then we call PID 0
int main()
{

    syscall_trap0(0, 65, 0);
    syscall_trap0(0, 65, 0);
    init_stubs();
    init_catcher();
    scheduler_init();
    syscall_trap0(0, 66, 0);

    if(is_supervisor())
    {
        syscall_trap0(0, 'S', 0);
    }else{
        syscall_trap0(0, 'U', 0);
    }
//    _write_r(NULL, 1, (uintptr_t)"Im in pain", strlen("im in pain"));
    
    
    printf("PAIN\n");
    fflush(stdout);
    syscall_trap1(NULL, SYSCALL_WRITE, 1, (uintptr_t)"Im in pain", strlen("im in pain"));
    while(1);
    //Need to init fs & stubs(over trap #1)
    
    //Make and register block device of CF card
    
    if(init_FS())
    {
        printf("Error initializinf fs\n");
        return -1;
    }
    //Sets up start now call real init
    char *init_path = "sys/init.sys"; //always at 0x200000 si its a binary file
    ext4_file fil;
    size_t br;
    int ret;
    if(syscall_trap0(0x09, 0, NULL) == 's')
    {
        //xmodem_receive(init_path);
    }

    if((ret = ext4_fopen(&fil, init_path, "rw")))
    {
        perror("fopen");
        ext4_umount("/");
    }
    
    if((ret = ext4_fread(&fil, (void*)0x200000, fil.fsize, &br)) || br != fil.fsize)
    {
        errno = ret;
        perror("fread");
        ext4_umount("/");
    }
    ext4_fclose(&fil);
    ext4_umount("/");
    printf("Kernel init OK\n");
    while(1);
}