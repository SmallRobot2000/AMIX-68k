    section .text


SOH     equ     $01
EOT     equ     $04
ACK     equ     $06
NAK     equ     $15
ETB     equ     $17
CAN     equ     $18

;A0 - destination address for data
;clobbers: d0,d1,d2,d3,A0,d4
xmodem_receve:

st_loop:
    move    #NAK,d0
    bsr     send_byte   ;send NAK
   
    move    #1,d1       ;packet number
;started 


    
pa_loop:
    bsr     receve_byte
    move    #$20,d2       ;error code

    cmp.b   #EOT,d0     ;schek if start of header
    beq     .xfer_done
    cmp.b   #SOH,d0
    bne     .error
    addq    #1,d2       ;update error code

    bsr     receve_byte ;chek if correct packet number
    cmp.b   d0,d1
    bne     .error
    addq    #1,d2       ;update error code

    not.b   d1          ;1's complement for chek of packet number
    bsr     receve_byte
    cmp.b   d0,d1       ;if 1's complement of packet number is worng error out
    bne     .error
    addq    #1,d2       ;update error code
    not.b   d1          ;return normal number
    

    move    #127,d3     ;counter
    move    #0,d4       ;cheksum
.pa_data_loop:
    bsr     receve_byte
    move.b  d0,(a0)+
    add.b   d0,d4
    dbra    d3,.pa_data_loop

    bsr     receve_byte
    cmp.b   d0,d4       ;chek cheksum
    bne     .chksum_err ;cheksum error

    move    #ACK,d0     ;cheksum ok
    bsr     send_byte

    addq.b  #1,d1       ;increment packet number

    jmp     pa_loop
.xfer_done:
    move    #NAK,d0
    bsr     send_byte   ;end of tranmittion

    bsr     receve_byte ;must be EOT

    move    #ACK,d0
    bsr     send_byte   ;end of tranmittion - OK

    lea     msg_xmodem_ok,a0
    bsr     send_string

    rts
.chksum_err:
    move    #NAK,d0     ;cheksum not ok send packet again
    bsr     send_byte
    sub.l   #128,a0     ;decremnt pointer to start of the same packet

    bsr     receve_byte
    jmp     pa_loop     ;retry

.error:
    move.b  #CAN,d0
    bsr     send_byte   ;sends cancle
    lea     msg_xmodem_error,a0
    bsr     send_string ;print error
    move    d2,d0
    bsr     x_print_hex
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

msg_xmodem_error:
    dc.b    13,10,"Error during transfer aborting",13,10,0
msg_xmodem_ok:
    dc.b    13,10,"Transfer sucssfull",13,10,0