// External assembly functions
#include <stdint.h>
#ifndef AMIX_SYS
#define AMIX_SYS
extern long syscall_trap0(long syscall_num, long d0, void* a0);
extern void sys_print_screen(char c);
extern void sys_print_uart(char c);
extern char sys_get_keyboard(void);
extern int sys_write_screen_string(const char *str, int len);
extern int sys_write_uart_string(const char *str, int len);
extern int sys_read_keyboard_string(char *buf, int maxlen);
extern long syscall_trap0_double(long syscall_num, long d0, void* a0);
extern long syscall_trap0_triple(long syscall_num, long d0, long d2, void* a0);

//SCREEN stuff
void sys_get_cursor_pos(int *x, int *y);
void sys_scroll(int lines);
void sys_update_scrool(void);
//DISK I/O
void sys_write_sectors(int cnt, const void* buffer, long LBA);
void sys_read_sectors(int cnt, void* buffer, long LBA);
//UART
uint8_t sys_get_UART(void);
int sys_peek_UART(void);
int sys_send_UART(uint8_t ch);
void sys_flush_fifo_UART(void);

long sys_get_timer(void);
int ide_init(void);
#endif