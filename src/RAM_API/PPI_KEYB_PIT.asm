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
    move.b  #$FF,(PPI_PC_DDIR,a0)

    move.b  #$00,(PPI_PC_DDIR,a0)       ;Set all pins to input in port C
    move.b  #$30,(PPI_PGC,a0)           ;Enable Ports A and B, MODE 0

    move.b  #0,(kyb_flags)
    rts

;returns key in d0
kyb_get_key:    
    movem.l d1/d2/d3/a0/a1/a2/a3,-(a7)
    bsr     kyb_get_key_current
    beq     .wait_for_key
.wait_for_key_end:
    lea     kyb_last,a0
    lea     kyb_wait,a1
    lea     tmr_cnt,a2
    move.b  d0,d3   ;save cur cahar
    move.b  (kyb_last),d1 ;last char
    cmp.b   d0,d1
    bne     .new_char    
    
.wait:
    bsr     kyb_get_key_current
    cmp.b   d0,d3           ;chek if changed
    bne     .wait_for_key

    move.l  (tmr_cnt),d1
    cmp.l   (kyb_wait),d1
    blo     .wait       ;branch if lower - still waiting
    ;end of wait
.wait_end:
    move.l  (tmr_cnt),d1
    add.l   #KYB_SHORT_WAIT_FRAMES,d1   ;new frame target
    move.l    d1,(kyb_wait) ;update wait target
    move.b  (kyb_last),d0   ;get char
    jmp     .end
.new_char
    lea     kyb_last,a0
    lea     kyb_wait,a1
    move.l  (tmr_cnt),d1
    add.l   #KYB_LONG_WAIT_FRAMES,d1
    move.l  d1,(a1) ;update kyb_wait
    move.b  d0,(a0) ;update last char
    
.end:
    movem.l (a7)+,d1/d2/d3/a0/a1/a2/a3
    rts
.wait_for_key:
    bsr     kyb_get_key_current
    beq     .wait_for_key
    move.b  #0,(kyb_last) ;reset last key
    move.l  (tmr_cnt),(kyb_wait)
    jmp     .wait_for_key_end


kyb_get_key_current:
    movem.l d1/d2,-(a7)
    
   
    move    #5,d1 ;rows 0-5 and 7-8
    move    #0,d2
.loop:  
    move    d2,d0
    addq    #$1,d2
    bsr     get_key_in_row
    tst.b   d0
    bne     .end
    dbra    d1,.loop
    move    #7,d0   ;row 7 for ret and others
    bsr     get_key_in_row
    tst.b   d0
    bne     .end
    move    #8,d0   ;row 8 for space and others
    bsr     get_key_in_row
.end:

    tst.b   d0
    movem.l (a7)+,d1/d2
    rts
;d0 - row
;zero flag if nothing
;get firs key
get_key_in_row:
    movem.l d1/d2,-(a7)
    move    d0,d2
    bsr     kyb_get_row_data
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
    bsr     get_key_from_matrix
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
    STI     ;temporary disable interupts
    lea     PPI_BASE,a0
    and.b   #$F0,(PPI_PB_DATA,a0)   ;mask out raw number
    or.b    d0,(PPI_PB_DATA,a0)
    move.b  (PPI_PA_DATA,a0),d0      ;get colums
    CLI     ;enable interuts
    move.l  (a7)+,a0
    rts   
;d1 - bit
;d0 - row
get_key_from_matrix:
    movem.l d1/a0,-(a7)
    lsl.w   #3,d0       ;*8 for correct row offset 
    add.w   d0,d1       ;Final offset
;We see if shift or ctrl needed
    btst    #KYB_FLG_BIT_CAPS,(kyb_flags)
    beq     .SHIFTED                        ;HOW
    btst    #KYB_FLG_BIT_SHIFT,(kyb_flags)
    beq     .SHIFTED                        ;HOW
    lea     kyb_matrix_normal,a0
    move.b  (a0,d1),d0
    movem.l (a7)+,d1/a0
    rts
.SHIFTED:
    lea     kyb_matrix_shifted,a0
    move.b  (a0,d1),d0
    movem.l (a7)+,d1/a0
    rts

;flag bits, used with btst
KYB_FLG_BIT_SHIFT  equ     $00
KYB_FLG_BIT_CAPS   equ     $01
KYB_FLG_BIT_CTRL   equ     $02
KYB_FLG_BIT_ALT    equ     $03
KYB_FLG_BIT_CODE   equ     $04
KYB_FLG_BIT_CODE_L equ     $05
KYB_FLG_BIT_CAPS_L equ     $06
KYB_ROWS            equ     9

KYB_LED_CAPS_BIT    equ    $04
KYB_LED_CODE_BIT    equ    $05

KYB_LONG_WAIT_FRAMES equ    8
KYB_SHORT_WAIT_FRAMES equ   3


KYB_SHIFT       equ     $80
KYB_CTRL        equ     $81
KYB_ALT         equ     $82 ;GRAPH key
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
KYB_RET         equ     $0A ;return enter key
KYB_HOME        equ     $A6
KYB_INS         equ     $A7
KYB_CLS         equ     $A8 ;Home shifted
KYB_DEL         equ     $7F
KYB_ARROW_LEFT  equ     $B0
KYB_ARROW_UP    equ     $B1
KYB_ARROW_DOWN  equ     $B2
KYB_ARROW_RIGHT equ     $B3  

    ;section .rodata
    align 4
kyb_matrix_normal:
    ;Bit     0    1    2    3    4    5    6    7
    dc.b    '0', '1', '2', '3', '4', '5', '6', '7'  ;ROW 0
    dc.b    '8', '9', '-', '=', '\', '[', ']', ';'  ;ROW 1
    dc.b    $27, '`', ',', '.', '/', $FF, 'a', 'b'  ;ROW 2
    dc.b    'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'  ;ROW 3
    dc.b    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r'  ;ROW 4
    dc.b    's', 't', 'u', 'v', 'w', 'x', 'y', 'z'  ;ROW 5
    dc.b    $80, $81, $82, $83, $84, $91, $92, $93  ;ROW 6
    dc.b    $94, $95, $1B, $A1, $A2, $08, $A4, $0A  ;ROW 7
    dc.b    ' ', $A6, $A7, $7F, $B0, $B1, $B2, $B3  ;ROW 8
    align 4
kyb_matrix_shifted:
    ;Bit     0    1    2    3    4    5    6    7
    dc.b    ')', '!', '@', '#', '$', '%', '^', '&'  ;ROW 0
    dc.b    '*', '(', '_', '+', '|', '{', '}', ':'  ;ROW 1
    dc.b    '"', '~', '<', '>', '?', $FE, 'A', 'B'  ;ROW 2
    dc.b    'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'  ;ROW 3
    dc.b    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R'  ;ROW 4
    dc.b    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'  ;ROW 5
    dc.b    $80, $81, $82, $83, $84, $96, $97, $98  ;ROW 6
    dc.b    $99, $9A, $1B, $A1, $A2, $08, $A4, $0A  ;ROW 7
    dc.b    ' ', $A8, $A7, $7F, $B0, $B1, $B2, $B3  ;ROW 8





;Init timer in 68230 and set IRQ4 subrutine
init_tmr:
;set rutine
    
    move.w  #$2700,sr   ; disable all IRQ interrupts (IPL=7)
    lea     _autovec_1,a0

    lea     _IRQ1_subrutine,a1
    move.l  a1,(a0)+
    lea     _IRQ2_subrutine,a1
    move.l  a1,(a0)+
    lea     _IRQ3_subrutine,a1
    move.l  a1,(a0)+
    lea     _IRQ4_subrutine,a1
    move.l  a1,(a0)+
    lea     _IRQ5_subrutine,a1
    move.l  a1,(a0)+
    lea     _IRQ6_subrutine,a1
    move.l  a1,(a0)+
    lea     _IRQ7_subrutine,a1
    move.l  a1,(a0)+


    lea     _exec_illegal,a1
    move.l  a1,(_exc_illegal)
    lea     _exec_addr_err,a1
    move.l  a1,(_exc_add_err)


;setup timer

    lea     PPI_BASE,a0

    move.l  #10000,d0  ;for 10ms
    move.b  d0,(PPI_TMR_CNT_P_L,a0)
    lsr.l   #8,d0
    move.b  d0,(PPI_TMR_CNT_P_M,a0)
    lsr.l   #8,d0
    move.b  d0,(PPI_TMR_CNT_P_H,a0)

    
    move.b  #%11100001,(PPI_TMR_CTRL,a0)  ;timer enabled continues with interupt

    move.w  #$2200,sr   ; enable some IRQ interrupts (IPL=7)
    ;we are alive
	rts

update_kyb_leds:
    movem.l     d0,-(a7)
    move.b  #0,d0
    btst    #KYB_FLG_BIT_CAPS,(kyb_flags)
    beq     .s1
    bset    #KYB_LED_CAPS_BIT,d0
.s1
    btst    #KYB_FLG_BIT_CODE,(kyb_flags)
    beq     .s2
    bset    #KYB_LED_CODE_BIT,d0
.s2
    and.b   #$0F,(PPI_PB_DATA+PPI_BASE)   ;mask out row number
    or.b    d0,(PPI_PB_DATA+PPI_BASE)
    movem.l     (a7)+,d0
    rts

update_SHIFT:
    movem.l     d0,-(a7)
    bclr    #KYB_FLG_BIT_SHIFT,(kyb_flags)
    move    #6,d0
    bsr     kyb_get_row_data
    btst    #0,d0
    beq     .end
    bset    #KYB_FLG_BIT_SHIFT,(kyb_flags)
.end
    movem.l     (a7)+,d0
    rts
;toggles CODE
update_CODE:
    movem.l     d0,-(a7)
    move    #6,d0
    bsr     kyb_get_row_data
    btst    #4,d0
    beq     .no_CODE
    
    btst    #KYB_FLG_BIT_CODE_L,(kyb_flags)   ;test last caps
    bne     .end
    bchg    #KYB_FLG_BIT_CODE,(kyb_flags)   ;caps    
.end
    bset    #KYB_FLG_BIT_CODE_L,(kyb_flags) ;set last caps
    movem.l     (a7)+,d0
    rts
.no_CODE:
    bclr    #KYB_FLG_BIT_CODE_L,(kyb_flags)   ;caps last
    movem.l     (a7)+,d0
    rts

;toggles CAPS
update_CAPS:
    movem.l     d0,-(a7)
    move    #6,d0
    bsr     kyb_get_row_data
    btst    #3,d0
    beq     .no_CAPS
    
    btst    #KYB_FLG_BIT_CAPS_L,(kyb_flags)   ;test last caps
    bne     .end
    bchg    #KYB_FLG_BIT_CAPS,(kyb_flags)   ;caps    
.end
    bset    #KYB_FLG_BIT_CAPS_L,(kyb_flags) ;set last caps
    movem.l     (a7)+,d0
    rts
.no_CAPS:
    bclr    #KYB_FLG_BIT_CAPS_L,(kyb_flags)   ;caps last
    movem.l     (a7)+,d0
    rts

_exec_illegal:

    move    #20,d0
    move    #0,d1
    bsr     x_set_cursor_xy
    lea     msg_illegal_w,a0 
    bsr     x_print_word_string
    lea     msg_illegal,a0
    bsr     send_string
    move.l  (4,a7),d0
    bsr     x_print_hex
    jmp     *

_exec_addr_err:
    move    #20,d0
    move    #0,d1
    bsr     x_set_cursor_xy
    lea     msg_add_err_w,a0 
    bsr     x_print_word_string
    lea     msg_add_err,a0
    bsr     send_string
    move.l  (4,a7),d0
    bsr     x_print_hex
    jmp     *

_IRQ1_subrutine:
    move    #'1',d0
    jsr     send_byte
    rte
_IRQ2_subrutine:
    move    #'2',d0
    jsr     send_byte
    rte
_IRQ3_subrutine:
    move    #'3',d0
    jsr     send_byte
    rte
_IRQ4_subrutine:
    addq.l  #1,(tmr_cnt)
    move.b  #$01,(PPI_TMR_STAT+PPI_BASE)
    bsr     cursor_update
    bsr     update_CAPS
    bsr     update_SHIFT
    bsr     update_CODE
    bsr     update_kyb_leds
    rte
_IRQ5_subrutine:
    move    #'5',d0
    jsr     send_byte
    rte
_IRQ6_subrutine:
    move    #'6',d0
    jsr     send_byte
    rte
_IRQ7_subrutine:
    move    #'7',d0
    jsr     send_byte
    rte

_IRQ_other:
    move    #'O',d0
    jsr     send_byte
    rte

    ;0084800C