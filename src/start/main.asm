    section .vectors
	ORG		$000000
    dc.l   STACK_START
    dc.l   _start


PWR_TRIG		equ 	$FFFFFF
RAM_START		equ     $100000
STACK_START		equ		RAM_START+$1F000
program			equ		RAM_START+$20000
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
	INCLUDE		"../common/bss.asm"
	section .text
_start:
	move.w  #$2700,sr	;disable interupts
	jsr		clear_ram
	jsr		init_EXC
	jsr		UART_init
	jsr		wait_for_x
	jsr		init_xosera
	jsr		init_DMAC
	jsr		ppi_init
	

	lea		msg,a0
	jsr		send_string
	lea		msg,a0
	jsr		x_print_string
	jsr		x_update_screen

	
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
UART_init:	
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
	rts
trap0_code:	
	lea		msg_t0,a0
	jsr		x_print_string
	jsr		x_update_screen
	rte
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
init_EXC:	
	lea		Vector_table_start,a0

	move.l	#Vector_table_start,d0
	movec	d0,vbr
	move	#255,d0
.l1:
	move.l	#empty_exeption,(a0)+
	dbra	d0,.l1
	rts


empty_exeption:
	lea		msg_empty,a0
	jsr		send_string
	rte	

;d0 - hex
print_hex:	
	movem.l	d0/d1/d2/a0,-(a7)
	lea		tmp_str,a0

	move	#7,d2
	move.l	d0,d1
	andi.l	#$FFFF0000,d1	;see if long
	tst.l	d1
	bne		.l1

	move	#3,d2
	move	d0,d1
	swap	d0
	and.w	#$FF00,d1		;see if word
	tst		d1
	bne		.l1
	;must be byte
	lsl.l	#8,d0
	move	#1,d2	;byte
.l1:
	move.l	d0,d1
	swap	d1
	lsr.w	#8,d1
	lsr.w	#4,d1	
	and.l	#$0000000F,d1	;mask 0-3 bits
	lsl.l	#4,d0
	;print hexa bits in d1 0-3

	cmpi.b  #9,d1
    ble     .digit
    addi.b  #'A'-10,d1
    bra     .send
.digit:
    addi.b  #'0',d1
.send:
	move.b	d1,(a0)+
	dbra	d2,.l1
	move.b	#0,(a0)+

	lea		tmp_str,a0
	move	#1,d1
	TRAP	#0	;print string
	movem.l	(a7)+,d0/d1/d2/a0
	rts

	section .rodata
msg:
	dc.b 13,"Hello form 68k!",13,10,0
msg_empty:
	dc.b "Empty exec",0
msg_wrong:
	dc.b 13,"Memory test FAIL",13,10,0
msg_failed_at:
	dc.b 13,"Failed at 0x",0

msg_OK:
	dc.b 13,"Memory test OK",13,10,0
msg_t0:
	dc.b "Hello TRAP #0",0









