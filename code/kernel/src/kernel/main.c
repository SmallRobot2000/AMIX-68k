//#include <stdio.h>
#include <ext4.h>

#include <sys_amix.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

extern struct ext4_blockdev *cf_init();
extern int xmodem_receive(char* name);
extern int _write_r(struct _reent *r, int fd, const void *buf, size_t count);
extern void sys_flush_fifo_UART();


int main()
{
    _write_r(NULL, 1, "ee", 2);
    
    printf("ee\n");
    
    
    //init_stubs();
    struct ext4_blockdev *bdev = cf_init();
    int ret = ext4_device_register(bdev, "/dev/cfa");
    if(ret)
    {
        errno = ret;
        
        perror("reg");
        while(1);
    }
    ret = ext4_mount("/dev/cfa", "/", 0);
    if(ret)
    {
        errno = ret;
        _write_r(NULL, 1, "mount", 5);
        while(1);
    }
    printf("Mount done\nStart xmodem for /sys/init.bin");
   
    
    //xmodem_receive("/kernel/init.bin");
    
    ret = ext4_umount("/");
    if(ret)
    {
        errno = ret;
        perror("mount");
        while(1);
    }
    while(1);
}