//Kernel holds all important IO an SYS functions, but also shell because no multitasking!
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <stdint.h>
#include <elf_loader.h>
#include <history.h>
#include <shell.h>
#include <kernel_syscalls.h>
#include <RTC.h>
#include <process.h>
#include <kernel.h>
#define BIN_PATH "/bin"
#define SYS_PATH "/sys"
#define SRC_PATH "/sys/src"
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


#include<fs/ext4.h>
#include<fs/ext4_blockdev.h>
#include<fs/ext4_mkfs.h>
#include<fs/ext4_fs.h>
#include<stdbool.h>
#include<fs/ext4_super.h>
extern struct ext4_blockdev *cf_init();
struct ext4_blockdev *bdev;
struct ext4_fs fs;
static char *entry_to_str(uint8_t type)
{
	switch (type) {
	case EXT4_DE_UNKNOWN:
		return "[unk] ";
	case EXT4_DE_REG_FILE:
		return "[fil] ";
	case EXT4_DE_DIR:
		return "[dir] ";
	case EXT4_DE_CHRDEV:
		return "[cha] ";
	case EXT4_DE_BLKDEV:
		return "[blk] ";
	case EXT4_DE_FIFO:
		return "[fif] ";
	case EXT4_DE_SOCK:
		return "[soc] ";
	case EXT4_DE_SYMLINK:
		return "[sym] ";
	default:
		break;
	}
	return "[???]";
}

void test_lwext4_dir_ls(const char *path)
{
	char sss[255];
	ext4_dir d;
	const ext4_direntry *de;

	printf("ls %s\n", path);

	int r = ext4_dir_open(&d, path);
    if(r != EOK) return;
	de = ext4_dir_entry_next(&d);

	while (de) {
		memcpy(sss, de->name, de->name_length);
		sss[de->name_length] = 0;
		printf("  %s%s\n", entry_to_str(de->inode_type), sss);
		de = ext4_dir_entry_next(&d);
	}
	ext4_dir_close(&d);
}

__attribute__((optimize("O0"))) int kernel_init_fs()
{
    pause_scheduler();
    ext4_dmask_set(DEBUG_ALL);

    printf("CF init\n");
    bdev = cf_init();

    
    int ret = 0;//ext4_mkfs(fs, bdev, mk_info, F_SET_EXT4);
       
/*
    if((ret = ext4_mount("/dev/cfa","/",0)) != EOK && ret != ENOTSUP)
    {
        errno = ret;
        perror("mount");
        return -1;
    }else if(ret == ENOTSUP) //FS not suported!
    {
*/

        
        //printf("FS not suported, making new FS\n");
        //struct ext4_mkfs_info *mk_info = malloc(sizeof(struct ext4_mkfs_info));
        //memset(mk_info, 0, sizeof(struct ext4_mkfs_info));
        //mk_info->block_size = bdev->lg_bsize;
        //mk_info->label = "CF";
        //mk_info->blocks_per_group = bdev->lg_bcnt/2;
        //mk_info->len = bdev->lg_bcnt;
        //mk_info->bg_desc_reserve_blocks = 16; //IDK 16k?
        //mk_info->dsc_size = 64; //IDK reseve dsc size?
        printf("CF register\n");
        ret = ext4_device_register(bdev, "/dev/cfa");

        goto skip_mkfs;

        struct ext4_mkfs_info *info = malloc(sizeof(struct ext4_mkfs_info));
        memset(info, 0, sizeof(struct ext4_mkfs_info));
        info->block_size = 1024;
        info->journal = false;
        info->label = "CF";
        info->dsc_size = 32;

            
        printf("MKFS\n");
        ret = ext4_mkfs(&fs, bdev, info, F_SET_EXT4);

        
        if(ret != EOK)
        {   
            errno = ret;
            perror("mkfs");
            return ret;
        }
        
	    skip_mkfs:
    
        printf("Mount\n");
        if ((ret = ext4_mount("/dev/cfa","/",0)) != EOK){
            errno = ret;
            perror("mount");
            return ret;
        }

    
        
        
        
    //}
    //printf("Done!\n");    
    resume_scheduler();
    return 0;
}
int kernel_files_init()
{
    //FRESULT f_res;
    _WORKING_PROGRAM_ADD = DEFAULT_PROGRAM_ADD;
    _WORKING_PROGRAM_MAX_SIZE = DEFAULT_PROGRAM_MAX_SIZE;
    _SYS_VER_STR = DEFAULT_STS_VER_STR;
    //setenv("SYS_VER_STR",DEFAULT_STS_VER_STR,1);
    //printf("%s\n",getenv("SYS_VER_STR"));
    strcpy(_SYS_PATH,SYS_PATH);
    strcpy(_SRC_PATH,SRC_PATH);
    strcpy(_BIN_PATH,BIN_PATH);
    //printf("System path: %s\nBinary path: %s\nSource path: %s\n",_SYS_PATH,_BIN_PATH,_SRC_PATH);
   
    
    test_lwext4_dir_ls("/");
    

    //Make some sys folders if they dont exist
    // /bin
    
    printf("Binary path: %s\n",_BIN_PATH);
    int ret = ext4_dir_mk(_BIN_PATH);
    if(ret != EOK) //Err
    {
        errno = ret;
        perror("mkdir");
        return -1;
        
    }
    printf("System path: %s\n",_SYS_PATH);
    ret = ext4_dir_mk(_SYS_PATH);
    if(ret && ret != ENOENT) //Err
    {
        errno = ret;
        perror("mkdir");
        return -2;
        
    }
    printf("Source path: %s\n",_SRC_PATH);
    ret = ext4_dir_mk(_SRC_PATH);
    if(ret && ret != ENOENT) //Err
    {
        errno = ret;
        perror("mkdir");
        return -3;
        
    }

    printf("All dirs exist\n");

    test_lwext4_dir_ls("/sys/src");
    

    //--------------------------
    struct ext4_dir dir;
    ret = ext4_dir_open(&dir, "/sys");
    if(ret)
    {
        errno = ret;
        perror("dir_open");
        return -4;
    }
    ext4_dir_close(&dir);


    
    int r;

    
    printf("Opening SRC directory\n");
    r = ext4_dir_open(&dir, _SRC_PATH);
    if(r != EOK) return -5;
    //setenv("PATH",_BIN_PATH,1);
    
    char binPath[256];
    char srcPath[256];

    const ext4_direntry *dir_en;

    do
    {
        dir_en = ext4_dir_entry_next(&dir);
        if(dir_en == NULL) break;
        if(strcmp((const char*)dir_en->name, ".") == 0 || strcmp((const char*)dir_en->name, "..") == 0) continue; //skip dot dirs
        strcpy(binPath, _BIN_PATH);
        strcat(binPath, (const char*)dir_en->name);
        strcpy(srcPath, _SRC_PATH);
        strcat(srcPath, "/");
        strcat(srcPath, (const char*)dir_en->name);

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
    }while(dir_en);
    
      
    return 0;
}
void kernel_error_fatal(int err)
{
    printf("Fatal kernel error %d\n",err);
    errno = err;
    perror("Kernel");
    printf("Unmount\n");
    err = ext4_cache_flush("/");
    if(err)
    {
        errno = err;
        perror("flush");
    }
    err = ext4_umount("/");
    if(err)
    {
        errno = err;
        perror("umount");
    }
    
    while(1);
}
void kernel_start() //we dont return this is PID 0 process
{
    printf("Kernel start!\n");
    int err = kernel_init_fs();
    if(err) kernel_error_fatal(err);
    trap1_init();
    init_catcher();
    rtc_init();
    history_start();
    
    
    if((err = kernel_files_init()) != 0)
    {
        kernel_error_fatal(err);
        
    }
    //f_chdir("/");
    
    printf("Krnel init done!\n");
    printf("Kernel done PID %lu\n",cur_pid);
    
    fflush(stdout);
    if(create_task(shell_start, NULL, 0, NULL) == NULL)
    {
      printf("Error starting shell!\n");
    }
    
    
    while(1); //nyhing to do for now


    
}


