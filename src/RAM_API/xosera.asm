    section .text
XM_BASE			equ 	$FF1000
                        ;*2 because 8 bit interface must be even address
XM_SYS_CTRL		equ		$00*4		;R /W+	Status flags, write to [15:8] inits PIXEL_X/Y, [3:0] VRAM write nibble mask
XM_INT_CTR		equ		$08*4		;R /W+	FPGA reconfigure, interrupt masking, interrupt status
XM_TIMER		equ		$01*4		;R /W+	Read 16-bit tenth millisecond timer (1/10,000 second), write 8-bit interval timer
XM_RD_XADD		equ		$09*4		;R /W+	XR register/address used for XM_XDATA read access
XM_WR_XADD		equ		$02*4		;R /W	XR register/address used for XM_XDATA write access
XM_XDATA		equ		$0A*4		;R+/W+	Read from XM_RD_XADDR or write to XM_WR_XADDR (and increment address by 1)
XM_RD_INCR		equ		$03*4		;R /W	increment value for XM_RD_ADDR read from XM_DATA/XM_DATA_2
XM_RD_ADDR		equ		$0B*4		;R /W+	VRAM address for reading from VRAM when XM_DATA/XM_DATA_2 is read
XM_WR_INCR		equ		$04*4		;R /W	increment value for XM_WR_ADDR on write to XM_DATA/XM_DATA_2
XM_WR_ADDR		equ		$0C*4		;R /W	VRAM address for writing to VRAM when XM_DATA/XM_DATA_2 is written
XM_DATA			equ		$05*4		;R+/W+	read/write VRAM word at XM_RD_ADDR/XM_WR_ADDR (and add XM_RD_INCR/XM_WR_INCR)
XM_DATA_2		equ		$0D*4		;R+/W+	2nd XM_DATA(to allow for 32-bit read/write access)
XM_PIXEL_X		equ		$06*4		;- /W+	X pixel sets WR_ADDR and nibble mask (also PIXEL_BASE for XM_SYS_CTRL write)
XM_PIXEL_Y		equ		$0E*4		;- /W+	Y pixel sets WR_ADDR and nibble mask (also PIXEL_WIDTH for XM_SYS_CTRL write)
XM_UART			equ		$07*4		;R+/W+	USB UART using FTDI chip in UPduino for additional 1 Mbps USB connection to PC [1]
XM_FEATUR		equ		$0F*4		;R /-	Feature bits
	

XR_VID_CTRL	    equ     $00     ;R /W	Border color index and playfield color swap
XR_COPP_CTRL    equ     $01     ;R /W	Display synchronized coprocessor ("copper") control
XR_AUD_CTRL	    equ     $02     ;R /W	Audio channel DMA control
XR_SCANLINE	    equ     $03     ;R /W+	Current display scanline / write triggers video interrupt
XR_VID_LEFT	    equ     $04     ;R /W	Left edge start of active display window (normally 0)
XR_VID_RIGHT    equ     $05     ;R /W	Right edge + 1 end of active display window (normally 640 or 848)
XR_POINTER_H    equ     $06     ;- /W	pointer sprite H position (in native screen coordinates)
XR_POINTER_V    equ     $07     ;- /W	pointer sprite V position (in native screen coordinates) and color select
                                ;0x08-0x0F	XR_UNUSED_0x	- /-	Unused registers
XR_PA_GFX_CTRL	equ     $10	    ;R/W	playfield A graphics control
XR_PA_TILE_CTRL	equ     $11	    ;R/W	playfield A tile control
XR_PA_DISP_ADDR	equ     $12	    ;R/W	playfield A display VRAM start address (start of frame)
XR_PA_LINE_LEN	equ     $13	    ;R/W	playfield A display line width in words
XR_PA_HV_FSCALE	equ     $14	    ;R/W	playfield A horizontal and vertical fractional scaling
XR_PA_H_SCROLL	equ     $15	    ;R/W	playfield A horizontal fine scroll
XR_PA_V_SCROLL	equ     $16	    ;R/W	playfield A vertical repeat and tile fine scroll
XR_PA_LINE_ADDR	equ     $17	    ;-/W	playfield A scanline start address (start of next line)
XR_PB_GFX_CTRL	equ     $18	    ;R/W	playfield B graphics control
XR_PB_TILE_CTRL	equ     $19	    ;R/W	playfield B tile control
XR_PB_DISP_ADDR	equ     $1A	    ;R/W	playfield B display VRAM start address (start of frame)
XR_PB_LINE_LEN	equ     $1B	    ;R/W	playfield B display line width in words
XR_PB_HV_FSCALE	equ     $1C	    ;R/W	playfield B horizontal and vertical fractional scaling
XR_PB_H_SCROLL	equ     $1D	    ;R/W	playfield B horizontal fine scroll
XR_PB_V_SCROLL	equ     $1E	    ;R/W	playfield B horizontal repeat and tile fine scroll
XR_PB_LINE_ADDR	equ     $1F	    ;-/W	playfield B scanline start address (start of next line)
;TILE address	Description
;0x4000-0x47FF	8x16 ST font (derived from Atari ST 8x16 font)
;0x4800-0x4BFF	8x8 ST font (derived from Atari ST 8x8 font)
;0x4C00-0x4FFF	8x8 PC font (derived from IBM CGA 8x8)
;0x5000-0x53FF	8x8 hexadecimal debug font (showing TILE number in hex)
X_SCREEN_START  equ     $1000
SCREEN_WIDTH    equ     80
SCREEN_HIGHT    equ     30
DEFAULT_FR      equ     $02 ;green
DEFAULT_BG      equ     $00 ;black
XM_TIME_CUR_BIT equ     12  ;speed of cursor

;d0 - color in low byte
x_set_border_color:
    movem.l d0/d1/a0,-(a7)
    lea     XM_BASE,a0
    move    #XR_VID_CTRL,d1
    movep   d1,(XM_WR_XADD,a0)
    and     #$000F,d0           ;mask color only
    movep   d0,(XM_XDATA,a0)    ;write color
    movem.l (a7)+,d0/d1/a0
    rts

;d0 - color/char
;puts char in RAM map of VRAM display
x_print_char_word:
    STI
    movem.l d0-d7/a0-a6,-(a7)
    bsr     clear_cursor
    move.w  (cursor_add),d1
    move.w  d1,(last_cursor_add)
    bsr     test_special    ;zero if normal
    beq     .end        ;end if special
    lea     x_screen,a0
    lea     cursor_add,a1
    lsl.w   #1,d1       ;*2 for even address
    move.w  d0,(a0,d1.w)  ;make copy in RAM
    lea     XM_BASE,a0
    move.w  (a1),d1
    add.w   #X_SCREEN_START,d1
    movep   d1,(XM_WR_ADDR,a0)
    move.w  #1,d1
    movep   d1,(XM_WR_INCR,a0)
    movep   d0,(XM_DATA,a0)
    add.w   #1,(a1)
.end:
    STI
    bsr     clear_cursor
    bsr     update_scroll
    movem.l (a7)+,d0-d7/a0-a6
    CLI
    rts

;d0 - byte char
x_print_char_byte:
    STI
    andi.w  #$00FF,d0
    or.w    #(DEFAULT_BG<<4|DEFAULT_FR)<<8,d0
    jmp     x_print_char_word


;zero if normal
test_special   
    movem.l d1/d2,-(a7)
    cmp.b   #13,d0
    bne     .s1
    ;CR
    bsr     x_print_CR
    jmp     .end0
.s1
    cmp.b   #10,d0
    bne     .s2
    ;NL
    bsr     x_print_NL
    jmp     .end0
.s2 
    cmp.b   #8,d0
    bne     .s3
    ;Back space
    bsr     x_print_BS_DEL
    jmp     .end0
.s3
    cmp.b   #KYB_ARROW_RIGHT,d0
    bne     .s4
    addq.w  #1,(cursor_add)
    jmp     .end0
.s4
    cmp.b   #KYB_ARROW_LEFT,d0
    bne     .s5
    tst.w     (cursor_add)
    beq     .end0
    subq.w  #1,(cursor_add)
    
    jmp     .end0
.s5
.end
    tst     d0
    movem.l (a7)+,d1/d2
    rts
.end0
    
    move    #0,d0
    tst     d0
    movem.l (a7)+,d1/d2
    rts

clear_cursor:
    STI
    btst    #0,(cursor_state)  ;if it is flipped
    beq     .end
    bsr     flip_cursor
    move.w  #0,(cursor_state)
.end:
    
    rts
x_update_screen:
    
    bsr     x_send_screen

    rts

;updates the screen copy in ram
cursor_update:
    movem.l d0/d1/d2/a0/a1/a2,-(a7)
    STI
    lea     XM_BASE,a0
    lea     cursor_state,a1

    ;bset    #0,(cursor_state)
    ;bset    #1,(cursor_state)
    move.b  (cursor_state),d0
    tst.b   d0
    beq     .skip_flip  ;both are 0
    bchg    #0,d0
    bchg    #1,d0
    tst.b   d0
    beq     .skip_flip  ;both are 1

    bsr     flip_cursor

    bchg    #0,(cursor_state)
.skip_flip:
;update needed bit
    bclr    #1,(cursor_state)
    movep   (XM_TIMER,a0),d0    ;get timer
    btst    #XM_TIME_CUR_BIT,d0
    beq     .skip_need          ;chek needded state
    bset    #1,(cursor_state)   ;flip cursor need state
.skip_need:
    CLI
    movem.l (a7)+,d0/d1/d2/a0/a1/a2
    rts
 

flip_cursor:
    movem.l d0/d1/a0/a1,-(a7)
    lea     x_screen,a0
    lea     cursor_add,a1
    move.l  #0,d1
    move.w  (a1),d1
    lsl.w   #1,d1   ;*2 for even address
    move.w  (a0,d1.w),d0
    bsr     flip_char_colors
    move.w  d0,(a0,d1)
    ;d0 - char
    ;print to xosera
    lea     XM_BASE,a0
    move.w  #1,d1
    movep   d1,(XM_WR_INCR,a0)
    move.w  (a1),d1
    add.w   #X_SCREEN_START,d1
    movep   d1,(XM_WR_ADDR,a0)
    movep   d0,(XM_DATA,a0)

    movem.l (a7)+,d0/d1/a0/a1
    rts

flip_last_cursor:
    movem.l d0/d1/a0/a1,-(a7)
    lea     x_screen,a0
    lea     last_cursor_add,a1
    move.l  #0,d1
    move.w  (a1),d1
    lsl.w   #1,d1   ;*2 for even address
    move.w  (a0,d1.w),d0
    bsr     flip_char_colors
    move.w  d0,(a0,d1)
    ;d0 - char
    ;print to xosera
    lea     XM_BASE,a0
    move.w  #1,d1
    movep   d1,(XM_WR_INCR,a0)
    move.w  (a1),d1
    add.w   #X_SCREEN_START,d1
    movep   d1,(XM_WR_ADDR,a0)
    movep   d0,(XM_DATA,a0)
    movem.l (a7)+,d0/d1/a0/a1
    rts


;d0 - X
;d1 - Y
x_set_cursor_xy:
	movem.l	d0/d1/a0,-(a7)
    STI
    bsr     clear_cursor
	mulu.w	#80,d1
	add.w	d1,d0

	lea     cursor_add,a0
	move.w	d0,(a0)
    
	movem.l	(a7)+,d0/d1/a0
	rts
;d0 - X
;d1 - Y
x_get_cursor_xy:
	movem.l	a0,-(a7)
	lea     cursor_add,a0

	move.l	#0,d0
	move.w	(a0),d0

	divu	#80,d0	;D0 hi = x, D0 lo = y
	move.w	d0,d1	;y
	swap	d0		;x
	and.l	#$0000FFFF,d0 ; mask only x

	movem.l	(a7)+,a0
	rts

;New line and CR because UNIX like
x_print_NL:
    STI
    bsr     x_print_CR
    movem.l	d0/d1,-(a7)
	bsr		x_get_cursor_xy
	add.w	#1,d1
	bsr		x_set_cursor_xy
	movem.l (a7)+,d0/d1
    rts
;Carrige return
x_print_CR:
    STI
    movem.l	d0/d1,-(a7)
	bsr		x_get_cursor_xy
	move.w	#0,d0
	bsr		x_set_cursor_xy
	movem.l (a7)+,d0/d1
    rts
;Back space
x_print_BS_DEL:
    movem.l	d0/d1,-(a7)
    tst.w   (cursor_add)
    beq     .s1
    
    
    bsr     clear_cursor
    STI     ;temp disable irqs
    subq.w  #1,(cursor_add)
    move.b  #' ',d0
    jsr     x_print_char_byte   ;clear acual character
    subq.w  #1,(cursor_add)
	movem.l (a7)+,d0/d1
    rts
.s1:
    move    #' ',d0
    bsr     x_print_char_byte
    subq.w  #1,(cursor_add)
    movem.l (a7)+,d0/d1
    rts

;char in d0(word)
flip_char_colors:
    movem.l d1/d2,-(a7)
    bsr     get_char_colors
    exg     d1,d2
    bsr     set_char_colors
    movem.l (a7)+,d1/d2
    rts
x_send_screen:
    movem.l d0/d1/a0/a1,-(a7)
    lea     XM_BASE,a0
    lea     x_screen,a1
    move    #X_SCREEN_START,d0
    movep   d0,(XM_WR_ADDR,a0)
    move    #1,d0
    movep   d0,(XM_WR_INCR,a0)

    move    #(SCREEN_HIGHT*SCREEN_WIDTH)-1,d1
.loop:
    move.w  (a1)+,d0
    movep   d0,(XM_DATA,a0)
    dbra    d1,.loop
    movem.l (a7)+,d0/d1/a0/a1
    rts

;d0 - how much
screen_scroll:
    STI
    bsr     clear_cursor
    movem.l d0-d1/a0-a1,-(a7)
    tst     d0
    beq     .end    ;if zero end
    bsr     scroll_clear_invis_line
    subq    #1,d0
.loop0:
    lea     x_screen,a0
    lea     x_screen+(SCREEN_WIDTH*2),a1
    move    #SCREEN_WIDTH*SCREEN_HIGHT,d1
.loop1:
    move.w  (a1)+,(a0)+
    dbra    d1,.loop1
    dbra    d0,.loop0
    lea     x_screen,a0
    
    
    
.end
    bsr     x_send_screen
    movem.l (a7)+,d0-d1/a0-a1
    
    rts
scroll_clear_invis_line:    
    movem.l d0,-(a7)
    lea     x_screen+(SCREEN_WIDTH*2*(SCREEN_HIGHT)),a0
    move    #$20,d0
    move    #DEFAULT_FR,d1
    move    #DEFAULT_BG,d2
    bsr     set_char_colors
    move    #(SCREEN_WIDTH)-1,d1
.loop:
    move.w  d0,(a0)+
    dbra    d1,.loop
    movem.l (a7)+,d0
    rts
;d0 - X
;d1 - Y (used)
;d0 - address offset output
get_add_from_XY:
    mulu.w  #SCREEN_WIDTH,d1
    add.w   d0,d1
    move.w  d1,d0
    and.l   #$0000FFFF,d0   ;isolate only word
    lsl     #1,d0           ;*2 for real address
    rts

;d0 - char(word)
;d1 - foreground(4bit)
;d2 - background(4bit)
set_char_colors:
    movem.l d1/d2,-(a7)
    lsl     #4,d2 
    and     #$0F,d1
    or      d2,d1 ;d1 lowest byte is color
    lsl     #8,d1
    and.w   #$FF00,d1
    and.w   #$00FF,d0   ;clear colors
    or      d1,d0 ;corect color
    movem.l (a7)+,d1/d2
    rts

;d0 - char(word)
;return:
;d1 - foreground(4bit)
;d2 - background(4bit)
get_char_colors:
    move    d0,-(a7)
    lsr     #8,d0
    move    d0,d1
    andi    #$0000000F,d1
    lsr     #4,D0
    move    d0,d2
    andi    #$0000000F,d2
    move    (a7)+,d0
    rts

x_set_add_rep:
    movem.l d0/a0/a1,-(a7)
    lea     XM_BASE,a0
    lea     cursor_add,a1
    move.w  (a1),d0
    add.w   #X_SCREEN_START,d0
    movep   d0,(XM_WR_ADDR,a0)
    move.w  #1,d0
    movep   d0,(XM_WR_INCR,a0)
    movem.l (a7)+,d0/a0/a1
    rts

;a0 - string (bytes)
s:
    movem.l d0/d1/d2/a0/a1,-(a7)
    bsr     x_set_add_rep
    lea     XM_BASE,a1

    move    #$0000,d0
    move    #DEFAULT_FR,d1
    move    #DEFAULT_BG,d2
    bsr     set_char_colors

.loop:
    move.b  (a0)+,d0
    tst.b   d0
    beq     .end
    movep   d0,(XM_DATA,a1)
    jmp     .loop
.end:
    movem.l (a7)+,d0/d1/d2/a0/a1
    rts

;a0 - string (words)
x_print_word_string:
    movem.l d0/a0/a1/a2/a3,-(a7)
    STI
    bsr     clear_cursor
    lea     XM_BASE,a1
    bsr     x_set_add_rep
    lea     cursor_add,a2
    lea     x_screen,a3
.loop:
    
    move.w  (a0)+,d0
    tst.b   d0
    beq     .end

    cmp.b   #10,d0
    bne     .s1
    ;NL
    bsr     x_print_NL
    bsr     x_set_add_rep
    jmp     .loop
.s1:
    cmp.b   #13,d0
    bne     .s2
    ;CR
    bsr     x_print_CR
    bsr     x_set_add_rep
    jmp     .loop
.s2:
    cmp.b   #08,d0
    bne     .s3
    bsr     x_print_BS_DEL
    bsr     x_set_add_rep
    bsr     update_scroll
    jmp     .loop
.s3:
    

    movep   d0,(XM_DATA,a1)
    move.l  #0,d1
    move.w  (a2),d1
    lsl.w   #1,d1
    move.w  d0,(a3,d1.w)
    addq.w  #1,(a2)
    jmp     .loop
.end:
    CLI
    movem.l (a7)+,d0/a0/a1/a2/a3
    rts


;a0 - string(byte)
x_print_byte_string:
    movem.l d0/a0/a1/a2/a3,-(a7)
    STI
    bsr     clear_cursor
    lea     XM_BASE,a1
    bsr     x_set_add_rep
    move.w  #0,d0
    lea     cursor_add,a2
    lea     x_screen,a3
.loop:
    move.b  (a0)+,d0
    or.w    #(DEFAULT_BG<<4|DEFAULT_FR)<<8,d0
    
    tst.b   d0
    beq     .end
 
    cmp.b   #10,d0
    bne     .s1
    ;NL
    bsr     x_print_NL
    bsr     x_set_add_rep
    jmp     .loop
.s1:
    cmp.b   #13,d0
    bne     .s2
    ;CR
    bsr     x_print_CR
    bsr     x_set_add_rep
    jmp     .loop
.s2:
    cmp.b   #08,d0
    bne     .s3
    bsr     x_print_BS_DEL
    bsr     x_set_add_rep
    jmp     .loop
.s3:
    movep   d0,(XM_DATA,a1)
    move.l  #0,d1
    move.w  (a2),d1
    lsl.w   #1,d1
    move.w  d0,(a3,d1.w)
    addq.w  #1,(a2)
    bsr     update_scroll
    jmp     .loop
.end:
    CLI
    movem.l (a7)+,d0/a0/a1/a2/a3
    rts


;d0 - hex
x_print_hex:	
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
	bsr     x_print_byte_string
	movem.l	(a7)+,d0/d1/d2/a0
	rts

;Scrolls if needed
update_scroll:
    movem.l d0/d1/a0,-(a7)
    move.w  (cursor_add),d0
    cmp.w   #(SCREEN_HIGHT-4)*SCREEN_WIDTH,d0
    blo     .end    ;Branch if end_add > d0
    move    #1,d0
    bsr     screen_scroll
    move.w  #(SCREEN_HIGHT-5)*(SCREEN_WIDTH),(cursor_add)
.end:
    movem.l (a7)+,d0/d1/a0
    rts

x_print_byte_buffer:
    movem.l d0/d1/d2/a0/a1/a2/a3,-(a7)
    STI
    move.l  d0,d2   ;CNT
    subq.l  #1,d2
.loop:
    move.b  (a0)+,d0
    bsr     x_print_char_byte
    dbra    d2,.loop
.end:
    CLI
    movem.l (a7)+,d0/d1/d2/a0/a1/a2/a3
    rts