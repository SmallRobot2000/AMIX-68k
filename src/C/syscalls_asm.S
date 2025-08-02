# syscalls_asm.S - TRAP #0 system calls for your specific convention
# D1 = syscall number, D0 = parameter/return value

.text

# System call numbers for your system
.set SYS_PRINT_SCREEN,  0
.set SYS_PRINT_UART,    1
.set SYS_GET_KEYBOARD,  8

# Generic TRAP #0 interface
# long syscall_trap0(long syscall_num, long param)
.globl syscall_trap0
syscall_trap0:
    move.l  %d1, -(%sp)
    
    move.l  12(%sp), %d1    /* syscall_num from stack */
    move.l  8(%sp), %d0     /* param from stack */
    
    trap    #0
    
    move.l  (%sp)+, %d1
    rts

# Print character to screen
# void sys_print_screen(char c)
.globl sys_print_screen
sys_print_screen:
    move.l  %d1, -(%sp)
    move.l  #SYS_PRINT_SCREEN, %d1
    move.l  8(%sp), %d0     /* character to print */
    trap    #0
    move.l  (%sp)+, %d1
    rts

# Print character to UART
# void sys_print_uart(char c)  
.globl sys_print_uart
sys_print_uart:
    move.l  %d1, -(%sp)
    move.l  #SYS_PRINT_UART, %d1
    move.l  8(%sp), %d0     /* character to print */
    trap    #0
    move.l  (%sp)+, %d1
    rts

# Get character from keyboard (blocking)
# char sys_get_keyboard(void)
.globl sys_get_keyboard
sys_get_keyboard:
    move.l  %d1, -(%sp)
    move.l  #SYS_GET_KEYBOARD, %d1
    trap    #0
    move.l  (%sp)+, %d1
    rts

# Write string to screen
# int sys_write_screen_string(const char *str, int len)
.globl sys_write_screen_string
sys_write_screen_string:
    movem.l %d1-%d3/%a0, -(%sp)
    
    move.l  24(%sp), %a0    /* str pointer */
    move.l  28(%sp), %d3    /* len */
    move.l  #0, %d2         /* character counter */
    
    move.l  #SYS_PRINT_SCREEN, %d1
    
1:  cmp.l   %d3, %d2        /* Check if we've printed len characters */
    bge     2f              /* Exit if done */
    
    move.b  (%a0)+, %d0     /* Get next character */
    beq     2f              /* Exit if null terminator */
    
    trap    #0              /* Print character */
    
    addq.l  #1, %d2         /* Increment counter */
    bra     1b              /* Continue loop */
    
2:  move.l  %d2, %d0        /* Return number of characters printed */
    movem.l (%sp)+, %d1-%d3/%a0
    rts

# Write string to UART
# int sys_write_uart_string(const char *str, int len)
.globl sys_write_uart_string
sys_write_uart_string:
    movem.l %d1-%d3/%a0, -(%sp)
    
    move.l  24(%sp), %a0    /* str pointer */
    move.l  28(%sp), %d3    /* len */
    move.l  #0, %d2         /* character counter */
    
    move.l  #SYS_PRINT_UART, %d1
    
1:  cmp.l   %d3, %d2        /* Check if we've printed len characters */
    bge     2f              /* Exit if done */
    
    move.b  (%a0)+, %d0     /* Get next character */
    beq     2f              /* Exit if null terminator */
    
    trap    #0              /* Print character */
    
    addq.l  #1, %d2         /* Increment counter */
    bra     1b              /* Continue loop */
    
2:  move.l  %d2, %d0        /* Return number of characters printed */

# String input from keyboard - SIMPLIFIED
.globl sys_read_keyboard_string
sys_read_keyboard_string:
    movem.l %d1-%d2/%a0, -(%sp)
    
    move.l  20(%sp), %a0    /* buf pointer */
    move.l  24(%sp), %d2    /* maxlen */
    move.l  #SYS_GET_KEYBOARD, %d1
    move.l  #0, %d0         /* character counter */
    
read_keyboard_loop:
    tst.l   %d2
    beq     read_keyboard_done
    
    trap    #0              /* get character */
    
    cmp.b   #13, %d0        /* carriage return */
    beq     read_keyboard_done
    cmp.b   #10, %d0        /* line feed */
    beq     read_keyboard_done
    
    move.b  %d0, (%a0)+     /* store character */
    subq.l  #1, %d2         /* decrement remaining space */
    addq.l  #1, 16(%sp)     /* increment counter on stack */
    bra     read_keyboard_loop
    
read_keyboard_done:
    move.b  #0, (%a0)       /* null terminate */
    move.l  16(%sp), %d0    /* return character count */
    movem.l (%sp)+, %d1-%d2/%a0
    rts