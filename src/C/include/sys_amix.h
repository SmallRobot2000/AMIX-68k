// External assembly functions
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

void sys_get_cursor_pos(int *x, int *y);
void sys_scroll(int lines);
void sys_update_scrool(void);
#endif