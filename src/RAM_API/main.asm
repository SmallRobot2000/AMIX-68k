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

_start:
	bsr		init_trap0
	bsr		ppi_init
	bsr		init_tmr
	move.w	#0,(cursor_add)
	lea		msg,a0
	move	#API_PRINT_STR_BYTE,d1
	TRAP	#0
	;bsr		x_print_byte_string
	lea		msg,a0
	move	#API_PRINT_STR_BYTE,d1
	TRAP	#0
	;bsr		x_print_byte_string
	lea		msg_w,a0
	move	#API_PRINT_STR_WORD,d1
	TRAP	#0
	;bsr		x_print_word_string
	lea		msg_w,a0
	move	#API_PRINT_STR_WORD,d1
	TRAP	#0
	;bsr		x_print_word_string
	move	#$7E42,d0
	move	#API_PRINT_WORD,d1
	TRAP	#0
	TRAP	#0
	;bsr		x_print_char_word
	;bsr		x_print_char_byte
	move	#$7E42,d0
	move	#API_SEND_BYTE,d1
	TRAP	#0
	;bsr		send_string
	move.w	#1,d0
	move.w	#2,d2
	move.w	#API_SET_CURSOR_XY,d1
	TRAP	#0

.l:
	jmp		.l



;Set trap to subrutine
init_trap0:
	lea		TRAP0_handler,a0
	move.l	a0,(_exc_trap_0)
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
.s8:
	cmp.b	#$9,d1
	bne		.s9
	;Read sectors (byte cnt)
.s9:
	cmp.b	#$A,d1
	bne		.sA
	;write sectors (byte cnt)
.sA:
	

	movem.l	(a7)+,d1
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

	align 4
	INCLUDE		"UART.asm"
	INCLUDE		"xosera.asm"
	INCLUDE		"PPI_KEYB_PIT.asm"
	INCLUDE		"IDE.asm"
	INCLUDE		"../common/bss.asm"


