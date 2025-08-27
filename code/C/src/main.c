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
#include <process.h>

extern void asm_STI();

int main(int argc, char *argv[]) 
{
    
       
//Need to init first proces and commit suicide
   scheduler_init();
    //Make kernel task with PID 0
   if(create_task(kernel_start,NULL,0,NULL) == NULL)
   {
       printf("Error starting kernel process!");
       while(1);
   }
    //kernel_start();
    while(1);
    scheduler_start();
    int n;
    while(1)    //This will hapen maybe once
    {
        if(n%42 == 3){n = 492;}
        n++;
        printf("Hi\n");
    }
    return 0;
}




