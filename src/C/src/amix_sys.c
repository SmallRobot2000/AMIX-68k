#include<sys_amix.h>
#include<stdio.h>
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
        sys_set_cursor_pos(0,29);
    }
    
    

}


