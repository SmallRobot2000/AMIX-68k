#include <stdint.h>
#define MAX_TASKS 8
#define STACK_SIZE 1024*16 //16k
#define MAX_MALLOC 256 //Maximum mallocs at the time per task

typedef enum {READY, RUNNING, BLOCKED, KILLED} task_state_t;
extern uint32_t pid_inc;
extern uint32_t cur_pid;
typedef struct {
    uint16_t *stack_pointer;  // Pointer to top of saved stack
    uint16_t stack[STACK_SIZE];  // Dedicated stack memory for task
    task_state_t state;
    void (*entry)(void *);   // Task entry function
    void (*signal)(void *);   // Task signal function
    void *arg;               // Argument to entry function
    uint32_t pid;           //Process ID
    uint32_t p_pid;         // Perent process ID(caller)
    uint32_t malloc_table[MAX_MALLOC]; // Table of allocations
} tcb_t;


extern int scheduler_add_task(tcb_t* task);
extern void *allocate_tcb();
extern void init_task_stack(tcb_t *task, void (*entry)(void *), void *arg);
extern tcb_t *create_task(void (*entry)(void *), void *arg);
extern void scheduler_init();
extern void scheduler_start();