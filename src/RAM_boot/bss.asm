    section .bss
        section .bss
    ORG		$100000
;xosera
cursor_pos:
	ds.w 1
cursor_add:
	ds.w 1
cursor_state: ;bit 0 - what needs to be, bit 1 - what it is
	ds.w 1
last_cursor_pos:
	ds.w 1
last_cursor_add:
	ds.w 1
last_cursor_state:
	ds.w 1
FRAME:
	ds.l 1	;TODO add interupt that increments this every frame(for now it in loop)
x_screen:
	ds.w 32*80

;kyboard
kyb_wait:
	ds.l 1
kyb_last:
	ds.w 1
kyb_flags:
	ds.w 1

    