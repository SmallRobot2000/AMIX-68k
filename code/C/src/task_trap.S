    #include "asm.h"
    .text
    .extern SYM(_scheduler_deamon)
    .extern SYM(_scheduler_stack_top)
    .extern SYM(asm_CLI)
    .global trap2_deamon
    .align 4
    //called like trap #2 from PIT handler(two stack frames!)
    //stack:
//        //PIT handler frame
//SP:     //SR
//SP+2:   //PC_hi
//SP+4:   //PC_lo
//SP+6:   //FORMAT
//
//        //Process stack frame
//SP+8:   //SR
//        //PC_hi
//        //PC_lo
//        //FORMAT
//
//Need to skip PIT frame -> we dont return
trap2_deamon:
    add.l #8,sp   //Skip PIT stack frmae
    movem.l d0-d7/a0-a6, -(sp)  // save all registers -> 60 bytes //alltogether 68
    //set sys stack
    move.l  sp,d0               //save task stack
    lea  SYM(_scheduler_stack_top),sp

    move.l sp, a0               // pass pointer to stack frame or regs into a0
    jsr SYM(_scheduler_deamon)     // call C dispatch function

    move.l  d0,sp               //d0 - stack pointer to new process!
    movem.l (sp)+,d0-d7/a0-a6   // reverse all registers
    
    rte                         // return from exception
