#include <ff.h>
#include <sys_amix.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
// XMODEM Protocol Constants
#define SOH     0x01    // Start of Header
#define EOT     0x04    // End of Transmission  
#define ACK     0x06    // Acknowledge
#define NAK     0x15    // Not Acknowledge
#define CAN     0x18    // Cancel
#define C       0x43    // ASCII 'C' for CRC mode

#define PACKET_SIZE     128
#define PACKET_1K_SIZE  1024

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
    FIL fp;
    FRESULT res  = f_open(&fp, fname, FA_CREATE_ALWAYS | FA_WRITE | FA_READ);
    if(res != FR_OK)
        {
            printf("File error\n");
            f_close(&fp);
            return -1;
        }
    //The protocol
    uint8_t blockNum = 1; //First block
    uint8_t buffer[128];
    uint8_t block[133]; 
    uint8_t chkSum = 0;
    blockNum = 1; //First block
    chkSum = 0;
    unsigned int    bw;
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
        res = f_close(&fp);
        if(res != FR_OK)
        {
            printf("Close error %d\n",res);
            return -1;
        }
        return -1;
    }
    //Redy
    while(1)
    {
        chkSum = 0;
        //Get rest of ze block
        for(int i = 1; i <= 131; i++)
        {
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
                res = f_close(&fp);
                if(res != FR_OK)
                {
                    printf("Close error %d\n",res);
                    return -1;
                }
                return -1;
            }
            block[i] = ch;
        }
        //printf("OK\n");
        if(block[1] != blockNum)
        {
            printf("Error block #\n");
            sys_send_UART(CAN);
            res = f_close(&fp);
            if(res != FR_OK)
            {
                printf("Close error %d\n",res);
                return -1;
            }
            return -1;
        }
        if((uint8_t)block[2] != (uint8_t)~blockNum)
        {
            printf("Error block num complement\n");
            sys_send_UART(CAN);
            res = f_close(&fp);
            if(res != FR_OK)
            {
                printf("Close error %d\n",res);
                return -1;
            }
            return -1;
        }
        chkSum = 0;
        for(int i  = 0; i < 128; i++)
        {
            buffer[i] = block[i+3];
            chkSum += buffer[i];
        }

        if(chkSum != block[131])
        {
            printf("Error incorect cheksum\n");
            sys_send_UART(CAN);
            res = f_close(&fp);
            if(res != FR_OK)
            {
                printf("Close error %d\n",res);
                return -1;
            }
            return -1;
        }
        //Everythin is fine
        //Send to file
        res = f_write(&fp,buffer,128,&bw);
        if(res != FR_OK || bw != 128)
        {
            printf("File write error\n");
            sys_send_UART(CAN);
            res = f_close(&fp);
            if(res != FR_OK)
            {
                printf("Close error %d\n",res);
                return -1;
            }
            return -1;

        }
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
            res = f_close(&fp);
            if(res != FR_OK)
            {
                printf("Close error %d\n",res);
                return -1;
            }
            return -1;
        }

        if(ch == EOT)
        {
            printf("Transfer complete\n%d bytes\n",(blockNum-1)*128);
            sys_send_UART(ACK);
            res = f_close(&fp);
            if(res != FR_OK)
            {
                printf("Close error %d\n",res);
                return -1;
            }
            return 0;
        }else if(ch == SOH){
            continue;
        }else{
            //WTF
            printf("Protocol error\n");
            sys_send_UART(CAN);
            res = f_close(&fp);
            if(res != FR_OK)
            {
                printf("Close error %d\n",res);
                return -1;
            }
            return -1;
        }
    }    
        res = f_close(&fp);
        if(res != FR_OK)
        {
            printf("Close error %d\n",res);
            return -1;
        }
        return 0;
   
    

    return 0;
}