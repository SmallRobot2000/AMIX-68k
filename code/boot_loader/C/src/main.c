#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <fs/ext4.h>
#include <fs/ext4_fs.h>
#include <stdint.h>
#include <xmodem.h>
//#include <kernel.h>
//#include <history.h>
#include <stdbool.h>
//#include <shell.h>
//#include <unistd.h>
#include <process.h>
#include <errno.h>
#include <stdbool.h>
extern void asm_STI();
extern char* format_path(char *path);

extern struct ext4_blockdev *cf_init();
struct ext4_blockdev *bdev;
struct ext4_fs fs;
//int main(int argc, char *argv[]) 

char *my_env[] = {
    "PATH=/bin",
    "MYVAR=myvalue",
    NULL
};
extern void trap1_init(void);

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
int init()
{
    //printf("Scheduler init...\n");
    //scheduler_init();
    printf("Catcher init...\n");
    init_catcher();
    printf("SYScall init...\n");
    //trap1_init();
    printf("Done init...\n");
    return 0;
}
extern int *call_address(uint32_t add, char **argv, int argc);
extern uint32_t load_elf(const char *path, void *base_addr);
extern bool is_elf_file(const char *path);
int main()
{

//Need to init first proces and commit suicide
    
    //Make kernel task with PID 0
    //We are init process we do initial mount and unmount to load kernel in sys/kernel.sys
    printf("CF init...\n");
    bdev = cf_init();
    bool lock = false;
    ext4_file fil;

    int ret = init();
    if(ret != EOK)
        {   
            errno = ret;
            perror("init");
            return ret;
        }


    ret = ext4_device_register(bdev, "/dev/cfa");
    if(ret != EOK)
        {   
            errno = ret;
            perror("dev reg");
            return ret;
        }
    printf("Mount\n");
        if ((ret = ext4_mount("/dev/cfa","/",0)) != EOK){
            errno = ret;
            perror("mount");
            return ret;
        }
    if(syscall_trap0(0x09, 0, NULL) == 0x1B)
    {
        goto skip_dialog;
    }
        
    printf("Press 'x' to receve new /sys/kernel.sys\nPress any other key to continue\n");
    char ch;
    bool elf;
    ask:
    ch = syscall_trap0(0x08, 0, NULL);
    if(ch == 'x')
    {
        printf("Receving /sys/kernel.sys over xmodem\n");
        xmodem_receive("/sys/kernel.sys");
    }
    if(ch == 'l')
    {
        test_lwext4_dir_ls("/sys");
        goto ask;
    }
    skip_dialog:
    
    elf = is_elf_file("/sys/kernel.sys");
    char *argv[]=
    {
        "/sys/kernel.sys",
        NULL
    };
    if(!elf)
    {

    
        if(ext4_fopen(&fil, "/sys/kernel.sys","r"))
        {
            perror("Fopen");
            while(1);
        }

        uint32_t size = (uint32_t)ext4_fsize(&fil);

        printf("Kernel size %lu\n", size);
        //void* add = malloc(256*1024); //256k
        printf("Launching kernel as bin...\n");
        size_t br;
        void* tmp = malloc(1);
        free(tmp);
        void* off = malloc(0x200000-(uint32_t)tmp);
        free(off);
        void* work = malloc(256*1024);
        printf("TMP: %p, off: %p work: %p\n",tmp, off, work);

        ret = ext4_fread(&fil, (void*)0x200000, size, &br);
        if(ret || br != size)
        {
            errno = ret;
            printf("Read %lu of %lu\n",br, size);
            perror("Fread");
            while(1);
        }
        printf("Loaded %lu bytes\n",br);
        ext4_fclose(&fil);
        //dump_memory((void*)0x200000, 256);
        //dump_memory((void*)0x200000+size-256, 256);
        call_address(0x200000, argv, 1);
    }else{
    uint32_t ret1 = load_elf("/sys/kernel.sys", (void*)0x200000);
    if(ret1 != 0x200000)
    {
        
        printf("Error loading kernel: %lx\n",ret1);
        lock = true;
        while(1);
    }
    
    //ret = ext4_umount("/");
    //if(ret)
    //{
    //    errno = ret;
    //    perror("umount");
    //}else{
    //    printf("Umount fine\n");
    //}

    
    if(lock)
        while(1);
    printf("Launching kernel as elf...\n");
    
    void* idksal = malloc(256);
    printf("madsa %p\n",idksal);
    call_address(0x200000, argv, 1);
    }
    while(1);
   
   // //kernel_start();
   // 
   // 
   //();
   ///while(1);
   // while(1);
   // 
   // int n;
   // while(1)    //This will hapen maybe once
   // {
   //     if(n%42 == 3){n = 492;}
   //     n++;
   //     printf("Hi\n");
   // }
    return 0;
}




