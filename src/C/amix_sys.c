#include<sys_amix.h>

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