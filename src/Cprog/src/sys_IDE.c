#include<stdint.h>
#include<stdio.h>
#include<sys_amix.h>
// Primary IDE Channel I/O Ports

#define IDE_BASE        0xFF2000u

#define IDE_DATA        0x00*2   // Data register (16-bit)
#define IDE_ERROR       0x01*2   // Error register (read)
#define IDE_FEATURES    0x01*2   // Features register (write)
#define IDE_SECTOR_COUNT 0x02*2  // Sector count
#define IDE_SECTOR_NUM  0x03*2   // Sector number / LBA[7:0]
#define IDE_CYL_LOW     0x04*2   // Cylinder low / LBA[15:8]
#define IDE_CYL_HIGH    0x05*2   // Cylinder high / LBA[23:16]
#define IDE_DRIVE_HEAD  0x06*2   // Drive/Head select / LBA[27:24]
#define IDE_STATUS      0x07*2   // Status register (read)
#define IDE_COMMAND     0x07*2   // Command register (write)


// Status register bits
#define IDE_BSY         0x80    // Busy
#define IDE_DRDY        0x40    // Drive ready
#define IDE_DWF         0x20    // Drive write fault
#define IDE_DSC         0x10    // Drive seek complete
#define IDE_DRQ         0x08    // Data request
#define IDE_CORR        0x04    // Corrected data
#define IDE_IDX         0x02    // Index
#define IDE_ERR         0x01    // Error

// Commands
#define IDE_CMD_READ_SECTORS    0x20
#define IDE_CMD_WRITE_SECTORS   0x30
#define IDE_CMD_IDENTIFY        0xEC
#define IDE_CMD_FLUSH_CACHE     0xE7
#define IDE_CMD_FEATURES        0xEF
// Drive selection bits
#define IDE_DRIVE_MASTER        0xE0
#define IDE_DRIVE_SLAVE         0xF0

// I/O port access functions (implement these for your system)
static inline void ide_outb(uint16_t port, uint8_t value) {
    
    volatile uint16_t *addr = (volatile uint16_t *)(IDE_BASE + port);
    *addr = (uint16_t)(value | value<<8);
}

static inline uint8_t ide_inb(uint16_t port) {
    volatile uint16_t *addr = (volatile uint16_t*)(IDE_BASE + port);
    return (uint8_t)(*addr >> 8);
}

static inline void ide_outw(uint16_t port, uint16_t value) {
    // Your 68010 outw implementation
    *(volatile uint16_t*)(0xFF2000 + port) = value;
}

static inline uint16_t ide_inw(uint16_t port) {
    // Your 68010 inw implementation
    return *(volatile uint16_t*)(0xFF2000 + port);
}

// Wait for drive to be ready
static int ide_wait_ready(void) {
    int timeout = 1000;
    int8_t status;
    
    while (timeout--) {
        status = ide_inb(IDE_STATUS);

        if (!(status & IDE_BSY) && (status & IDE_DRDY)) {
            return 0;  // Ready
        }
        
    }
    
    return -1;  // Timeout
}

// Wait for data request
static int ide_wait_drq(void) {
    int timeout = 1000;
    uint8_t status;
    
    while (timeout--) {
        status = ide_inb(IDE_STATUS);
        if (!(status & IDE_BSY) && (status & IDE_DRQ)) {
            return 0;  // Data ready
        }
        if (status & IDE_ERR) {
            return -1;  // Error
        }
    }
    return -1;  // Timeout
}

// 400ns delay (read alternate status 4 times)
static void ide_delay_400ns(void) {
    int timeout = 1000;
    while (timeout--) {
        
    }
}


int ide_init(void) {
    uint8_t status;
    
    
    // Select master drive
    ide_outb(IDE_DRIVE_HEAD, IDE_DRIVE_MASTER);

    ide_delay_400ns();
    
    // Wait for drive to be ready
    if (ide_wait_ready() < 0) {
        printf("IDE: Master drive not ready\n");
        return -1;
    }
    
    // Check if drive exists by reading status
    status = ide_inb(IDE_STATUS);
    if (status == 0x00 || status == 0xFF) {
        printf("IDE: No drive detected\n");
        return -1;
    }

    // Send IDENTIFY command to get drive information
    ide_outb(IDE_COMMAND, IDE_CMD_IDENTIFY);
    //ide_delay_400ns();

    // Check if command was accepted
    status = ide_inb(IDE_STATUS);
    
    if (status & IDE_ERR) {
        printf("IDE: IDENTIFY command failed\n");
        return -1;
    }
    //printf("Ye im here and well good \n\r");
    // Wait for data to be ready
    if (ide_wait_drq() < 0) {
        printf("IDE: IDENTIFY data not ready\n");
        return -1;
    }

    // Read and discard IDENTIFY data (512 bytes)
    for (int i = 0; i < 256; i++) {
        ide_inw(IDE_DATA);
    }
    
    printf("IDE: Master drive initialized successfully\n");
    return 0;
}


//void sys_read_sectors(int cnt, void *buffer, long lba) {
//    uint8_t *buf = (uint8_t *)buffer;
//    // limit to 256 sectors
//    uint8_t n = cnt ? cnt : 256;
//
//    ide_wait_ready();
//
//    // select drive + LBA high bits
//    ide_outb(IDE_DRIVE_HEAD, IDE_DRIVE_MASTER | ((lba >> 24) & 0x0F));
//    ide_outb(IDE_SECTOR_COUNT, n);
//    ide_outb(IDE_SECTOR_NUM,   (uint8_t)(lba & 0xFF));
//    ide_outb(IDE_CYL_LOW,      (uint8_t)((lba >> 8) & 0xFF));
//    ide_outb(IDE_CYL_HIGH,     (uint8_t)((lba >> 16) & 0xFF));
//
//    ide_outb(IDE_COMMAND, IDE_CMD_READ_SECTORS);
//    ide_delay_400ns();
//
//    for (int i = 0; i < n; i++) {
//        if (ide_wait_drq() < 0) {
//            printf("IDE read timeout or error\n");
//            return;
//        }
//        uint16_t *wbuf = (uint16_t *)(buf + i * 512);
//        for (int w = 0; w < 256; w++)
//            wbuf[w] = ide_inw(IDE_DATA);
//    }
//}

void sys_read_sectors(int cnt, void *buffer, long lba) {
    uint8_t *buf = (uint8_t *)buffer;
    uint8_t n = cnt ? cnt : 256;
    printf("R\n");
    ide_wait_ready();

    // Setup IDE registers
    ide_outb(IDE_DRIVE_HEAD, IDE_DRIVE_MASTER | ((lba >> 24) & 0x0F));
    ide_outb(IDE_SECTOR_COUNT, n);
    ide_outb(IDE_SECTOR_NUM,   (uint8_t)(lba & 0xFF));
    ide_outb(IDE_CYL_LOW,      (uint8_t)((lba >> 8) & 0xFF));
    ide_outb(IDE_CYL_HIGH,     (uint8_t)((lba >> 16) & 0xFF));

    ide_outb(IDE_COMMAND, IDE_CMD_READ_SECTORS);
    ide_delay_400ns();

    // Ultra-fast sector reading with integrated DRQ checking
    for (int i = 0; i < n; i++) {
        uint16_t *wbuf = (uint16_t *)(buf + i * 512);
        volatile uint16_t *ide_status_port = (volatile uint16_t *)(IDE_BASE + IDE_STATUS);
        volatile uint16_t *ide_data_port = (volatile uint16_t *)(IDE_BASE + IDE_DATA);
        
        // Optimized m68k assembly with DRQ wait and data transfer
        __asm__ __volatile__ (
            // Wait for DRQ loop
            "move.w #999,%%d2\n\t"          // Timeout counter
            "1:\n\t"                        // DRQ wait loop
            "move.b (%2),%%d3\n\t"         // Read IDE status (8-bit from upper byte)
            "btst #3,%%d3\n\t"             // Test DRQ bit (bit 3)
            "bne 3f\n\t"                   // If DRQ set, jump to data transfer
            "btst #0,%%d3\n\t"             // Test ERR bit (bit 0)  
            "bne 2f\n\t"                   // If ERR set, exit with error
            "subq.w #1,%%d2\n\t"           // Decrement timeout
            "bne 1b\n\t"                   // Loop if not timed out
            "2:\n\t"                       // Error/timeout exit
            "moveq #-1,%%d0\n\t"           // Return error code
            "bra 4f\n\t"                   // Skip to end
            
            // Fast data transfer (256 words)
            "3:\n\t"                       // Data transfer start
            "move.w #255,%%d0\n\t"         // Counter: 255 down to 0 (256 words)
            "5:\n\t"                       // Transfer loop
            "move.w (%3),%%d1\n\t"         // Read 16-bit word from IDE data port
            "move.w %%d1,(%0)+\n\t"        // Store to buffer with post-increment
            "dbf %%d0,5b\n\t"              // Decrement and branch if >= 0
            "moveq #0,%%d0\n\t"            // Success return code
            "4:"                           // End label
            
            : "=a" (wbuf), "=d" (i)        // Outputs: updated buffer, loop status
            : "a" (ide_status_port), "a" (ide_data_port), "0" (wbuf), "1" (i)  // Inputs
            : "d0", "d1", "d2", "d3", "memory"  // Clobbered registers
        );
        
        // Check if there was an error (d0 will be -1 on error, 0 on success)
        register int result asm("d0");
        if (result < 0) {
            printf("IDE read timeout or error\n");
            return;
        }
    }
}
