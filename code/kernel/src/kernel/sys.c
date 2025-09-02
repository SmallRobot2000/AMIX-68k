#include<sys_amix.h>
#include<stdio.h>
#include <stdint.h>
#include <ctype.h>

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

__attribute__((optimize("O0"))) int sys_send_UART(uint8_t ch)
{
    //syscall_trap0(0x02L, (long)ch, 0L);
    while((*(uint8_t *)UART_LSR & 0x20) == 0); //wait for data redy to transmit
    *(uint8_t *)UART_THR = ch; //write UART
    return 0;
}

__attribute__((optimize("O0"))) void sys_flush_fifo_UART(void) {
    while (*(volatile uint8_t *)UART_LSR & 0x01) { // While Data Ready bit set
        volatile uint8_t dummy = *(volatile uint8_t *)UART_RBR; // Read and discard
        (void)dummy; // Avoid unused variable warning
    }
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