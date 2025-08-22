/*
 * crt0.S -- startup file for m68k amix
 *
 * Copyright (c) 1995, 1996, 1998, 2001 Cygnus Support
*/

#include "asm.h"

	.title "crt0.S for m68k-amix"
#define STACKSIZE	0x4000

/*
 * Define an empty environment.
 */
        .data
    .align 2

/* 1) Array of pointers, terminated by NULL */
env_ptrs:
    .long   env_foo        /* &"FOO=hello" */
    .long   env_bar        /* &"BAR=world" */
    .long   0              /* NULL terminator */

/* 2) The actual strings */
    .align 2
env_foo:
    .asciz  "FOO=hello"
env_bar:
    .asciz  "BAR=world"

/* 3) Global symbol for C’s environ */
    .align 2
    .global environ
environ:
    .long   env_ptrs

    .text
    .global _start


/*
 * These symbols are defined in C code, so they need to always be
 * named with SYM because of the difference between object file formats.
 */

/* These are defined in C code. */
	.extern SYM (main)
	.extern SYM (exit)
	.extern SYM (atexit)
	.extern SYM(__do_global_dtors)

/* 
 * These values are set in the linker script, so they must be
 * explicitly named here without SYM.
 */
	.extern __stack
	.extern __bss_start
	.extern _end

//my macro
// Macro to disable all maskable interrupts by setting IPL = 7
    .macro STI
    move.w  #0x2700,sr    // Disable all interrupts (IPL=7), Supervisor mode on
    .endm

// Macro to enable all interrupts by clearing IPL to 0
    .macro CLI
    move.w  #0x2200,sr    // Enable all interrupts (IPL=0), Supervisor mode on
    .endm

/*
 * set things up so the application will run. This *must* be called start.
 */
	.global _start

_start:
	/* 
	 * Default to using the __stack for SP.
	 */
	STI
	move	#0,d1
	move	#13,d0
	trap 	#0		//Needs to be here idk why
	lea		__stack,a7	//setup SP
	/* set up initial stack frame */
	link	a6, IMM(-8)

/*
 * zero out the bss section.
 */
	movel	IMM(__bss_start), d1
	movel	IMM(_end), d0
	cmpl	d0, d1
	jbeq	3f
	movl	d1, a0
	subl	d1, d0
	subql	IMM(1), d0
2:
	clrb	(a0)+

	dbra	d0, 2b

	
3:

/*
 * call the main routine from the application to get it going.
 * main (argc, argv, environ)
 * we pass argv as a pointer to NULL.
 */

#ifdef ADD_DTORS
	/* put __do_global_dtors in the atexit list so the destructors get run */
	movel	IMM (SYM(__do_global_dtors)),(sp)
	PICCALL	SYM (atexit)
#endif
	movel	IMM (__FINI_SECTION__),(sp)
	PICCALL	SYM (atexit)

	PICCALL	__INIT_SECTION__

      /* Push argc = 0 */
        pea     0

        /* Push argv = NULL (sp@(4) still holds return address slot) */
        pea     sp@(4)

        /* Push environ pointer */
	PICPEA SYM (environ),a0
        movel   a0,-(sp)       /* push A0 value */

        /* Re-enable interrupts before entering main */
        CLI

        /* Call main(argc, argv, environ) */
	PICCALL SYM (main)
	movel	d0, sp@-

/*
 * drop down into exit incase the user doesn't. This should drop
 * control back to the ROM monitor, if there is one. This calls the
 * exit() from the C library so the C++ tables get cleaned up right.
 */
	PICCALL	SYM (exit)
