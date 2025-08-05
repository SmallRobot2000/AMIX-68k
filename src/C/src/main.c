#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
void parse_line(char* line)
{
    char * linePtr = strtok(line, " ");
    if(strcmp(linePtr,"clear") == 0) //no diff
    {
        //printf("We are testing!!\n");
        sys_scroll(32);
        syscall_trap0(0x0CL,0x00L,0x00); //set cursor to 0,0
        //fs
    }

}
int main(void) {
    double c = 0.071264;
    int i    = 63000;

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
            printf("\n");
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
