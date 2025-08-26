#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
#include <xmodem.h>
#include <elf_loader.h>
#include <kernel.h>
#include <history.h>
#include <stdbool.h>
#include <shell.h>
#include <unistd.h>
#include <process.h>
extern void trap1_test();

static inline void asm_STI(void) {
    __asm__ volatile ("move.w #0x2700, %%sr" ::: "memory");
}

static inline void asm_CLI(void) {
    __asm__ volatile ("move.w #0x2200, %%sr" ::: "memory");
}

void fool()
{
    //asm_STI();    
    while(1)
    {
        printf("Task!\n");
        //fflush(stdout);
    }
    
    
}

void foo()
{
    //asm_STI();    
    while(1)
    {
        printf("Task #1!\n");
        //fflush(stdout);
    }
    
    
}

void task3()
{
    while(1)
    {
        printf("The best task!\n");
    }
}

int main(int argc, char *argv[], char *environp[]) 
{
//Need to init first proces and commit suicide
    scheduler_init();
    tcb_t *task = create_task(fool, 0);
    if(task == NULL)
    {
        printf("Error creating task\n");
        fflush(stdout);
        while(1);
    }
    tcb_t *task1 = create_task(foo, 0);
    if(task1 == NULL)
    {
        printf("Error creating task\n");
        fflush(stdout);
        while(1);
    }
    tcb_t *task2 = create_task(task3, 0);
    if(task2 == NULL)
    {
        printf("Error creating task\n");
        fflush(stdout);
        while(1);
    }
    
    
    scheduler_start();
    int n;
    while(1)
    {
        if(n%42 == 3){n = 492;}
        n++;
        printf("Hi\n");
    }
    return 0;
}

