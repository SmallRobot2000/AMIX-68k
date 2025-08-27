#include<process.h>
#include<malloc.h>
#include<stdio.h>
#include<RTC.h>
#include<stdbool.h>
tcb_t *tasks[MAX_TASKS];
uint32_t _scheduler_stack[1024]; //stack when schedlurer is running = 4k
uint32_t *_scheduler_stack_top = &_scheduler_stack[512];
int cur_task_place = 0;
extern void trap2_deamon(void);

static inline void asm_STI(void) {
    __asm__ volatile ("move.w #0x2700, %%sr" ::: "memory");
}

static inline void asm_CLI(void) {
    __asm__ volatile ("move.w #0x2200, %%sr" ::: "memory");
}
bool pause = false;
void pause_scheduler()
{
    pause = true;
}
void resume_scheduler()
{
    pause = false;
}
void print_pcs()
{
    
}

static inline uintptr_t read_vbr(void) {
    uintptr_t vbr;
    __asm__ volatile (
        "movec %%vbr,%0"
        : "=r"(vbr)
    );
    return vbr;
}

void scheduler_init()
{
    asm_STI();
    for(int i = 0; i < MAX_TASKS; i++)
    {
        tasks[i] = NULL;
    }
    cur_pid = 0;
    cur_task_place = 0;
    //Set our trap #2 deamon
    uintptr_t vbr = read_vbr(); //Get Vector table start
    // Vector #34 (trap #2) offset in vector table
    uintptr_t *trap2_vector = (uintptr_t *)(vbr + 4 * (32 + 2));
    // Write address of trap handler
    *trap2_vector = (uintptr_t)trap2_deamon;

}
void scheduler_start()
{
    resume_scheduler();
    asm_CLI();
}
int scheduler_add_task(tcb_t* task)
{
    
    for(int i = 0; i < MAX_TASKS; i++)
    {
        if(tasks[i] == NULL) //Empty task
        {
            tasks[i] = task;
            
            return 0;
        }
    }
    return -1; //No available free task slots
}
    
int proc_kill_r(struct _reent *r, int pid)
{
    for(int i = 0; i < MAX_TASKS; i++)
    {
        if(tasks[i] != NULL && tasks[i]-> pid == pid) //Empty task
        {
            tasks[i] = NULL; //erased!
            return 0;
        }
    }

    return -1;
}
uint32_t _scheduler_deamon(void) //return stack pointer of a task to resume, and gets a stack pointer of interupted task
{
    //ds3234_read_register(123);
    static uint16_t* task_stack_ptr;
    __asm__ volatile (
        "move.l %%d0, %0\n\t"
        : "=r"(task_stack_ptr)
        :
        : "d0", "memory"
    );
    asm_STI();
    if(pause && tasks[cur_task_place] != NULL)
    {
        asm_CLI();
        return (uint32_t)task_stack_ptr; //resume dont do anything
    }
     if(tasks[cur_task_place]->state == READY)
     {
        //Startup of kernel or task restart
        tasks[cur_task_place]->state = RUNNING;
        cur_pid = tasks[cur_task_place]->pid;
        return (uint32_t)tasks[cur_task_place]->stack_pointer;
     }
    

     //Find next task
    int failed = 0;
    int prev_task_place = cur_task_place;
    do{
        failed++;
        cur_task_place++;
        if(cur_task_place == MAX_TASKS) cur_task_place = 0;
        if(failed > MAX_TASKS)
        {
            printf("No valid task available halting...");
            fflush(stdout);
            while(1);
        }
    }while(tasks[cur_task_place] == NULL || tasks[cur_task_place]->state == BLOCKED); //Dont exit until valid task with error countout
    
    //valid task in cur task
    if(tasks[cur_task_place]->state == RUNNING) //after we left from previous task
     {
        if(cur_task_place == prev_task_place)
        {
            //printf("Inposible task array logic halting...");
            //fflush(stdout);
            //while(1);
        }
        tasks[prev_task_place]->stack_pointer = task_stack_ptr; //update stack pointer for return
        //Normal running task
        cur_pid = tasks[cur_task_place]->pid;

        //ds3234_read_register(123); //For timing
        asm_CLI();
        return (uint32_t)tasks[cur_task_place]->stack_pointer;
     }else if(tasks[cur_task_place]->state == READY)
     {
        if(cur_task_place == prev_task_place)
        {
            printf("Inposible task array logic halting...");
            fflush(stdout);
            while(1);
        }
        tasks[prev_task_place]->stack_pointer = task_stack_ptr; //update stack pointer for return

        tasks[cur_task_place]->state = RUNNING;
        cur_pid = tasks[cur_task_place]->pid;

        return (uint32_t)tasks[cur_task_place]->stack_pointer;
     }
    
    asm_STI();
    printf("PANIC NO TASKS TO EXECUTE PID: %lu PLACE: %d\n",cur_pid, cur_task_place);
    fflush(stdout);
    fflush(stderr);
    while(1);
}
