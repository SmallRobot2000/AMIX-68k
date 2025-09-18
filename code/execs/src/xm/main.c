#include <sys_amix.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include <malloc.h>

#define UART_BASE  0xFF0000
#define UART_RBR   (UART_BASE+0x00)
#define UART_THR   (UART_BASE+0x00)
#define UART_IER   (UART_BASE+0x02)
#define UART_IIR   (UART_BASE+0x04)
#define UART_FCR   (UART_BASE+0x04)
#define UART_LCR   (UART_BASE+0x06)
#define UART_MCR   (UART_BASE+0x08)
#define UART_LSR   (UART_BASE+0x0A)
#define UART_MSR   (UART_BASE+0x0C)
#define UART_SCR   (UART_BASE+0x0E)

uint8_t sys_get_UART()
{
    return (uint8_t)syscall_trap0(0x10L,0L,0L); //Get uart
}
__attribute__((optimize("O0"))) int sys_peek_UART()
{
    //return (uint16_t)syscall_trap0(0x11L,0L,0L); //Get uart
    if(*(uint8_t *)UART_LSR & 0x01)
    {
        //Data available
        return *(uint8_t *)UART_RBR; //Read uart
    }else{
        return -1;
    }

}
__attribute__((optimize("O0"))) int sys_send_UART(uint8_t ch)
{
    //syscall_trap0(0x02L, (long)ch, 0L);
    while((*(uint8_t *)UART_LSR & 0x20) == 0); //wait for data redy to transmit
    *(uint8_t *)UART_THR = ch; //write UART
    return 0;
}
long sys_get_timer()
{
    return syscall_trap0(0x12L,0L,0L); //get timer

}

__attribute__((optimize("O0"))) void sys_flush_fifo_UART(void) {
    while (*(volatile uint8_t *)UART_LSR & 0x01) { // While Data Ready bit set
        volatile uint8_t dummy = *(volatile uint8_t *)UART_RBR; // Read and discard
        (void)dummy; // Avoid unused variable warning
    }
}

/*
 * dump_memory
 *   addr: start address of memory to dump
 *   len : number of bytes to dump
 *
 * Prints a hex + ASCII dump similar to hexdump.
 */
void dump_memory(const void *addr, size_t len) {
    const uint8_t *data = (const uint8_t *)addr;
    const size_t bytes_per_line = 16;

    for (size_t offset = 0; offset < len; offset += bytes_per_line) {
        // Print address
        printf("%08lX  ", (unsigned long)(uintptr_t)(data + offset));

        // Print hex bytes
        for (size_t i = 0; i < bytes_per_line; i++) {
            size_t idx = offset + i;
            if (idx < len) {
                printf("%02X ", data[idx]);
            } else {
                printf("   ");
            }
            if (i == 7) {
                printf(" ");  // extra space in middle
            }
        }

        // Print ASCII characters
        printf(" |");
        for (size_t i = 0; i < bytes_per_line; i++) {
            size_t idx = offset + i;
            if (idx < len) {
                char c = data[idx];
                printf("%c", isprint((unsigned char)c) ? c : '.');
            } else {
                printf(" ");
            }
        }
        printf("|\n");
    }
}

extern inline void asm_STI(void) {
    __asm__ volatile ("move.w #0x2700, %%sr" ::: "memory");
}

extern inline void asm_CLI(void) {
    __asm__ volatile ("move.w #0x2200, %%sr" ::: "memory");
}
// XMODEM Protocol Constants
#define SOH     0x01    // Start of Header
#define EOT     0x04    // End of Transmission  
#define ACK     0x06    // Acknowledge
#define NAK     0x15    // Not Acknowledge
#define CAN     0x18    // Cancel
#define C       0x43    // ASCII 'C' for CRC mode

#define PACKET_SIZE     128
#define PACKET_1K_SIZE  1024

#define BUFF_SIZE 16*1024
typedef struct {
    uint8_t soh;        // Start of header (0x01)
    uint8_t block_num;  // Block number (1-255)
    uint8_t block_inv;  // 255 - block_num 
    uint8_t data[128];  // Data payload
    uint16_t crc;       // CRC-16 checksum
} xmodem_packet_t;
int times = 0;


int get_UART_timeout()
{
    uint16_t ch;
    long oldT = sys_get_timer();
    times++;
    while(1)
    {   
        
        ch = sys_peek_UART();
        if(ch <= 255){break;}
        if(oldT+205 <= sys_get_timer()){return 0xFFFF;}
        
    }
    return ch;
}
int xmodem_receive(char* fname)
{
    printf("\n");
    asm_STI();
    FILE *fil;
    fil = fopen(fname, "w");
    if(fil == NULL)
        {
            
            perror("fopen");
            asm_CLI();
            return -1;
        }
    uint8_t *tmp = malloc(BUFF_SIZE);
    //The protocol

    int res = 0;
    uint8_t blockNum = 1; //First block
    uint8_t block[133]; 
    uint8_t chkSum = 0;
    uint32_t buff_fill = 0;
    int bytes = 0;
    blockNum = 1; //First block
    chkSum = 0;
    times  = 0;
    printf("Press any key ...\n");
    syscall_trap0(8L,0L,0L); //wait for key press
    //Empty FIFO
    sys_flush_fifo_UART();
    //main loop and logic
    int ch;
    
    for(int i = 0; i < 10; i++) //Timeout
    {//get SOH
        sys_send_UART(NAK);
        times ++;
        for(int i = 0; i < 1000; i++)
        {
            ch = sys_peek_UART();
            if(ch == -1){continue;}
            break;

        }
        if(ch != -1){break;}
    }
    if(ch != SOH)
    {
        printf("Error no response\n");
        res = -1;
        goto finish;
    }
    //Redy
    while(1)
    {
        chkSum = 0;
        //Get rest of ze block
        
        for(int i = 1; i <= 131; i++)
        {
            for(;;)
            {
                ch = sys_peek_UART();
                if(ch == -1){continue;}
                break;
            }
            if(ch == -1)
            {
                printf("Timeout\n");
                sys_send_UART(CAN);
                res = -1;
                goto finish;
            }
            block[i] = ch;
        }
        //printf("OK\n");
        if(block[1] != blockNum)
        {
            printf("Error block #\n");
            sys_send_UART(CAN);
            res = -1;
            goto finish;
        }
        if((uint8_t)block[2] != (uint8_t)~blockNum)
        {
            printf("Error block num complement\n");
            sys_send_UART(CAN);
            res = -1;
            goto finish;
        }
        chkSum = 0;
        for(int i  = 0; i < 128; i++)
        {
            tmp[i+buff_fill] = block[i+3];
            chkSum +=  tmp[i+buff_fill];
        }
        buff_fill += 128;
        bytes += 128;
        if(chkSum != block[131])
        {
            printf("Error incorect cheksum\n");
            sys_send_UART(CAN);
            res = -1;
            goto finish;
        }
        //Chek if full
        if(buff_fill == BUFF_SIZE)
        {
            buff_fill = 0; //Reset buf
            int sz = fwrite(tmp, 1, BUFF_SIZE, fil);
            if(sz != BUFF_SIZE)
            {
                perror("fwrite");
                goto finish;
            }
        }
        
        //Everythin is fine
               
        
        //NEXT
        sys_send_UART(ACK); //Block is OK!
        
        blockNum++;
        //get next header or EOT
        for(int z = 0; z < 1000; z++)
        {
            ch = sys_peek_UART();
            if(ch == -1){continue;}
            break;
        }
        if(ch == -1)
        {
            printf("Timeout\n");
            sys_send_UART(CAN);
            res = -1;
            goto finish;
        }

        if(ch == EOT)
        {
            sys_send_UART(ACK);
            printf("Saving to file\n");
            int sz = fwrite(tmp, 1, buff_fill, fil);
            if(sz != BUFF_SIZE)
            {
                perror("fwrite");
                goto finish;
            }
            printf("Transfer complete\n%d bytes\n",bytes);
            res = 0;
            goto finish;

        }else if(ch == SOH){
            continue;
        }else{
            //WTF
            printf("Protocol error\n");
            res = -1;
            goto finish;
        }
    }    

        
    
    
    finish:
    fclose(fil);
    free(tmp);
    asm_CLI();
    return res;
}


int main(int argc, char *argv[], char *envp[]) {
    if(argv[1] == NULL)
    {
        printf("%s <path_to_file>\n",argv[0]);
        return -1;
    }
    return xmodem_receive(argv[1]);
}


