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
#include <time.h>

extern int _open_r(struct _reent *r, const char *name, int flags, int mode);
int main(int argc, char *argv[], char *envp[])
{

    rtc_init();
    printf("Testing RTC\n");
    //rtc_set_time(0,47,13,18,18,8,25);


    time_t currentTime;
    time(&currentTime); // Get the current time

    printf("Current time: %s", ctime(&currentTime));
    

    return 69;
}
