#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/reent.h>  // For struct _reent
#include <fcntl.h>
#include <errno.h>
#include <RTC.h>

extern int _open_r(struct _reent *r, const char *name, int flags, int mode);
int main(int argc, char *argv[], char *envp[])
{

    rtc_init();
    printf("Testing RTC\n");
    //rtc_set_time(0,47,13,18,18,8,25);
    uint8_t sec, hour, mon, year, min, date, day;
    rtc_get_time(&sec, &min, &hour, &day, &date, &mon, &year);
    printf("Time is: %d.%d.%d %d:%d:%d\n",date,mon,year,hour,min,sec);
    return 1;
}
