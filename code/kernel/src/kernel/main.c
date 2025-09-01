#include<stdio.h>
#include<stdint.h>
#include <sys/types.h>
#include <string.h>
extern void init_stubs();
extern int init_FS();
extern int init_proc();

extern _ssize_t _stub_write_r(struct _reent *r, int fd, const void *buf, size_t count);

//We are a fake process, we initialize non process nedded stuff, like processes and syscalls and FS, then we call PID 0
int main()
{
    char* kern_msg = "Kernel starting...";
    _stub_write_r(NULL, 1, kern_msg, strlen(kern_msg));
    printf("Kernel starting...\n");
    fflush(stdout);
    //Need to init fs & stubs(over trap #1)
    init_stubs();
    printf("Kernel stubs init done\n");
    //Init FS
    if(init_FS())
    {
        printf("File system failed to initialize\n");
        while(1);
    }
    if(init_proc())
    {
        printf("Task system failed to initialize\n");
        while(1);
    }
    printf("Kernel init OK\n");
    while(1);
}