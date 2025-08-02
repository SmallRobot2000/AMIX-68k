PWR_TRIG		equ 	$FFFFFF
RAM_START		equ     $100000
STACK_START		equ		RAM_START+$10000
UART_BASE       equ     $FF0000

UART_RBR        equ     $00
UART_THR        equ     $00
UART_IER        equ     $02
UART_IIR        equ     $04
UART_FCR        equ     $04
UART_LCR        equ     $06
UART_MCR        equ     $08
UART_LSR        equ     $0A
UART_MSR        equ     $0C
UART_SCR        equ     $0E

UART_DLL        equ     $00
UART_DLM        equ     $02

	section .text
;DEBUG
DEBUG	equ		0
CHK_SIZE	equ		65536

API_PRINT_BYTE		equ		$00
API_PRINT_WORD		equ		$01
API_SEND_BYTE		equ		$02
API_PRINT_STR_BYTE	equ		$03
API_PRINT_STR_WORD	equ		$04
API_SEND_STR		equ		$05
API_GET_CURSOR_XY	equ		$06
API_SET_CURSOR_XY	equ		$07

prog_start 	equ	RAM_START+$30000	;lots of space

; Macro to disable all maskable interrupts by setting IPL = 7
    macro STI
    move.w  #$2700,sr    ; Disable all interrupts (IPL=7), Supervisor mode on
    endm

; Macro to enable all interrupts by clearing IPL to 0
    macro CLI
    move.w  #$2200,sr    ; Enable all interrupts (IPL=0), Supervisor mode on
    endm

_start:
	bsr		init_traps
	bsr		ppi_init
	bsr		init_tmr


	lea		msg_press_enter,a0
	move	#3,d1
	TRAP	#0

.l:
	bsr		kyb_get_key
	cmp.b	#10,d0
	bne		.l
	bsr		x_print_char_byte
	lea		prog_start,a0
	bsr		xmodem_receve
	bsr		kyb_get_key
	lea		prog_start,a0
	jsr		(a0)
	jmp		.l



;Set trap to subrutine
init_traps:
	lea		_exc_trap_0,a1
	lea		TRAP0_handler,a0
	move.l	a0,(a1)+	;TRAP #1
	lea		TRAP_empty,a0
	move.l	a0,(a1)+	;TRAP #2
	move.l	a0,(a1)+	;TRAP #3
	move.l	a0,(a1)+	;TRAP #4
	move.l	a0,(a1)+	;TRAP #5
	move.l	a0,(a1)+	;TRAP #6
	move.l	a0,(a1)+	;TRAP #7
	move.l	a0,(a1)+	;TRAP #8
	move.l	a0,(a1)+	;TRAP #9
	move.l	a0,(a1)+	;TRAP #10
	move.l	a0,(a1)+	;TRAP #11
	move.l	a0,(a1)+	;TRAP #12
	move.l	a0,(a1)+	;TRAP #13
	move.l	a0,(a1)+	;TRAP #14
	move.l	a0,(a1)+	;TRAP #15
	
	rts
;	Desc			D1		  D0			D2			A0			A1
;	Print char		$0		(byte)			XX			XX			XX
;	Print char		$1		(word)			XX			XX			XX
;	Send byte		$2		(byte)			XX			XX			XX
;	Print string	$3		  XX			XX		STR(byte)		XX
;	Print string	$4		  XX			XX		STR(word)		XX
;	Send string		$5		  XX			XX		STR(byte)		XX
;	Get cursor X,Y	$6	   (X,word)		 (Y,word)		XX			XX
;	Set cursor X,Y	$7	   (X,word)		 (Y,word)		XX			XX
;	Get key			$8		(byte)			XX			XX			XX
;	Peek key		$9	  (byte or 0)		XX			XX			XX
;	Chek key		$A	(byte, 0 or 1)		XX			XX			XX
;	Read sectors	$B (1st sector LBA)(sector cnt)	   PTR			XX
;	Write sectors	$C (1st sector LBA)(sector cnt)	   PTR			XX

TRAP0_handler:
	movem.l	d1,-(a7)
	cmp.b	#$0,d1
	bne		.s0
	;Print char (byte)
	bsr		x_print_char_byte
.s0:
	cmp.b	#$1,d1
	bne		.s1
	;Print char (word)
	bsr		x_print_char_word
.s1:
	cmp.b	#$2,d1
	bne		.s2
	;Send byte
	bsr		send_byte
.s2:
	cmp.b	#$3,d1
	bne		.s3
	;Print string (byte)
	bsr		x_print_byte_string
.s3:
	cmp.b	#$4,d1
	bne		.s4
	;Print string (word)
	bsr		x_print_word_string
.s4:
	cmp.b	#$5,d1
	bne		.s5
	;Send string (byte)
	bsr		send_string
.s5:
	cmp.b	#$6,d1
	bne		.s6
	;Get cursor X/Y (word, word)
	bsr		x_get_cursor_xy
	move.w	d1,d2	;Y
.s6:
	cmp.b	#$7,d1
	bne		.s7
	;Set cursor X/Y (word, word)
	move.w	d2,d1	;Y
	bsr		x_set_cursor_xy
.s7:
	cmp.b	#$8,d1
	bne		.s8
	;Chek key (1 or 0)
	bsr		kyb_get_key
.s8:
	cmp.b	#$9,d1
	bne		.s9
	;Read sectors (byte cnt)
	bsr		kyb_get_key_current
.s9:
	cmp.b	#$A,d1
	bne		.sA
	;write sectors (byte cnt)
.sA:
	

	movem.l	(a7)+,d1
	rte

TRAP_empty:	
	movem.l	d0/a0,-(a7)
	lea		msg_empty_trap,a0
	bsr		send_string
	lea		msg_empty_trap,a0
	bsr		x_print_byte_string
	movem.l (a7)+,d0/a0
	rte
msg:
	dc.b "Hello form 68k! in RAM",13,10,0
	align 2
msg_w:
	dc.w $0F41,$0F42,$0F43,$0A41,$0D41,10,13,0
msg_done:
	dc.B	13,10,"DONE!",13,10,0
msg_wrong:
	dc.b 13,"Memory test FAIL",13,10,0
msg_failed_at:
	dc.b 13,"Failed at 0x",0
msg_drv_err:
	dc.b 13,"Drive error 0x",0
msg_OK:
	dc.b 13,10,"Memory test OK",13,10,0
msg_chk:
	dc.b 13,"Checking...  "
	align 2
msg_illegal_w:
	dc.w $0450,$0441,$044E,$0449,$0443,$0420,$047C,$0420,$0449,$046C,$046C,$0465,$0467,$0461,$046C,$0420,$0469,$046E,$0473,$0474,$0472,$0475,$0463,$0474,$0469,$046F,$046E,$0000
msg_illegal:
	dc.b "PANIC | Illegal instruction"
msg_add_err:
	dc.b 13,10,"PANIC | Address error!",0
msg_add_err_w
	dc.w $0450,$0441,$044E,$0449,$0443,$0420,$047C,$0420,$0441,$0464,$0464,$0472,$0465,$0473,$0473,$0420,$0465,$0472,$0472,$046F,$0472,$0421,$0400
msg_press_enter:
	dc.b 13,10,"Press ENTER key ...",0
msg_empty_trap:
	dc.b 13,10,"Empty TRAP",0
	align	4

	align 4
	INCLUDE		"UART.asm"
	INCLUDE		"xosera.asm"
	INCLUDE		"xmodem.asm"
	INCLUDE		"PPI_KEYB_PIT.asm"
	INCLUDE		"IDE.asm"
	INCLUDE		"../common/bss.asm"


