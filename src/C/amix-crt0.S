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
SYM (environ):
        .long 0

 	.align	2
	.text

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

/*
 * set things up so the application will run. This *must* be called start.
 */
	.global _start

_start:
	/* 
	 * Default to using the value of %sp as set by the caller.
	 */
	/* set up initial stack frame */
    move  	IMM('C'),d0
	move  	IMM(0),d1
	trap	IMM(0)
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

        pea     0
	PICPEA	SYM (environ),a0
        pea     sp@(4)
        pea     0
	PICCALL	SYM (main)
	movel	d0, sp@-

/*
 * drop down into exit incase the user doesn't. This should drop
 * control back to the ROM monitor, if there is one. This calls the
 * exit() from the C library so the C++ tables get cleaned up right.
 */
	PICCALL	SYM (exit)
