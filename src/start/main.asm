    section .vectors
	ORG		$000000
    dc.l   $00001000
    dc.l   _start
	dc.l	_exc_bus_err
	dc.l	_exc_add_err

	dc.l	_exc_illegal
	dc.l	_exc_dev_zero
	dc.l	_exc_err_chk
	dc.l	_exc_overflow
	dc.l	_exc_usr_privilage

	dc.l	_exc_trace
	dc.l	_exc_line1010
	dc.l	_exc_line1111

	dc.l	_exc_soft_none0
	dc.l	_exc_soft_none1
	dc.l	_exc_soft_none2 ;reserved

	dc.l	_exc_soft_none3 ;unitilized int vector

	dc.l	_exc_soft_none4
	dc.l	_exc_soft_none5
	dc.l	_exc_soft_none6
	dc.l	_exc_soft_none7
	dc.l	_exc_soft_none8
	dc.l	_exc_soft_none9
	dc.l	_exc_soft_none10
	dc.l	_exc_soft_none11
	dc.l	_exc_soft_none12

	

	;auto vectors
	dc.l	_autovec_none1	;IRQ 1
	dc.l	_autovec_none2	;IRQ 2
	dc.l	_autovec_none3	;IRQ 3
	dc.l	_autovec_none4	;IRQ 4
	dc.l	_autovec_none5	;IRQ 5 - xosera
	dc.l	_autovec_none6	;IRQ 6
	dc.l	_autovec_none7	;IRQ 7
		
	;TRAP 0-15
	dc.l	_exc_trap_VID		;Xosera
	dc.l	_exc_trap_UART		;UART
	dc.l	_exc_trap_none2	
	dc.l	_exc_trap_none3	
	dc.l	_exc_trap_none4	
	dc.l	_exc_trap_none5	
	dc.l	_exc_trap_none6	
	dc.l	_exc_trap_none7	
	dc.l	_exc_trap_none8	
	dc.l	_exc_trap_none9	
	dc.l	_exc_trap_none10	
	dc.l	_exc_trap_none11	
	dc.l	_exc_trap_none12	
	dc.l	_exc_trap_none13	
	dc.l	_exc_trap_none14	
	dc.l	_exc_trap_none15	

PWR_TRIG		equ 	$FFFFFF
RAM_START		equ     $100000
STACK_START		equ		RAM_START+$1EFF0
program			equ		RAM_START+$1F000
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

DEBUG		equ		1
	section .text

	INCLUDE 	"xmodem.asm"
	INCLUDE		"xosera.asm"
	INCLUDE		"dmac.asm"
	INCLUDE		"PPI_KEYB_PIT.asm"
	INCLUDE		"bss.asm"
	section .text
_start:
	lea		STACK_START,a7	;set up stack
	lea 	UART_BASE,a0
	move.b  #$80,(UART_LCR,a0) ; Enable DLAB
    ; Set divisor latch for 9600 baud
	;move.b  #$78,(UART_DLL,a0) ; 9600 baud @ 18.432 MHz
	move.b  #$0A,(UART_DLL,a0) 	; 115200 baud @ 18.432 MHz
	move.b  #$00,(UART_DLM,a0) 

    ; 8N1, DLAB=0
	move.b  #$03,(UART_LCR,a0)

	;FIFO enable
	move.b 	#$07,(UART_FCR,a0)

	jsr		clear_ram
	;jsr		receve_byte
	;move.w  #$2700,sr	;disable interupts
	jsr		wait_for_x
	jsr		init_xosera	

	jsr		x_update_screen
	jsr		init_DMAC
	jsr		ppi_init
	

	lea		msg,a0
	move	#1,d1		;Xosera MODE 1 - a0 string
	TRAP	#0
	move	#3,d1
	TRAP	#0			;Xosera update screen

	
	lea		program,a0
	jsr		xmodem_receve

.wait:
	
	jsr		receve_byte
	cmp		#13,d0
	bne		.wait
	lea		program,a0
	
	jsr		(a0)		;jump to loaded program
.stop:

	;move.b #$FF,(PWR_TRIG)
	jmp *
clear_ram:	
	lea		RAM_START,a0
	move	#$FFFF/2,d0
.loop:
	move.w	#0,(a0)+
	dbra	d0,.loop
	rts
wait_for_x:	
	move	#$0002,d1
.l1:
	move	#$FFFF,d0
.l2:
	nop
	nop
	nop
	dbra	d0,.l2
	dbra	d1,.l1
	rts
;d1 - MODE
;MODE 0 - d0 - byte to send, MODE 1 - a0 string to send, MODE 2 - halting receve in d0
_exc_trap_UART:
	cmp		#0,d1
	bne		.mode1tst
	jsr		send_byte
	rte
.mode1tst:
	cmp		#1,d1
	bne		.mode2tst
	jsr		send_string
	rte
.mode2tst:
	jsr		receve_byte
	rte
;d0 - data
send_byte:
	movem.l d1/a0,-(a7)           ; Save registers
	lea		UART_BASE,a0
.loop:
	move.b 	(UART_LSR,a0),d1
	btst	#5,d1 ;test bit 5 of d1 register
	beq		.loop ;if 0 loop
	move.b  d0,(UART_BASE)
	movem.l (a7)+,d1/a0           ; Restore registers
	rts

;wait 
receve_byte:
	move.l 	a0,-(a7)           ; Save registers
	lea		UART_BASE,a0
.loop:
	move.b 	(UART_LSR,a0),d0
	btst	#0,d0 ;test bit 5 of d1 register
	beq		.loop ;if 0 loop
	
	move.b  (UART_RBR,a0),d0
	movem.l	(a7)+,a0
	rts

;a0 - string address
send_string:
	movem.l	d0/a1,-(a7)
	lea 	UART_BASE,a1
	
.loop:
	move.b 	(UART_LSR,a1),d0
	btst	#5,d0 	;test bit 5 of d1 register
	beq		.loop 	;if 0 loop
	tst.b	(a0)
	beq		.end	;is 0
	move.b  (a0)+,(UART_THR,a1)
	jmp 	.loop
.end:
	movem.l	(a7)+,d0/a1
	rts

; --------------------------------------------------------------
; print_hex_a0
;  Prints the contents of A0 as an 8-digit hexadecimal number
;  Input : A0 = 32-bit address
;  Clobbers: D0, D1
; --------------------------------------------------------------
print_hex_add:
    movem.l d0-d2/a1,-(a7)      ; Save used registers

    move.l  A0,D1              ; Copy address to D1
    moveq   #8-1,D2            ; Loop 8 times (8 hex digits)

    lea     UART_BASE,A1       ; UART base address

.hex_loop:
	move.l	d1,d0
	lsr.l	#8,d0
	lsr.l	#8,d0
	lsr.l	#8,d0
	lsr.l	#4,d0         		; Shift down to get correct nibble
    andi.b  #$0F,D0            	; Mask single nibble

	lsl.l	#4,d1				;put new nibble to highest nibble

    cmpi.b  #9,D0
    ble     .digit
    addi.b  #'A'-10,D0
    bra     .send
.digit:
    addi.b  #'0',D0
.send:
    jsr     send_byte

    dbra    D2,.hex_loop       ; Loop for all 8 digits

    movem.l (a7)+,d0-d2/a1      ; Restore registers
    rts


test_RAM:
	move	(a7),d7 		;save return address
;safe zone
	move	#0,d0
	move.l	#$100000,d1		;loop
	lea.l		RAM_START,a0
.loop1:						;1M words = 2MB
	move.w	d0,(a0)+
	addq.w	#1,d0
	subq.l	#1,d1
	bne		.loop1

	move	#0,d2
	move.l	#$100000,d1		;loop
	lea.l	RAM_START,a0
.loop2:						;chek loop
	move.w	(a0)+,d0
	cmp.w	d2,d0
	bne		.error
	addq.l	#1,d2
	subq.l	#1,d1
	bne		.loop2

	
	move	d7,(a7)	;return address of return
	lea		msg_OK,a0
	jsr		send_string
	rts
.error:
	move	d7,(a7)	;return address of return

	move	a0,a2
	lea		msg_wrong,a0
	jsr 	send_string
	lea		msg_failed_at,a0
	jsr 	send_string
	move	a2,a0
	jsr 	print_hex_add
	
	rts
_autovec_none:
	move.l	d0,-(a7)
	move	#'X',d0
	jsr		send_byte
	move.l	(a7)+,d0
	rte

_exc_illegal:
	move	d0,-(a7)
	move.b	#'0',d0
	jmp		print_exeption
_exc_bus_err:
	move	d0,-(a7)
	move.b	#'1',d0
	jmp		print_exeption
_exc_add_err:
	move	d0,-(a7)
	move.b	#'2',d0
	jmp		print_exeption
_exc_dev_zero:
	move	d0,-(a7)
	move.b	#'3',d0
	jmp		print_exeption
_exc_err_chk:
	move	d0,-(a7)
	move.b	#'4',d0
	jmp		print_exeption
_exc_overflow:
	move	d0,-(a7)
	move.b	#'5',d0
	jmp		print_exeption
_exc_usr_privilage:
	move	d0,-(a7)
	move.b	#'6',d0
	jmp		print_exeption
_exc_trace:
	move	d0,-(a7)
	move.b	#'7',d0
	jmp		print_exeption
_exc_line1010:
	move	d0,-(a7)
	move.b	#'8',d0
	jmp		print_exeption
_exc_line1111:
	move	d0,-(a7)
	move.b	#'9',d0
	jmp		print_exeption
_exc_soft_none:
	move	d0,-(a7)
	move.b	#'A',d0
	jmp		print_exeption

_exc_soft_none0:
	move	d0,-(a7)
	move.b	#'B',d0
	jmp		print_exeption
_exc_soft_none1:
	move	d0,-(a7)
	move.b	#'C',d0
	jmp		print_exeption
_exc_soft_none2: ;
	move	d0,-(a7)
	move.b	#'D',d0
	jmp		print_exeption
_exc_soft_none3: ;
	move	d0,-(a7)
	move.b	#'E',d0
	jmp		print_exeption
_exc_soft_none4:
	move	d0,-(a7)
	move.b	#'F',d0
	jmp		print_exeption
_exc_soft_none5:
	move	d0,-(a7)
	move.b	#'G',d0
	jmp		print_exeption
_exc_soft_none6:
	move	d0,-(a7)
	move.b	#'H',d0
	jmp		print_exeption
_exc_soft_none7:
	move	d0,-(a7)
	move.b	#'I',d0
	jmp		print_exeption
_exc_soft_none8:
	move	d0,-(a7)
	move.b	#'J',d0
	jmp		print_exeption
_exc_soft_none9:
	move	d0,-(a7)
	move.b	#'K',d0
	jmp		print_exeption
_exc_soft_none10:
	move	d0,-(a7)
	move.b	#'L',d0
	jmp		print_exeption
_exc_soft_none11:
	move	d0,-(a7)
	move.b	#'M',d0
	jmp		print_exeption
_exc_soft_none12:
	move	d0,-(a7)
	move.b	#'N',d0
	jmp		print_exeption


_exc_trap_none1:
	move	d0,-(a7)
	move.b	#'O',d0
	jmp		print_exeption
_exc_trap_none2:
	move	d0,-(a7)
	move.b	#'P',d0
	jmp		print_exeption
_exc_trap_none3:
	move	d0,-(a7)
	move.b	#'R',d0
	jmp		print_exeption
_exc_trap_none6:
	move	d0,-(a7)
	move.b	#'S',d0
	jmp		print_exeption
_exc_trap_none7:
	move	d0,-(a7)
	move.b	#'T',d0
	jmp		print_exeption

_exc_trap_none0:	
	move	d0,-(a7)
	move.b	#'U',d0
	jmp		print_exeption
_exc_trap_none4:	
	move	d0,-(a7)
	move.b	#'Q',d0
	jmp		print_exeption
_exc_trap_none5:	
	move	d0,-(a7)
	move.b	#'a',d0
	jmp		print_exeption
_exc_trap_none8:	
	move	d0,-(a7)
	move.b	#'d',d0
	jmp		print_exeption
_exc_trap_none9:	
	move	d0,-(a7)
	move.b	#'e',d0
	jmp		print_exeption
_exc_trap_none10:
	move	d0,-(a7)
	move.b	#'f',d0
	jmp		print_exeption
_exc_trap_none11:
	move	d0,-(a7)
	move.b	#'g',d0
	jmp		print_exeption
_exc_trap_none12:
	move	d0,-(a7)
	move.b	#'h',d0
	jmp		print_exeption
_exc_trap_none13:
	move	d0,-(a7)
	move.b	#'i',d0
	jmp		print_exeption
_exc_trap_none14:
	move	d0,-(a7)
	move.b	#'j',d0
	jmp		print_exeption
_exc_trap_none15:
	move	d0,-(a7)
	move.b	#'k',d0
	jmp		print_exeption
_autovec_none1:
	move	d0,-(a7)
	move.b	#'l',d0
	jmp		print_exeption
_autovec_none2:
	move	d0,-(a7)
	move.b	#'m',d0
	jmp		print_exeption
_autovec_none3:
	move	d0,-(a7)
	move.b	#'n',d0
	jmp		print_exeption
_autovec_none4:
	move	d0,-(a7)
	move.b	#'o',d0
	jmp		print_exeption
_autovec_none5:
	move	d0,-(a7)
	move.b	#'p',d0
	jmp		print_exeption
_autovec_none6:
	move	d0,-(a7)
	move.b	#'r',d0
	jmp		print_exeption
_autovec_none7:
	move	d0,-(a7)
	move.b	#'s',d0
	jmp		print_exeption
print_exeption:
	jsr	send_byte
	move	(a7)+,d0
	
	rte


	section .rodata
msg:
	dc.b 13,"Hello form 68k!",13,10,0

msg_wrong:
	dc.b 13,"Memory test FAIL",13,10,0
msg_failed_at:
	dc.b 13,"Failed at 0x",0

msg_OK:
	dc.b 13,"Memory test OK",13,10,0










