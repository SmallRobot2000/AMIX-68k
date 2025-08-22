#include<sys_amix.h>
#include<stdio.h>
#include <stdint.h>
#include <ctype.h>
int sys_write_screen_string(const char *str, int len)
{
    for(int i = 0; i < len;i++)
    {
        if(str[i] == 0){break;}
//        char ch = str[i];
        //syscall_trap0(0, 'A');
        sys_print_screen(str[i]);
    }
    return 0;
}
int sys_write_uart_string(const char *str, int len)
{
    for(int i = 0; i < len;i++)
    {
        if(str[i] == 0){break;}
        sys_print_uart(str[i]);
    }
    return 0;
}
int sys_read_keyboard_string(char *buf, int maxlen)
{
    int ptr = 0;
    while(ptr < maxlen-1)
    {
        char ch = sys_get_keyboard();
        if(ch == 10 || ch == 13){break;} //Returns
        buf[ptr] = ch;
        ptr++;
    }
    buf[ptr] = 0;
    return 0;

}

void sys_get_cursor_pos(int *x, int *y)
{
    long ret = 0;
    ret = syscall_trap0_double(0x0BL, 0L, 0L);  //Get cursor XY

    *x = (int)ret & 0xFFFF;
    *y = (int)(ret & 0xFFFF0000)>>16;
}
void sys_set_cursor_pos(int x, int y)
{
    syscall_trap0(0x0CL,(long)(y<<16)+x,0L);
}

void sys_scroll(int lines)
{
    syscall_trap0(0x0AL, (long)lines, 0L);
}

void sys_update_scrool(void)
{
    int x,y;
    sys_get_cursor_pos(&x,&y);
    y &= 0xFF;
    if(y >= 29)
    {
        sys_scroll(y-28);
        sys_set_cursor_pos(x,28);
    }
    
    

}
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