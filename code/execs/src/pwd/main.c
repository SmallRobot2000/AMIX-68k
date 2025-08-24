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

//LS
int main(int argc, char *argv[], char *envp[])
{
    char* str = malloc(256);
    char* path = getcwd(str, 256);

    if(!path)
    {
        return -1;
    }
    printf("%s\n",path);
    return 0;
}
