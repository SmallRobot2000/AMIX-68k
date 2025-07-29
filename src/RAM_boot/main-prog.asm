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


;DEBUG
DEBUG	equ		1
CHK_SIZE	equ		65536
_start:
	move	#0,d0
	move	#0,d1
	jsr		set_cursor_xy
	lea		msg,a0
	jsr		print_string
	jsr		print_string
	jsr		IDE_init
	move.w	#0,d3
	;d4 "seed"
.loop_again:
	lea		buffer,a0
	move.w	#CHK_SIZE-1,d1
	move.l	d4,d0
.loop_tst:
	add.l	#2,d0
	move.l	d0,(a0)+
	dbra	d1,.loop_tst


	move.l	#$00000004,d0
	move.b	#CHK_SIZE/512,d1
	lea		buffer,a0
	jsr		IDE_write_sectors_LBA

	jsr		update_scren
	move.l	#$00000004,d0
	move.w	#CHK_SIZE/512,d1
	lea		buffer,a0
	jsr		IDE_read_sectors_LBA

	lea		msg_chk,a0
	jsr		print_string
	move.w	d3,d0
	
	jsr		print_hex
	;jsr		update_scren
	
	lea		buffer,a0
	move	#CHK_SIZE-1,d1
	move.l	d4,d0
.loop_chk:
	add.l	#2,d0
	cmp.l	(a0)+,d0
	bne		.err
	dbra	d1,.loop_chk
	jsr		update_scren

	addq.w	#1,d3
	move.l	d3,d4
	move.l	d4,d0

	jmp		.loop_again

.err:
	lea		msg_failed_at,a0
	jsr		print_string
	sub.w	#$ff,d1
	move	d1,d0
	and.l	#$0000FFFF,d0
	jsr		print_hex
	jsr		update_scren
	jmp		*
	;jsr		DUMP_hex
	
.stop:
	move	#3,d1
	TRAP	#0	;update screen
	jmp .stop	
send_byte:
	move.l	d1,-(a7)
	move	#0,d1
	TRAP	#1
	move.l	(a7)+,d1
	rts
print_hex_add:
    movem.l d0/d1/d2/a1,-(a7)      ; Save used registers

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

    movem.l (a7)+,d0/d1/d2/a1      ; Restore registers
    rts

update_scren:
	move.l	d1,-(a7)
	move	#3,d1
	TRAP	#0
	move.l	(a7)+,d1
	rts
print_char:
	move.l	d1,-(a7)
	move	#0,d1
	TRAP	#0
	move.l	(a7)+,d1
	rts
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

;d0 - x, d1 - y
set_cursor_xy:
	movem.l	d0/d1/a0,-(a7)
	mulu.w	#80,d1
	add.w	d1,d0

	move	#4,d1	;get cursor add in a0
	TRAP	#0

	move.w	d0,(a0)

	movem.l	(a7)+,d0/d1/a0
	rts

;d0 - x, d1 - y
get_cursor_xy:
	movem.l	a0,-(a7)
	move	#4,d1	;get cursor add in a0
	TRAP	#0

	move.l	#0,d0
	move.w	(a0),d0

	divu	#80,d0	;D0 hi = x, D0 lo = y
	move.w	d0,d1	;y
	swap	d0		;x
	and.l	#$0000FFFF,d0 ; mask only x

	movem.l	(a7)+,a0
	rts

print_CR:
	movem.l	d0/d1,-(a7)
	jsr		get_cursor_xy
	move.w	#0,d0
	jsr		set_cursor_xy
	movem.l (a7)+,d0/d1
	rts
print_NL:
	movem.l	d0/d1,-(a7)
	jsr		get_cursor_xy
	add.w	#1,d1
	jsr		set_cursor_xy
	movem.l (a7)+,d0/d1
	rts
	
;a0 - string - depended on buffer size of tmp_str
print_string:
	movem.l	d0/d1/a0/a1/a2,-(a7)
	lea		tmp_str,a2
	move.l	a0,a1
.l1:
	move.b	(a1)+,d0	;main string
	tst.b	d0
	beq		.end
	cmp.b	#13,d0
	bne		.l1s1
	move.b	#0,(a2)+	;tmp string
	lea		tmp_str,a0	;tmp stirng in a0
	move	#1,d1
	TRAP	#0			;print everything until now
	lea		tmp_str,a2	;tmp stirng in a2 again from start
	jsr		print_CR	;make CR
	jmp		.l1
.l1s1:
	cmp.b	#10,d0
	bne		.l1s2
	move.b	#0,(a2)+	;tmp string
	lea		tmp_str,a0	;tmp stirng in a0
	move	#1,d1
	TRAP	#0			;print everything until now
	lea		tmp_str,a2	;tmp stirng in a2 again from start
	jsr		print_NL	;make NL
	jmp		.l1
.l1s2:
	move.b	d0,(a2)+
	jmp		.l1
.end:
	;we done print whats in buffer
	move.b	#0,(a2)+
	lea		tmp_str,a0
	move	#1,d1
	TRAP	#0		;print string
	movem.l	(a7)+,d0/d1/a0/a1/a2
	rts
send_NL:
	move.l	d0,-(a7)
	move    #10,d0
    jsr     send_byte
    move    #13,d0
    jsr     send_byte
	move.l	(a7)+,d0
	rts

DUMP_hex:	
	move.l	d0,d1
	move.l	#0,d0
	move.l	#0,d2
.loop:
	move.b	(a0)+,d0
	jsr		print_hex
	move	#' ',d0
	jsr		print_char
	cmp.b	#$0F,d2
	bne		.l_skip1
	move	#0,d2
	jsr		print_NL
	jsr		print_CR
	subq.l	#1,d1
	bne		.loop
	jmp		.end
.l_skip1:
;cd 12 b1 8e d8 a1 e6

	addq.b	#1,d2	;counter 8 bit
	subq.l	#1,d1
	tst.l	d1
	bne		.loop
.end:
	rts
	INCLUDE		"xosera.asm"
	INCLUDE		"PPI_KEYB_PIT.asm"
	INCLUDE		"IDE.asm"
tmp_str:
	ds.b	2000	;reserve 16 bytes
msg:
	dc.b 13,10,"Hello form 68k! in RAM",13,10,0
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
cursor_pos:
	dc.w 0
cursor_add:
	dc.w 0
cursor_state: ;bit 0 - what needs to be, bit 1 - what it is
	dc.w 0
last_cursor_pos:
	dc.w 0
last_cursor_add:
	dc.w 0
last_cursor_state:
	dc.w 0

kyb_wait:
	dc.l 0
kyb_last:
	dc.w 0
kyb_flags:
	dc.w 0

FRAME:
	dc.l 0	;TODO add interupt that increments this every frame(for now it in loop)
x_screen:
	ds.w 80*25
	align 4
buffer:
	ds.w $2000

;sys data

