#include<process.h>
#include<stdlib.h>
#include<stdio.h>

static inline uintptr_t read_vbr(void) {
    uintptr_t vbr;
    __asm__ volatile (
        "movec %%vbr,%0"
        : "=r"(vbr)
    );
    return vbr;
}

extern void trap3_deamon();
void init_catcher()
{
    //Set our trap #3 deamon
    uintptr_t vbr = read_vbr(); //Get Vector table start
    // Vector #34 (trap #2) offset in vector table
    uintptr_t *trap3_vector = (uintptr_t *)(vbr + 4 * (32 + 3));
    // Write address of trap handler
    *trap3_vector = (uintptr_t)trap3_deamon;
    
}




void clear_task(tcb_t *task)
{
    //We have the whole task
    //TODO: free allocations and files
    free(task);
    task = NULL; //No more task
}

void trap3_deamon()
{
    pause_scheduler();
    printf("Crash! Killed pid: %ld\n", cur_pid);
    if(proc_kill_r(NULL, cur_pid))
    {
        printf("Why wont u die??\n");
    }
    resume_scheduler();
    while(1); //scheduler will take over the control
}