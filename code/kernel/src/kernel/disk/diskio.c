#include <sys_amix.h>
#include<fs/ext4.h>
#include<fs/ext4_blockdev.h>
#include<stdlib.h>
#include<stdbool.h>
#include<string.h>
struct cf_stat
{
    bool locked;
    int disk_id;
};


// Stub block device interface functions
int blockdev_open(struct ext4_blockdev *bdev) {
    // Open your device here (e.g., fopen a file or init hardware)
    //printf("Block device open\n");
    //CF init nothing to do
    if(((struct cf_stat *)bdev->bdif->p_user)->disk_id != 0)
    {
        return -1;
    }
    return 0; // Success
}

// Stub block device read function
int bd_read(struct ext4_blockdev *bdev, void *buf, uint64_t blk_id, uint32_t blk_cnt) {


                                                        /* Reject >24-bit sector numbers */
    if((blk_cnt & 0xFF000000U) != 0) //invalid
    {
        printf("Invalid drive read\n");
        return -1;
    }
    
    //Convert to 512
    uint8_t *ptr = buf;
    uint32_t remaining = blk_cnt*2; //because block size is set to 1024 but phisical is 512
    uint64_t sector = blk_id*2; //bacause 1024 to 512

    //printf("DISK READ %lu\n", remaining);

    while (remaining > 0) { //two times because of 1024 sectors
        /* Read at most 255 sectors per call */
        uint32_t chunk = (remaining > 255) ? 255 : remaining;
        uint32_t lba   = sector;  /* 24-bit LBA */

        /* sys_read_sectors(sector_count, data_ptr, start_LBA) */
        sys_read_sectors(chunk, ptr, lba);

        /* Advance pointers and counters */
        ptr       += chunk * 512;
        sector    += chunk;
        remaining -= chunk;

  
    }
    //Normal operation
    return 0; // success
}

// Stub block device write function
int bd_write(struct ext4_blockdev *bdev, const void *buf, uint64_t blk_id, uint32_t blk_cnt) {


    
                                                        /* Reject >24-bit sector numbers */
    if((blk_id & 0xFF000000U) != 0) //invalid
    {
        printf("Invalid drive write\n");
        return -1;
    }
    //Normal operation


    //Convert to 512
    uint8_t *ptr = (uint8_t*)buf;
    uint32_t remaining = blk_cnt*2; //because block size is set to 1024 but phisical is 512
    uint64_t sector = blk_id*2; //bacause 1024 to 512

    //printf("DISK WRITE %lu\n", remaining);

    while (remaining > 0) { //two times because 
        /* Write at most 255 sectors in one syscall */
        uint32_t chunk = (remaining > 255) ? 255 : remaining;
        uint32_t  lba   = sector;               /* current LBA (24-bit valid) */

        /* sys_write_sectors(sector_count, data_ptr, start_LBA) */
        sys_write_sectors(chunk, ptr, lba);

        /* Advance */
        ptr       += chunk * 512;  /* bytes per sector */
        sector    += chunk;
        remaining -= chunk;
    }

    return 0; // success
}


int blockdev_close(struct ext4_blockdev *bdev) {
    // Close your device here (e.g., fclose or HW de-init)
    //printf("Block device close\n");
    //Nothing to do
    if(((struct cf_stat *)bdev->bdif->p_user)->disk_id != 0)
    {
        return -1;
    }
    return 0; // Success
}

int bd_lock(struct ext4_blockdev *bdev)
{
    struct cf_stat *cfs = bdev->bdif->p_user;
    while(cfs->locked == true); //wait if blocked
    cfs->locked = true;
    return 0;
}

int bd_unlock(struct ext4_blockdev *bdev)
{
    struct cf_stat *cfs = bdev->bdif->p_user;
    cfs->locked = false;
    return 0;
}



struct ext4_blockdev *cf_init()
{
    uint8_t *block_buffer = malloc(1024);
    struct cf_stat *CF_STAT = malloc(sizeof(struct cf_stat));
    struct ext4_blockdev_iface *bdif = malloc(sizeof(struct ext4_blockdev_iface));

    CF_STAT->locked = false;
    CF_STAT->disk_id = 0;

    bdif->open = blockdev_open;
    bdif->bread = bd_read;
    bdif->bwrite = bd_write;
    bdif->lock = bd_lock;
    bdif->unlock = bd_unlock;
    bdif->close = blockdev_close;
    bdif->ph_bsize = 1024;        //CF card block size
    bdif->ph_bcnt = 128 * 1024;  //CF block count -> 128MB
    bdif->ph_bbuf = block_buffer;
    bdif->ph_refctr = 1; //IDK
    bdif->bread_ctr = 0;
    bdif->bwrite_ctr = 0;
    bdif->p_user = CF_STAT;


    
    struct ext4_bcache *cache = malloc(sizeof(struct ext4_bcache));
    memset(&cache, 0, sizeof(struct ext4_bcache));

    struct ext4_blockdev *bdev = malloc(sizeof(struct ext4_blockdev));
    
    
    
    //cache->bdev = bdev;
  

    bdev->bdif = bdif;
    bdev->part_offset = 0; //i think
    bdev->part_size = 128 * 1024 * 1024; //128 MiB
    bdev->bc = cache;           
    bdev->lg_bsize = 1024;
    bdev->lg_bcnt = 128 * 1024;
    bdev->cache_write_back = 0;
    bdev->fs = NULL;
    bdev->journal = NULL;
    

    return bdev;
}

