#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/reent.h>  // For struct _reent
#include <fcntl.h>
#include <errno.h>
#include <RTC.h>
#include <time.h>

//cd
int main(int argc, char *argv[], char *envp[])
{
    if(argc < 2)
    {
        printf("Uage %s <path> %s %d\n",argv[0],argv[1],argc);
        return -1;
    }else{
        chdir(argv[1]);
    }
    return 0;
}
