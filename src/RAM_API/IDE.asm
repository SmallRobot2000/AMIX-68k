IDE_BASE        equ     $FF2000

IDE_DATA        equ     IDE_BASE+$00*2
IDE_ERR         equ     IDE_BASE+$01*2
IDE_FTR         equ     IDE_BASE+$01*2
IDE_SCT_CNT     equ     IDE_BASE+$02*2
IDE_SCT_NUM     equ     IDE_BASE+$03*2
IDE_CYL_LOW     equ     IDE_BASE+$04*2
IDE_CYL_HIGH    equ     IDE_BASE+$05*2
IDE_DRV         equ     IDE_BASE+$06*2
IDE_STAT        equ     IDE_BASE+$07*2
IDE_CMD         equ     IDE_BASE+$07*2



;shifted 
_IDENTIFY    equ   $EC00   ; Identify device
_RDSEC       equ   $2000   ; Read sector(s) (PIO, with retry)
_RDSECNR     equ   $2100   ; Read sector(s) (no retry)
_RDSEC48     equ   $2400   ; Read sector(s) 48-bit LBA
_WRSEC       equ   $3000   ; Write sector(s) (PIO, with retry)
_WRSECN      equ   $3100   ; Write sector(s) (no retry)
_WRSEC48     equ   $3400   ; Write sector(s) 48-bit LBA
_RDDMA       equ   $C800   ; Read DMA
_RDDMANR     equ   $C900   ; Read DMA (no retry)
_WRDMA       equ   $CA00   ; Write DMA
_WRDMANR     equ   $CB00   ; Write DMA (no retry)
_RDBUF       equ   $E400   ; Read buffer
_WRBUF       equ   $E800   ; Write buffer
_SETFEAT     equ   $EF00   ; Set features
_INITP       equ   $9100   ; Initialize parameters
_SEEK        equ   $7000   ; Seek
_STANDBY     equ   $E000   ; Standby immediate
_SLEEP       equ   $E600   ; Sleep
_CHKPWR      equ   $E500   ; Check power mode
_DIAG        equ   $9000   ; Execute drive diagnostic
_IDENTPKT    equ   $A100   ; Identify packet device
_PKTCMD      equ   $A000   ; ATAPI packet command

    section .text
IDE_init:
    bsr     IDE_wait_BUSY
    rts


;d0 - LBA
;d1 - count 0-255
IDE_read_sectors_LBA:   
    movem.l d2/a0,-(a7)
    ;d2 copy 

    move.l  d1,d2
    lsl.l   #8,d2
    move.w  d2,(IDE_SCT_CNT) ;set sector count to byte in d1
    bsr     IDE_wait_BUSY

    move.l  d0,d2
    lsl.l   #8,d2   ;set 2nd byte as low byte
    move.w  d2,(IDE_SCT_NUM)
    bsr     IDE_wait_BUSY

    move    d0,d2
    and.w   #$FF00,d2   ;hi byte
    move.w  d2,(IDE_CYL_LOW)
    bsr     IDE_wait_BUSY

    move    d0,d2
    lsr.l   #8,d2
    and.w   #$FF00,d2   ;2nd hi byte
    move.w  d2,(IDE_CYL_HIGH)
    bsr     IDE_wait_BUSY

    move    d0,d2
    swap    d2
    and.w   #$0F00,d2
    or.w    #$E000,d2
    move.w  d2,(IDE_DRV)

    bsr     IDE_wait_BUSY
    bsr     IDE_wait_CMD_RDY
    move.w  #_RDSEC,(IDE_CMD)    ;CMD $20 read sector(s)
    bsr     IDE_wait_BUSY
    bsr     IDE_wait_CMD_RDY
    bsr     IDE_wait_DAT_RDY

    move.w  (IDE_STAT),d2
    lsr.l   #8,d2
    btst    #0,d2
    bne     .err

;read sector(s)
    move.l  d1,-(a7)

    move    d1,d2
    subq.w  #1,d2
    andi.w  #$00FF,d2
.loop_read_sec: 
    move.w  #255,d1
.loop_read:
    btst    #15,(IDE_STAT)      ;bit 7
    bne     .loop_read
    btst    #11,(IDE_STAT)      ;bit 3
    beq     .loop_read

    move.w  (IDE_DATA),(a0)+
    dbra    d1,.loop_read
    dbra    d2,.loop_read_sec

    move.l  (a7)+,d1
    movem.l (a7)+,d2/a0
    rts
.err:
    move.l  d0,-(a7)

    lea     msg_drv_err,a0
    bsr     x_print_byte_string

    move    (IDE_ERR),d0
    lsr.w   #8,d0

    andi.l  #$000000FF,d0
    bsr     x_print_hex

    move.l  (a7)+,d0
    movem.l (a7)+,d2/a0
    rts



IDE_write_sectors_LBA:
    movem.l d2/a0,-(a7)
    move.l  d1,-(a7)
    ;d2 copy 
    bsr     IDE_wait_BUSY
    bsr     IDE_wait_CMD_RDY
    move.l  d1,d2
    lsl.l   #8,d2
    move.w  d2,(IDE_SCT_CNT) ;set sector count to byte in d1
    bsr     IDE_wait_BUSY

    move.l  d0,d2
    lsl.l   #8,d2   ;set 2nd byte as low byte
    move.w  d2,(IDE_SCT_NUM)
    bsr     IDE_wait_BUSY

    move    d0,d2
    and.w   #$FF00,d2   ;hi byte
    move.w  d2,(IDE_CYL_LOW)
    bsr     IDE_wait_BUSY

    move    d0,d2
    lsr.l   #8,d2
    and.w   #$FF00,d2   ;2nd hi byte
    move.w  d2,(IDE_CYL_HIGH)
    bsr     IDE_wait_BUSY

    move    d0,d2
    swap    d2
    and.w   #$0F00,d2
    or.w    #$E000,d2
    move.w  d2,(IDE_DRV)

    bsr     IDE_wait_BUSY
    bsr     IDE_wait_CMD_RDY


    move.w  #_WRSEC,(IDE_CMD)    ;CMD $30 write sector(s)


;write sector(s)
    

    move    d1,d2
    subq.w  #1,d2
    andi.w  #$00FF,d2
.loop_write_sec: 
    move.w  #255,d1
    bsr     IDE_wait_DAT_RDY
.loop_write:
    btst    #15,(IDE_STAT)      ;bit 7
    bne     .loop_write
    btst    #11,(IDE_STAT)      ;bit 3
    beq     .loop_write

    move.w  (a0)+,(IDE_DATA)
    
    dbra    d1,.loop_write
    dbra    d2,.loop_write_sec
    
    ;bsr     IDE_wait_DAT_RDY_fast

    move.l  (a7)+,d1
    movem.l (a7)+,d2/a0
    rts
.err:
    move.l  d0,-(a7)

    lea     msg_drv_err,a0
    bsr     x_print_byte_string

    move    (IDE_ERR),d0
    lsr.w   #8,d0

    andi.l  #$000000FF,d0
    bsr     x_print_hex


    jmp     *

    move.l  (a7)+,d0
    move.l  (a7)+,d1
    movem.l (a7)+,d2/a0
    rts


IDE_wait_BUSY:
    btst    #15,(IDE_STAT)  ;bit 7
    bne     IDE_wait_BUSY
    rts

IDE_wait_CMD_RDY:
    btst    #15,(IDE_STAT)  ;bit 7
    bne     IDE_wait_CMD_RDY
    btst    #14,(IDE_STAT)  ;bit 6
    beq     IDE_wait_CMD_RDY
    rts
IDE_wait_DAT_RDY:
    btst    #15,(IDE_STAT)      ;bit 7
    bne     IDE_wait_DAT_RDY
    btst    #11,(IDE_STAT)      ;bit 3
    beq     IDE_wait_DAT_RDY
    rts
IDE_wait_DAT_RDY_fast:
    move.w  (IDE_STAT),d0
    btst    #15,d0
    bne     IDE_wait_DAT_RDY_fast
    btst    #11,d0      ;bit 3
    beq     .aaa
    rts
.aaa:
    move.b  d1,d0
    bsr     x_print_hex
    jmp     IDE_wait_DAT_RDY_fast

IDE_read_CMD:
    

    


    move.w  (IDE_STAT),d0
    lsr.l   #8,d0
    btst    #0,d0
    bne     IDE_read_CMD

    move    #$AAAA,d0
    bsr     x_print_hex

    lea     buffer,a0
    move    #$60-1,d2
.loop_read1:
    move    #255,d1
.loop_read:
    bsr     IDE_wait_DAT_RDY
    move.w  (IDE_DATA),(a0)+
    dbra    d1,.loop_read
    dbra    d2,.loop_read1
    rts