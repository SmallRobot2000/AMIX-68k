#include <stdint.h>
#include <stddef.h>
#include <process.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
uint32_t pid_inc = 0;
uint32_t cur_pid = 0;

#define SR_SUPERVISOR_BIT (1 << 13)
#define CCR_MASK 0x1F   // bits 0-4: X, N, Z, V, C flags
#define STACK_FRAME_SIZE 68
#define PIT_IRQ_OFF 0x70
void* create_fake_rte_frame_with_regs(void (*entry)(void)) {
    // Stack frame size: 4 * 8 + 4 * 7 bytes registers + 2 bytes SR + 4 bytes PC = 66 bytes
    uint16_t *framew = malloc(STACK_FRAME_SIZE);
    if (!framew) return NULL;

    // Zero out registers (D0-D7 + A0-A6) to emulate movem.l pushing zeros
    memset(framew, 0, 68);

    // Read current SR (you can replace this with actual read_sr function)
    uint16_t current_sr;
    asm volatile ("move.w %%sr, %0" : "=d"(current_sr));

    // Clear CCR bits and supervisor bit to user mode
    //uint16_t sr_user_mode = (current_sr & (~CCR_MASK)) & ~SR_SUPERVISOR_BIT;
    uint16_t sr_super_mode = 0x2200;

    // Store Status Register (big-endian) at offset 60

    uint32_t pc = (uintptr_t)entry;
    uint16_t pc_hi = (pc & 0xFFFF0000) >> 16;
    uint16_t pc_lo = pc & 0xFFFF;
    framew[30] = sr_super_mode;
    framew[31] = pc_hi;
    framew[32] = pc_lo;
    
    framew[33] = PIT_IRQ_OFF;

    
   
    

    
    
    return framew;
}

void* allocate_tcb()
{
    return malloc(sizeof(tcb_t));
}
// Initialize the stack with context to start the task
void init_task_stack(tcb_t *task, void (*entry)(void *), char **argv, int argc, char **env) {
    uint8_t *stack_top = (uint8_t*)&task->stack[STACK_SIZE - 1]; // word pointer
    
    // Create fake exception stack frame including registers zeroed
    uint8_t *frame = create_fake_rte_frame_with_regs((void *)entry);
    
    // Copy frame (bytes) onto task stack (consider word alignment)
    uint8_t *stack_bytes = (uint8_t *)stack_top;
    stack_bytes -= STACK_FRAME_SIZE+3*4; //3*4 for args
    
    // Set stack pointer to frame start (aligned)
    task->stack_pointer = (uint16_t*)stack_bytes;

    for(int i = 0; i < STACK_FRAME_SIZE; i ++)
    {
        
        stack_bytes[i] = frame[i];
    }

    uint32_t* ptr = (uint32_t*)(stack_bytes+STACK_FRAME_SIZE);
    *ptr++ = (uint32_t)env;
    *ptr++ = (uint32_t)argv;
    *ptr++ = (uint32_t)argc;
    free(frame);
    
    
    
    
    // You may want to set first param register explicitly in saved stack frame or context

    task->state = READY;
    task->entry = entry;

}

    
// Create a new task
tcb_t *create_task(void (*entry)(void *), char **argv, int argc, char** env) {
    tcb_t *task = allocate_tcb(); // Allocate or get from pool
    if (!task) return NULL;

    
    init_task_stack(task, entry, argv, argc, env);


    task->state = READY;
    task-> pid = pid_inc;
    pid_inc++;
    task-> p_pid = cur_pid;

    if(scheduler_add_task(task))
    {
        return NULL; //Error adding task creation
    }
    return task;
}



__attribute__((optimize("O0"))) int wait_pid(uint32_t pid)
{
    //wait untill pid is killed
    int task_place = -1;
    for(int i = 0; i < MAX_TASKS; i++)
    {
        if(tasks[i] != NULL && tasks[i]->pid == pid)
        {
            task_place = i;
            break;
        }
    }
    //printf("Waitig for task %d\n", task_place);
    if(task_place == -1)
    {
        return -1;
    }
    while(tasks[task_place] != NULL);
    return 0;
}

