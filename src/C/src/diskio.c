/*-----------------------------------------------------------------------*/
/* Low level disk I/O module SKELETON for FatFs     (C)ChaN, 2025        */
/*-----------------------------------------------------------------------*/
/* If a working storage control module is available, it should be        */
/* attached to the FatFs via a glue function rather than modifying it.   */
/* This is an example of glue functions to attach various exsisting      */
/* storage control modules to the FatFs module with a defined API.       */
/*-----------------------------------------------------------------------*/

#include "ff.h"			/* Basic definitions of FatFs */
#include "diskio.h"		/* Declarations FatFs MAI */
#include <sys_amix.h>

/* Example: Declarations of the platform and disk functions in the project */
//#include "platform.h"
//#include "storage.h"

/* Example: Mapping of physical drive number for each drive */
#define DEV_FLASH	0	/* Map FTL to physical drive 0 */
#define DEV_MMC		1	/* Map MMC/SD card to physical drive 1 */
#define DEV_USB		2	/* Map USB MSD to physical drive 2 */


/*-----------------------------------------------------------------------*/
/* Get Drive Status                                                      */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status (
	BYTE pdrv		/* Physical drive nmuber to identify the drive */
)
{
	DSTATUS stat;
	
	switch (pdrv)
	{
	case 0:		//DISK 0 the only disk
		stat = 0; //ok
		break;
	
	default:
		stat = STA_NODISK | STA_NOINIT; //Doesnt exist
		break;
	}
	
	return stat;
}



/*-----------------------------------------------------------------------*/
/* Inidialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (
	BYTE pdrv				/* Physical drive nmuber to identify the drive */
)
{
	DSTATUS stat;
	
	switch (pdrv)
	{
	case 0:		//DISK 0 the only disk
		stat = 0; //ok
		break;
	
	default:
		stat = STA_NODISK | STA_NOINIT; //Doesnt exist
		break;
	}

	
	return stat; //no need
}



/*-----------------------------------------------------------------------*/
/* Read Sector(s)                                                        */
/*-----------------------------------------------------------------------*/

DRESULT disk_read (
    BYTE   pdrv,     /* Physical drive number */
    BYTE  *buff,     /* Data buffer to store read data */
    LBA_t  sector,   /* Start sector in LBA */
    UINT   count     /* Number of sectors to read */
)
{

    /* Reject invalid drive or >24-bit sector */
    if (pdrv != 0 || (sector & 0xFF000000U) != 0) {
        return RES_ERROR;
    }

    BYTE    *ptr       = buff;
    UINT     remaining = count;

    while (remaining > 0) {
        /* Read at most 255 sectors per call */
        UINT chunk = (remaining > 255) ? 255 : remaining;
        LBA_t lba   = sector;  /* 24-bit LBA */

        /* sys_read_sectors(sector_count, data_ptr, start_LBA) */
        sys_read_sectors(chunk, ptr, lba);

        /* Advance pointers and counters */
        ptr       += chunk * 512;
        sector    += chunk;
        remaining -= chunk;
    }

    return RES_OK;
}




/*-----------------------------------------------------------------------*/
/* Write Sector(s)                                                       */
/*-----------------------------------------------------------------------*/

#if FF_FS_READONLY == 0

DRESULT disk_write (
    BYTE     pdrv,          /* Physical drive number */
    const BYTE *buff,       /* Data to be written */
    LBA_t    sector,        /* Start sector in LBA */
    UINT     count          /* Number of sectors to write */
)
{
    

    /* Reject >24-bit sector numbers */
    if (pdrv != 0 || (sector & 0xFF000000U) != 0) {
        return RES_ERROR;
    }

    /* Write in chunks no more than 255 sectors at a time */
    const BYTE *ptr = buff;
    UINT remaining = count;

    while (remaining > 0) {
        /* Write at most 255 sectors in one syscall */
        UINT chunk = (remaining > 255) ? 255 : remaining;
        LBA_t  lba   = sector;               /* current LBA (24-bit valid) */

        /* sys_write_sectors(sector_count, data_ptr, start_LBA) */
        sys_write_sectors(chunk, ptr, lba);
            
        

        /* Advance */
        ptr       += chunk * 512;  /* bytes per sector */
        sector    += chunk;
        remaining -= chunk;
    }

    return RES_OK;
}


#endif


/*-----------------------------------------------------------------------*/
/* Miscellaneous Functions                                               */
/*-----------------------------------------------------------------------*/

DRESULT disk_ioctl (
	BYTE pdrv,		/* Physical drive nmuber (0..) */
	BYTE cmd,		/* Control code */
	void *buff		/* Buffer to send/receive control data */
)
{
	DRESULT res;
	res = RES_OK;

	switch(pdrv)
	{
		case 0:
			switch(cmd)
			{
				case CTRL_SYNC:
					res = RES_OK;
					break;
				case GET_SECTOR_COUNT:
					res = 262144; //128MB
					break;
				case GET_SECTOR_SIZE:
					res = 512;
					break;
				case GET_BLOCK_SIZE:
					res = 1;
					break;
				case CTRL_TRIM:
					res = 0;
					break;
				default:
					res = 0;
					break;
			}
		default:
			res = 0;
	}

	return res;
}

