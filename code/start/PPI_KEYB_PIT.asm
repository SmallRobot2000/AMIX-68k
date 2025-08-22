    section .text
PPI_BASE        equ     $FF3000

;I/O - *2 because R0 is A1
PPI_PGC         equ     $00*2
PPI_P_SERV_REQ  equ     $01*2
PPI_PA_DDIR     equ     $02*2
PPI_PB_DDIR     equ     $03*2
PPI_PC_DDIR     equ     $04*2
PPI_INT_VECTOR  equ     $05*2
PPI_PA_CTRL     equ     $06*2
PPI_PB_CTRL     equ     $07*2
PPI_PA_DATA     equ     $08*2
PPI_PB_DATA     equ     $09*2
PPI_PA_ALT      equ     $0A*2
PPI_PB_ALT      equ     $0B*2
PPI_PC_DATA     equ     $0C*2
PPI_P_STAT      equ     $0D*2
;PIT
PPI_TMR_CTRL    equ     $10*2
PPI_TMR_INT_VEC equ     $11*2
;NULL
PPI_TMR_CNT_P_H equ     $13*2
PPI_TMR_CNT_P_M equ     $14*2
PPI_TMR_CNT_P_L equ     $15*2
;NULL
PPI_TMR_CNR_R_H equ     $17*2
PPI_TMR_CNR_R_M equ     $18*2
PPI_TMR_CNR_R_L equ     $19*2
PPI_TMR_STAT    equ     $1A*2


;ignoring timer for now
ppi_init:
    lea     PPI_BASE,a0
    move.b  #$00,(PPI_PGC,a0)           ;clear H12(Porta A) and H34(Port B)
    move.b  #$80,(PPI_PA_CTRL,a0)       ;Port A submode 2(10) evrything disabled
    move.b  #$00,(PPI_PB_CTRL,a0)       ;Port B submode 0 evrything disabled

    move.b  #$00,(PPI_PA_DDIR,a0)       ;Set all pins to input in port A
    move.b  #$FF,(PPI_PB_DDIR,a0)       ;Set all pins to output in port B

    move.b  #$00,(PPI_PC_DDIR,a0)       ;Set all pins to input in port C
    move.b  #$30,(PPI_PGC,a0)           ;Enable Ports A and B, MODE 0

    move.b  #0,(kyb_flags)
    rts
kyb_get_key:    
    movem.l d1/d2/d3/a0/a1/a2/a3,-(a7)
    jsr     kyb_get_key_current
    beq     .wait_for_key
.wait_for_key_end:
    lea     kyb_last,a0
    lea     kyb_wait,a1
    lea     tmr_cnt,a2
    move.b  d0,d3   ;save cur cahar
    move.b  (a0),d1 ;last char
    cmp.b   d0,d1
    bne     .new_char
    jsr     send_byte
    move.l  (a1),d0 ;get tmr_cnt TARGET
    
.wait:

    ifne DEBUG
    lea		XM_BASE,a3
.wait_vblank:
	movep	(XM_SYS_CTRL,a3),d2
	btst	#10,d2
    bne     .wait_vblank

    movep	(XM_SYS_CTRL,a3),d2
	btst	#10,d2
	beq		.wait_vblank
	addq.l	#1,(a2)

    endif

    move.l  (a2),d1
    cmp.l   d0,d1
    blo     .wait       ;branch if lower - still waiting
    ;see if still pressed
    jsr     kyb_get_key_current
    cmp.b   d0,d3
    bne     .wait_for_key
    ;end of wait
    add.l   #KYB_SHORT_WAIT,d1   ;new frame target
    move.l    d1,(a1) ;update wait target
    move.b  (a0),d0   ;get char
    jmp     .end
.new_char
    lea     kyb_last,a0
    lea     kyb_wait,a1
    lea     tmr_cnt,a2
    move.l  (a2),d1
    add.l   #KYB_LONG_WAIT,d1
    move.l  d1,(a1) ;update kyb_wait
    move.b  d0,(a0) ;update last char
    
.end:
    movem.l (a7)+,d1/d2/d3/a0/a1/a2/a3
    rts
.wait_for_key:
    jsr     kyb_get_key_current
    beq     .wait_for_key
    lea     kyb_last,a0
    move.b  #0,(a0) ;reset last key
    jmp     .wait_for_key_end


kyb_get_key_current:
    move    d1,-(a7)
    move    #KYB_ROWS-1,d1
    move    #0,d2
.loop:  
    move    d2,d0
    addq    #$1,d2
    jsr     get_key_in_row
    tst.b   d0
    bne     .end
    dbra    d1,.loop
.end:
    move    (a7)+,d1
    ;move    #0,d0
    tst     d0
    rts
;d0 - row
;zero flag if nothing
;get firs key
get_key_in_row:
    movem.l d1/d2,-(a7)
    move    d0,d2
    jsr     kyb_get_row_data
    cmp.b   #$FF,d0
    beq     .end_empty
    ;find where is 0 and add that bit's offset
    move    #0,d1
.loop:
    btst    #0,d0
    beq     .end_loop
    lsr.b   #1,d0
    addq.b  #1,d1
    jmp     .loop
.end_loop: ;offset in d1
    move    d2,d0   ;row
    jsr     get_key_from_matrix
    tst     d0  ;clear zero flag  
.end: 
    movem.l (a7)+,d1/d2
    rts
.end_empty:
    move    #0,d0
    movem.l (a7)+,d1/d2
    rts


;10 rows
;d0 - row
;return as byte in d0
kyb_get_row_data:
    move.l  a0,-(a7)
    lea     PPI_BASE,a0
    and.b   #$F0,(PPI_PB_DATA,a0)   ;mask out raw number
    or.b    d0,(PPI_PB_DATA,a0)
    move.b  (PPI_PA_DATA,a0),d0      ;get colums
    move.l  (a7)+,a0
    rts   
;d1 - bit
;d0 - row
get_key_from_matrix:
    movem.l d1/a0,-(a7)
    lsl.w   #3,d0       ;*8 for correct row offset 
    add.w   d0,d1       ;Final offset
;We see if shift or ctrl needed
    lea     kyb_flags,a0
    btst    #KYB_FLG_BIT_CAPS,(a0)
    bne     .SHIFTED
    btst    #KYB_FLG_BIT_SHIFT,(a0)
    bne     .SHIFTED
    lea     kyb_matrix_normal,a0
    move.b  (a0,d1),d0
    movem.l (a7)+,d1/a0
    rts
.SHIFTED:
    lea     kyb_matrix_shifted,a0
    move    (a0,d1),d0
    movem.l (a7)+,d1/a0
    rts

;flag bits, used with btst
KYB_FLG_BIT_SHIFT   equ     $00
KYB_FLG_BIT_CAPS    equ     $01
KYB_FLG_BIT_CTRL    equ     $02

KYB_ROWS            equ     9

KYB_LONG_WAIT       equ    10
KYB_SHORT_WAIT      equ   2


KYB_SHIFT       equ     $80
KYB_CTRL        equ     $81
KYB_ALT         equ     $82
KYB_CAPS        equ     $83
KYB_CODE        equ     $84 ;Fn key
KYB_F1          equ     $91
KYB_F2          equ     $92
KYB_F3          equ     $93
KYB_F4          equ     $94
KYB_F5          equ     $95
KYB_ESC         equ     $1B
KYB_TAB         equ     $A1
KYB_END         equ     $A2
KYB_BS          equ     $08
KYB_SEL         equ     $A4 ;win key
KYB_RET         equ     $0D ;return enter key
KYB_HOME        equ     $A6
KYB_INS         equ     $A7
KYB_CLS         equ     $A8 ;Home shifted
KYB_DEL         equ     $7F
KYB_ARROW_LEFT  equ     $B0
KYB_ARROW_UP    equ     $B1
KYB_ARROW_DOWN  equ     $B2
KYB_ARROW_RIGHT equ     $B3  

    section .rodata
kyb_matrix_normal:
    ;Bit     0    1    2    3    4    5    6    7
    dc.b    '0', '1', '2', '3', '4', '5', '6', '7'  ;ROW 0
    dc.b    '8', '9', '-', '=', '\', '[', ']', ';'  ;ROW 1
    dc.b    $27, '`', ',', '.', '/', $FF, 'a', 'b'  ;ROW 2
    dc.b    'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'  ;ROW 3
    dc.b    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r'  ;ROW 4
    dc.b    's', 't', 'u', 'v', 'w', 'x', 'y', 'z'  ;ROW 5
    dc.b    $80, $81, $82, $83, $84, $91, $92, $93  ;ROW 6
    dc.b    $94, $95, $1B, $A1, $A2, $08, $A4, $A5  ;ROW 7
    dc.b    ' ', $A6, $A7, $7F, $B0, $B1, $B2, $B3  ;ROW 8
kyb_matrix_shifted:
    ;Bit     0    1    2    3    4    5    6    7
    dc.b    ')', '!', '@', '#', '$', '%', '^', '&'  ;ROW 0
    dc.b    '*', '(', '_', '+', '|', '{', '}', ':'  ;ROW 1
    dc.b    '"', '~', '<', '>', '?', $FE, 'A', 'B'  ;ROW 2
    dc.b    'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'  ;ROW 3
    dc.b    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R'  ;ROW 4
    dc.b    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'  ;ROW 5
    dc.b    $80, $81, $82, $83, $84, $96, $97, $98  ;ROW 6
    dc.b    $99, $9A, $1B, $A1, $A2, $08, $A4, $0D  ;ROW 7
    dc.b    ' ', $A8, $A7, $7F, $B0, $B1, $B2, $B3  ;ROW 8


