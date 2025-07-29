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

_start:
	lea		msg,a0
	jsr		send_string

	move	#$0341,d0
	lea     x_screen,a0
    lea     cursor_add,a1
    move.w  (a1),d1
    lsl.w   #1,d1       ;*2 for even address
    move.w  d0,(a0,d1)


	move	#'A',d0
	jsr 	send_byte
.stop:
	;jsr		peek_byte
	jsr		kyb_get_key
	beq		.skip
	move	#DEFAULT_FR,d1
	move	#DEFAULT_BG,d2
	jsr		set_char_colors
	jsr		x_print_char
	
.skip
	;wait for VBLANK and increment
	lea		XM_BASE,a0
.wait_vblank:
	movep	(XM_SYS_CTRL,a0),d0
	btst	#10,d0
	beq		.wait_vblank
	lea		FRAME,a0
	addq.l	#1,(a0)
	jsr		x_update_screen
	
	jmp .stop

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
peek_byte: ;zero flag if no byte
	move.l 	a0,-(a7)           ; Save registers
	lea		UART_BASE,a0
	move.b 	(UART_LSR,a0),d0
	btst	#0,d0 ;test bit 5 of d1 register
	beq		.end ;if 0 end
	
	move.b  (UART_RBR,a0),d0
.end:
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
send_NL:
	move.l	d0,-(a7)
	move    #10,d0
    jsr     send_byte
    move    #13,d0
    jsr     send_byte
	move.l	(a7)+,d0
	rts
	INCLUDE		"xosera.asm"
	INCLUDE		"PPI_KEYB_PIT.asm"

msg:
	dc.b 13,10,"Hello form 68k! in RAM",13,10,0

msg_wrong:
	dc.b 13,"Memory test FAIL",13,10,0
msg_failed_at:
	dc.b 13,"Failed at 0x",0

msg_OK:
	dc.b 13,10,"Memory test OK",13,10,0
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

;sys data

