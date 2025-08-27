#include<stdio.h>
#include<stdint.h>
extern char **environ;

int main(int argc, char *argv[])
{
    //printf("Im a called task, my args:\nargc: %x\nargv: %p\nenv_ptr = %p\n",argc, argv, environ);
    for (int i = 0; environ[i] != NULL; i++) {
        printf("%s\n", environ[i]);
    }
    return 0;
}