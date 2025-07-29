
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
SCREEN_HIGHT    equ     25
DEFAULT_FR      equ     $02 ;green
DEFAULT_BG      equ     $00 ;black
XM_TIME_CUR_BIT equ     12  ;speed of cursor
init_xosera:        
    
    lea     XM_BASE,a0
    move    #XR_PA_GFX_CTRL,d1
    movep   d1,(XM_WR_XADD,a0)

    move    #$0000,d0       ;colorbase 0 idk, no blank, bitmap in tile mem, 1bpp,1x wide,1x tall
    movep   d0,(XM_XDATA,a0)
    move    #$400F,d0       ;tileset in tile memory at $4000, display in vram, hight 16
    movep   d0,(XM_XDATA,a0)
    move    #X_SCREEN_START,d0       ;VRAM start
    movep   d0,(XM_XDATA,a0)
    move    #80,d0          ;display line lengt in word - 80 because 80 characters per line
    movep   d0,(XM_XDATA,a0)
    move    #$0000,d0       ;fractional scale off
    movep   d0,(XM_XDATA,a0)
    move    #00,d0
    jsr     x_set_border_color
    
    move    #$0000,d0
    move    #DEFAULT_FR,d1
    move    #DEFAULT_BG,d2
    jsr     set_char_colors
    lea     x_screen,a0 
    move    #SCREEN_WIDTH*SCREEN_HIGHT-1,d1
.loop:
    move.w  d0,(a0)+
    dbra    d1,.loop

.end:
	rts

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

;d0 - low word - color/char
;puts char in RAM map of VRAM display
x_print_char:
    ;movem.l d1/a0-a1,-(a7)
    lea     x_screen,a0
    lea     cursor_add,a1
    move.w  (a1),d1
    lsl.w   #1,d1       ;*2 for even address
    move.w  d0,(a0,d1)
    add.w   #1,(a1)

    ;movem.l (a7)+,d1/a0-a1
    rts

x_update_screen:
    jsr     cursor_update
    jsr     x_send_screen
    
    rts

;updates the screen copy in ram
cursor_update:
    lea     XM_BASE,a0
    lea     cursor_state,a1
    and.w   #$02,(a1)       ;remove needed bit
    movep   (XM_TIMER,a0),d0   ;get timer
    btst    #XM_TIME_CUR_BIT,d0
    beq     .skip_flip      ;chek needded state
    or.w    #1,(a1)         ;flip cursor need state
.skip_flip:
;chek if last cursor was inverted if so on old cursro add flip colors
    
    lea     last_cursor_state,a0
    btst    #$1,(a0) ;bit 1 what it was
    beq     .skip_last_flip ;its not fliped so no need to change

;here we flip last character
    ;jsr     flip_last_cursor
.skip_last_flip:
    
    ;update curent cursor state and colors
    lea     cursor_state,a0
    move.w  (a0),d0
    move    d0,d1   ;d1 and d0 are the same state
    lsr     #1,d1   ;what it is
    and     #1,d0   ;only wanted
    and     #1,d1   ;only what is
    cmp.w   d0,d1   ;same?
    beq     .skip_cur_flip
    ;not same

    eor.w   #$02,(a0)  ;flip cur state


    jsr     flip_cursor
.skip_cur_flip:
    ;update last cursor if not same
    lea     cursor_add,a0
    lea     last_cursor_add,a1
    move.w  (a0),d0
    move.w  (a1),d1
    cmp.w   d0,d1
    beq     .end
    move.w  (a0),(a1)
    lea     cursor_pos,a0
    lea     last_cursor_pos,a1
    move.w  (a0),(a1)
    lea     cursor_state,a0
    lea     last_cursor_state,a1
    move.w  (a0),(a1)
.end:
    rts
 

flip_cursor:
    movem.l d0/d1/a0/a1,-(a7)
    lea     x_screen,a0
    lea     cursor_add,a1
    move.l  #0,d1
    move.w  (a1),d1
    lsl.w   #1,d1   ;*2 for even address
    move.w  (a0,d1.w),d0
    jsr     flip_char_colors
    move.w  d0,(a0,d1)
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
    jsr     flip_char_colors
    move.w  d0,(a0,d1)
    movem.l (a7)+,d0/d1/a0/a1
    rts
;char in d0(word)
flip_char_colors:
    movem.l d1/d2,-(a7)
    jsr     get_char_colors
    exg     d1,d2
    jsr     set_char_colors
    movem.l (a7)+,d1/d2
    rts
x_send_screen:
    lea     XM_BASE,a0
    lea     x_screen,a1
    move    #X_SCREEN_START,d0
    movep   d0,(XM_WR_ADDR,a0)
    move    #1,d0
    movep   d0,(XM_WR_INCR,a0)

    move    #SCREEN_HIGHT*SCREEN_WIDTH-1,d1
.loop:
    move.w  (a1)+,d0
    movep   d0,(XM_DATA,a0)
    dbra    d1,.loop
    rts

;d0 - how much
screen_scrool:
    tst     d0
    beq     .end    ;if zero end
    subq    #1,d0
.loop0:
    lea     x_screen,a0
    lea     x_screen+SCREEN_WIDTH,a1
    move    #SCREEN_WIDTH*SCREEN_HIGHT-SCREEN_WIDTH,d1 ;24 lines skips first
.loop1:
    move.w  (a1)+,(a0)+
    dbra    d1,.loop1
    dbra    d0,.loop0
.end
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
