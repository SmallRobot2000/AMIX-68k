#include <fs/ext4.h>


extern struct ext4_blockdev *cf_init();
int init_FS()
{
    //Make and register block device of CF card
    struct ext4_blockdev *bdev = cf_init();
    int ret;
    if((ret = ext4_device_register(bdev, "/dev/cf")))
    {
        errno = ret;
        perror("init_FS:register");
        return -1;
    }
    if((ret = ext4_mount("/dev/cf", "/", 0)))
    {
        errno = ret;
        perror("init_FS:mount");
        return -1;
    }
    return 0;
}