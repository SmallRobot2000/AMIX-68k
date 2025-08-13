#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
#include <stdlib.h>

int main(int argc, char *argv[], char *envp[])
{

    printf("TEST from env: %s\n",getenv("TEST"));
    printf("FOO from env: %s\n",getenv("FOO"));
    printf("Hello from new program!\nargc: %d\nMe name is:%s\n",argc,argv[0]);
    return 1;
}
