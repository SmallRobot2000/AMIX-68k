
    section .text

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
