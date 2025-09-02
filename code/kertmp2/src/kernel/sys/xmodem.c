#include <ext4.h>
#include <sys_amix.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <process.h>
#include <malloc.h>
// XMODEM Protocol Constants
#define SOH     0x01    // Start of Header
#define EOT     0x04    // End of Transmission  
#define ACK     0x06    // Acknowledge
#define NAK     0x15    // Not Acknowledge
#define CAN     0x18    // Cancel
#define C       0x43    // ASCII 'C' for CRC mode

#define PACKET_SIZE     128

#define MAX_XFILE_SIZE 256*1024

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
    pause_scheduler();
    ext4_file fp;
    int res  = ext4_fopen(&fp, fname, "w");
    if(res != EOK)
        {
            errno = res;
            perror("xmodem");
            ext4_fclose(&fp);
            resume_scheduler();
            return -1;
        }

    //The protocol
    uint32_t tmp_off = 0;
    uint8_t blockNum = 1; //First block
    uint8_t block[133]; 
    uint8_t chkSum = 0;
    blockNum = 1; //First block
    chkSum = 0;
    size_t bw;
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
        res = ext4_fwrite(&fp, &block[3], 128, &bw);
        if(res != EOK || bw != 128)
        {
            printf("Write error\n");
            goto finish;
        }
        tmp_off += 128;
        if(chkSum != block[131])
        {
            printf("Error incorect cheksum\n");
            sys_send_UART(CAN);
            res = -1;
            goto finish;
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
            printf("Transfer complete\n%lu bytes\n",tmp_off);
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
    ext4_fclose(&fp);
    //resume_scheduler();
    return res;
}


