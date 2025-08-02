// External assembly functions
extern long syscall_trap0(long syscall_num, long param);
extern void sys_print_screen(char c);
extern void sys_print_uart(char c);
extern char sys_get_keyboard(void);
extern int sys_write_screen_string(const char *str, int len);
extern int sys_write_uart_string(const char *str, int len);
extern int sys_read_keyboard_string(char *buf, int maxlen);