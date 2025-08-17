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

extern int _open_r(struct _reent *r, const char *name, int flags, int mode);
int main(int argc, char *argv[], char *envp[])
{

    
    printf("TEST from env: %s\n",getenv("TEST"));
    printf("FOO from env: %s\n",getenv("FOO"));
    printf("Hello from new program!\nargc: %d\nMe name is:%s\n",argc,argv[0]);
    FILE *fd = fopen("HEY.TXT", "w+");
    struct _reent r = {0};
    //int res = _open_r(&r, "/Hey.txt", O_RDWR | O_CREAT, 0);
    if(fd == NULL)
    {
        printf("Awww cant open file ):\n");
        perror("Errno ");
        return -1;
    }
    if(fputs("Hello, from PRG!\n", fd) < 0)
    {
        perror("Errno ");
        return -1;
    }
    fclose(fd);
    printf("Type string!\n");
    char* str = malloc(256);
    //scanf("%s",str);
    printf("Your str: %s\n",str);

    return 1;
}
