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

int main(int argc, char *argv[], char *envp[])
{
    char* str = malloc(200);
    chdir("/hey");
    printf("PWD: %s\n",getcwd(str,200));


    return 69;
}
