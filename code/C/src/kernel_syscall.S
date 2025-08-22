    #include "asm.h"
    .text
    .extern SYM(trap1_dispatch)
    .global trap1_handler
trap1_handler:
    
    movem.l d1-d7/a0-a6, -(sp)  // save all registers
    link a6,#0                  // create stack frame
    move.l sp, a0               // pass pointer to stack frame or regs into a0
    jsr SYM(trap1_dispatch)     // call C dispatch function
    unlk a6                     // remove stack frame
    movem.l (sp)+, d1-d7/a0-a6  // restore all registers
    

                 
    rte                         // return from exception
