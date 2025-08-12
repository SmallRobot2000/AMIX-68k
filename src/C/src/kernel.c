//Kernel holds all important IO an SYS functions, but also shell because no multitasking!
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
#include <elf_loader.h>
#include <history.h>

FATFS fs;

void kernel_panic_print(char* f_str, int err_code)
{
    printf("KERNEL PANIC\n");
    printf("%s%d\n",f_str,err_code);
}

int kernel_start()
{
    FRESULT f_res;
    //Initialize everything

    //Init fs
    f_res = f_mount(&fs,"0:",0); //Default and only drive
    if(f_res != FR_OK)
    {
        kernel_panic_print("File system not able to mount!\nKernel not able to continue!\nError code: ",(int)f_res);
        return -1; //error       
        
    }

    history_start();
    return 0;
    
}


