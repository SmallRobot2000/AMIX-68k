    section .bss
    ORG		RAM_START
	
Vector_table_start:
	ds.l   1	;Initial SSP
    ds.l   1 	;Initial PC
_exc_bus_err:
	ds.l	1
_exc_add_err:
	ds.l	1

_exc_illegal:
	ds.l	1
_exc_dev_zero:
	ds.l	1
_exc_err_chk:
	ds.l	1
_exc_overflow:
	ds.l	1
_exc_usr_privilage:
	ds.l	1

_exc_trace:
	ds.l	1
_exc_line1010:
	ds.l	1
_exc_line1111:
	ds.l	1

_exc_soft_none0:
	ds.l	1
_exc_soft_none1:
	ds.l	1
_exc_soft_none2 ;reserved:
	ds.l	1

_exc_soft_none3 ;unitilized int vector:
	ds.l	1

_exc_soft_none4:
	ds.l	1
_exc_soft_none5:
	ds.l	1
_exc_soft_none6:
	ds.l	1
_exc_soft_none7:
	ds.l	1
_exc_soft_none8:
	ds.l	1
_exc_soft_none9:
	ds.l	1
_exc_soft_none10:
	ds.l	1
_exc_soft_none11:
	ds.l	1
_exc_soft_none12:
	ds.l	1

	

	;auto vectors
_autovec_1:
	ds.l	1		;IRQ 1
_autovec_2:
	ds.l	1		;IRQ 2
_autovec_3:
	ds.l	1		;IRQ 3
_autovec_4:
	ds.l	1		;IRQ 4
_autovec_5:
	ds.l	1		;IRQ 5 - xosera
_autovec_6:
	ds.l	1		;IRQ 6
_autovec_7:
	ds.l	1		;IRQ 7
		
	;TRAP 0-15
_exc_trap_0:
	ds.l	1
_exc_trap_1:
	ds.l	1
_exc_trap_2:
	ds.l	1
_exc_trap_3:
	ds.l	1
_exc_trap_4:
	ds.l	1
_exc_trap_5:
	ds.l	1
_exc_trap_6:
	ds.l	1
_exc_trap_7:
	ds.l	1
_exc_trap_8:
	ds.l	1
_exc_trap_9:
	ds.l	1
_exc_trap_10:
	ds.l	1
_exc_trap_11:
	ds.l	1
_exc_trap_12:
	ds.l	1
_exc_trap_13:
	ds.l	1
_exc_trap_14:
	ds.l	1
_exc_trap_15:
	ds.l	1

Vector_table_end:
;xosera
tmp_str:
	ds.b 128
cursor_add:
	ds.w 1
cursor_state: ;bit 0 - what needs to be, bit 1 - what it is
	ds.w 1
last_cursor_add:
	ds.w 1
last_cursor_state:
	ds.w 1
tmr_cnt:
	ds.l 1	;TODO add interupt that increments this every frame(for now it in loop)
x_screen:
	ds.w 32*80
FRAME:
	ds.l 1
;kyboard
kyb_wait:
	ds.l 1
kyb_last:
	ds.w 1
kyb_flags:
	ds.w 1
buffer:
	ds.w $2000
    