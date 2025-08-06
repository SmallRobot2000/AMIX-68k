#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
uint8_t * buffer;
PARTITION VolToPart[FF_VOLUMES] = {
        {0, 1},    /* "0:" ==> 1st partition in physical drive 0 */
        {0, 2}     /* "1:" ==> 2nd partition in physical drive 0 */
    };
LBA_t plist[] = {50, 50, 0};  /* Divide the drive by 2 */

BYTE work[FF_MAX_SS];         /* Working buffer */

FATFS fs;
void parse_line(char* line)
{
    char * linePtr = strtok(line, " ");
    if(strcmp(linePtr,"clear") == 0) //no diff
    {
        //printf("We are testing!!\n");
        sys_scroll(32);
        syscall_trap0(0x0CL,0x00L,0x00); //set cursor to 0,0
        //fs
    }else if(strcmp(linePtr,"fdisk") == 0){
        printf("Result of fdisk: %x\n", f_fdisk(0, plist, work));            /* Divide the physical drive 0 */
        printf("Hello??? \n");


    }else if(strcmp(linePtr,"getfree") == 0)
    {
        DWORD clusters;
        printf("Result of getfree: %d\n",f_getfree("0",&clusters,NULL));            /* Divide the physical drive 0 */
        printf("Free clusters: %lu\n",clusters);
    }else if(strcmp(linePtr,"mkfs") == 0)
    {
        
        printf("Result of mkfs: %d\n",f_mkfs("0:",NULL,work,FF_MAX_SS)); //default params
    }else if(strcmp(linePtr,"test") == 0)
    {
        ide_init();
        sys_write_sectors(2,buffer,0x021);
        sys_read_sectors(2,buffer+1024,0x21);
        for(int i = 0; i <1024; i++)
        {
            if(buffer[i] != buffer[i+1024])
            {
                printf("Error @%x = %d, got %x wanted %x",i,i,buffer[1024+i],buffer[i]);
            }
        }
        printf("Done\n");
    }else if(strcmp(linePtr,"mnt") == 0)
    {
        printf("Result of mnt: %d\n",f_mount(&fs,"0:",0)); //default params
    }

}
int main(void) {
    double c = 0.071264;
    int i    = 63000;
    buffer = malloc(512);
    char *str1 = "ooa str!";

    //scanf(" %c",&ch);
    uint8_t *buffer = malloc(2000);
    memcpy(buffer,str1,strlen(str1) + 1);
    printf("Haljo %f\n", c);
    printf("123dasdas %d\n", i);
    printf("Hej there\n");
    printf("test \niiii \nm\n%s",buffer);
    i = 0;
    char line[80];
    while(1)
    {
    
    
        char ch = syscall_trap0(8L,0L,0L);
        
        if(i == 79){printf("\nToo long\n");i = 0;}
        
            
        
        if(ch == '\n')
        {
            ch = '\n';
            line[i] = ' ';
            i++;
            line[i] = 0;
            parse_line(line);
            i = 0;
        }else if(ch == 8){ //BS
            i --;
            sys_print_screen(ch);
        }else{
            line[i] = ch;
            sys_print_screen(line[i]);
            i++;
        }
        
        
    }
    return 0;
}
