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
#include <shell.h>
#include <kernel_syscalls.h>
#include <RTC.h>
FATFS fs;
#define BIN_PATH "/bin/"
#define SYS_PATH "/sys/"
#define SRC_PATH "/sys/src/"
#define DEFAULT_PROGRAM_ADD 0x200000
#define DEFAULT_PROGRAM_MAX_SIZE 0x20000 //128k
#define DEFAULT_STS_VER_STR "AMIX system with kernel/shell v0.0.0 alfa"
char _SRC_PATH[256];
char _BIN_PATH[256];
char _SYS_PATH[256];
uint32_t _WORKING_PROGRAM_ADD;
uint32_t _WORKING_PROGRAM_MAX_SIZE;
char* _SYS_VER_STR;
void clear_screen()
{
    sys_scroll(32);
    syscall_trap0(0x0CL,0x00L,0x00); //set cursor to 0,0
}
void kernel_panic_print(char* f_str, int err_code)
{
    printf("KERNEL PANIC\n");
    printf("%s%d\n",f_str,err_code);
}

int kernel_start()
{
    //clear_screen();
    FRESULT f_res;
    //Initialize everything
    printf("Starting kernel SYSCALL\n");
    setenv("PWD","/",1);
    trap1_init();
    rtc_init();
    
    _WORKING_PROGRAM_ADD = DEFAULT_PROGRAM_ADD;
    _WORKING_PROGRAM_MAX_SIZE = DEFAULT_PROGRAM_MAX_SIZE;
    _SYS_VER_STR = DEFAULT_STS_VER_STR;
    //setenv("SYS_VER_STR",DEFAULT_STS_VER_STR,1);
    //printf("%s\n",getenv("SYS_VER_STR"));
    strcpy(_SYS_PATH,SYS_PATH);
    strcpy(_SRC_PATH,SRC_PATH);
    strcpy(_BIN_PATH,BIN_PATH);
    printf("System path: %s\nBinary path: %s\nSource path: %s\n",_SYS_PATH,_BIN_PATH,_SRC_PATH);
    //Init fs
    f_res = f_mount(&fs,"0:",0); //Default and only drive
    if(f_res != FR_OK)
    {
        kernel_panic_print("File system not able to mount!\nKernel not able to continue!\nError code: ",(int)f_res);
        return -1; //error       
        
    }
    history_start();
    f_res = f_stat(_SRC_PATH,NULL);
    if(f_res == FR_NO_PATH || f_res == FR_NO_FILE)
    {
        f_res = f_mkdir(_SYS_PATH);
        if(f_res && f_res != FR_EXIST)
        {
            kernel_panic_print("Not able to make system directory!\nError code: ", f_res);
            return -1;
        }
        f_res = f_mkdir(_BIN_PATH);
        if(f_res && f_res != FR_EXIST)
        {
            kernel_panic_print("Not able to make binary directory!\nError code: ", f_res);
            return -1;
        }
        f_res = f_mkdir(_SRC_PATH);
        if(f_res && f_res != FR_EXIST)
        {
            kernel_panic_print("Not able to make source directory!\nError code: ", f_res);
            return -1;
        }

    }else if(f_res)
    {
        kernel_panic_print("Not able to test for source directory!\nError code: ", f_res);
        return -2; //passable error
    }


    if(f_res)
    {
        kernel_panic_print("Not able to make source directory\nError code: ", f_res);
        return -2;
    }

    //Made directory
    FF_DIR dir;
    FILINFO fno;
    f_res = f_chdir(_SRC_PATH);
    
    if(f_res)
    {
        kernel_panic_print("Not able go to source directory\nError code: ", f_res);
        return -2;
    }
    setenv("PWD",_SRC_PATH,1);
    setenv("PATH",_BIN_PATH,1);
    f_res = f_opendir(&dir, _SRC_PATH);
    
    char binPath[256];
    char srcPath[256];
    if(f_res == FR_OK)
    {
        for(;;)
        {
            f_res = f_readdir(&dir, &fno);
            if(fno.fname[0] == 0) break; //End
            strcpy(binPath, _BIN_PATH);
            strcpy(srcPath, _SRC_PATH);
            strcat(srcPath, fno.fname);
            const char* dot = strrchr(fno.fname, '.');
            if (!dot || dot == fno.fname){
                strcat(binPath,fno.fname); 
            }else{
                size_t len = dot - fno.fname;
                strncat(binPath, fno.fname, len);
            }
            printf("Realocating %s", srcPath);
            fflush(stdout);
            uint32_t radd = load_and_file_elf(srcPath, (void *)_WORKING_PROGRAM_ADD, binPath);
            if(radd != _WORKING_PROGRAM_ADD)
            {
                printf("... Error Incorect address %08lX\n",radd);
            }else{
                printf("... OK\n");
            }
        }
    }else{
        kernel_panic_print("Not able to open source directory!\nError code: ", f_res);
        return -2;
    }
    shell_start();

    
    return 0;
    
}


