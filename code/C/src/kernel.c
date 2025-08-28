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
#include <process.h>
#include <kernel.h>
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

extern void asm_STI();
extern void asm_CLI();


PARTITION VolToPart[FF_VOLUMES] = {
        {0, 1},    /* "0:" ==> 1st partition in physical drive 0 */
};
BYTE work[FF_MAX_SS];         /* Working buffer */
LBA_t plist[] = {50, 50, 0};  /* Divide the drive by 2 */
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

int kernel_init()
{
    FRESULT f_res;
    _WORKING_PROGRAM_ADD = DEFAULT_PROGRAM_ADD;
    _WORKING_PROGRAM_MAX_SIZE = DEFAULT_PROGRAM_MAX_SIZE;
    _SYS_VER_STR = DEFAULT_STS_VER_STR;
    //setenv("SYS_VER_STR",DEFAULT_STS_VER_STR,1);
    //printf("%s\n",getenv("SYS_VER_STR"));
    strcpy(_SYS_PATH,SYS_PATH);
    strcpy(_SRC_PATH,SRC_PATH);
    strcpy(_BIN_PATH,BIN_PATH);
    printf("System path: %s\nBinary path: %s\nSource path: %s\n",_SYS_PATH,_BIN_PATH,_SRC_PATH);
   
    
    f_res = f_stat(_SRC_PATH,NULL);
    if(f_res == FR_NO_PATH || f_res == FR_NO_FILE)
    {
        f_res = f_mkdir(_SYS_PATH);
        if(f_res && f_res != FR_EXIST)
        {
            errno = fatfs_to_errno(f_res);
            return -2;
        }
        f_res = f_mkdir(_BIN_PATH);
        if(f_res && f_res != FR_EXIST)
        {
            errno = fatfs_to_errno(f_res);
            return -3;
        }
        f_res = f_mkdir(_SRC_PATH);
        if(f_res && f_res != FR_EXIST)
        {
            errno = fatfs_to_errno(f_res);
            return -4;
        }
    }
    printf("All dirs exist\n");
    //Made directory
    FF_DIR dir;
    FILINFO fno;
    f_res = f_chdir(_SRC_PATH);
    
    if(f_res)
    {
        printf("Debug: %s\n",_SRC_PATH);
        printf("Ferror: %d\n",f_res);
        errno = fatfs_to_errno(f_res);
        return -5;
    }

    printf("Opening SRC directory\n");
    f_res = f_opendir(&dir, _SRC_PATH);
    
    //setenv("PATH",_BIN_PATH,1);
    
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
                //return -6;
            }else{
                printf("... OK\n");
            }
        }
    }else{
        errno = fatfs_to_errno(f_res);
        return -7;
    }
    return 0;
}

void kernel_start() //we dont return this is PID 0 process
{
    //clear_screen();


//Mnt FS
    
    FRESULT f_res;
    if(((f_res = f_mount(&fs,"/",0)) != FR_OK) || (f_res = f_chdir("/")) != FR_OK)
    {
            printf("Error  FS %d\n", f_res);
            errno = fatfs_to_errno(f_res);
            perror("kernel");
        
        //Make FS
        LBA_t plist[] = {100, 0};  /* Whole drive */
        f_fdisk(0, plist, work);
        
        if((f_res = f_mkfs("", NULL, work, FF_MAX_SS)) != FR_OK)
        {
            printf("Cant create FS %d\n", f_res);
            errno = fatfs_to_errno(f_res);
            perror("kernel");
            while(1);
        }
        if((f_res = f_mount(&fs,"/",0)) != FR_OK)
        {
            printf("Cant create FS %d\n", f_res);
            errno = fatfs_to_errno(f_res);
            perror("kernel");
            while(1);
        }

        if((f_res = f_chdir("/")) != FR_OK)
        {
            printf("Cant recover FS %d\n", f_res);
            errno = fatfs_to_errno(f_res);
            perror("kernel");
            while(1);
        }
    }
    printf("Done with FS\n");
    
    if(f_res != FR_OK)
    {
        errno = fatfs_to_errno(f_res);
        printf("Error Mounting drive %d\n",f_res);
        perror("Kernel");
        while(1); 
        
    }

    trap1_init();
    init_catcher();
    rtc_init();
    history_start();

    int err;
    if((err = kernel_init()) != 0)
    {
        printf("Error during init of kernel %d\n",err);
        perror("Kernel");
        while(1);
    }
    f_chdir("/");
    
    printf("Krnel init done!\n");
    printf("Kernel done PID %lu\n",cur_pid);
    fflush(stdout);
    if(create_task(shell_start, NULL, 0, NULL) == NULL)
    {
      printf("Error starting shell!\n");
    }
    
    
    while(1); //nyhing to do for now


    
}


