#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
#include <xmodem.h>
#include <elf_loader.h>
#include <kernel.h>
#include <history.h>
#include <stdbool.h>
#include <shell.h>
#include <unistd.h>

extern void trap1_test();


int main(int argc, char *argv[], char *environp[]) 
{

    if(kernel_start() != 0)
    {
        //while(1); //Oh no
    }
    
    while(1)
    {
        shell_loop();
        
        
    }
    return 0;
}
