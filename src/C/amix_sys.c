extern void sys_print_screen(char c);
extern void sys_print_uart(char c);
extern char sys_get_keyboard(void);

int sys_write_screen_string(const char *str, int len)
{
    for(int i = 0; i < len;i++)
    {
        if(str[i] == 0){break;}
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
    while(ptr < maxlen)
    {
        buf[ptr] = sys_get_keyboard();
        if(buf[ptr] == 10 || buf[ptr] == 13){break;} //Returns
        ptr++;
    }
    return 0;

}