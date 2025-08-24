/* amix.ld - Linker script for m68k program at 0x130000 */

ENTRY(_start)
OUTPUT_ARCH(m68k)

SEARCH_DIR(.)

GROUP(-lc -lm -lgcc)

__DYNAMIC = 0;

MEMORY
{
    ram (rwx) : ORIGIN = 0x000000, LENGTH = 2M
    rom (rx)  : ORIGIN = 0x000000, LENGTH = 1M
}

/* Stack positioned after BSS, heap grows upward from there */
PROVIDE(hardware_init_hook = 0);
PROVIDE(software_init_hook = 0);
PROVIDE(__INIT_SECTION__ = 0);
PROVIDE(__FINI_SECTION__ = 0);

SECTIONS
{
    /* Code section starts at 0x130000 */
    .text ORIGIN(ram) : ALIGN(4)
    {
        /* Keep startup code first */
        KEEP(*(.text.startup))
        *(.text .text.*)
        KEEP(*(.init*))
        KEEP(*(.fini*))
        . = ALIGN(4);
        _etext = .;
    } > ram

    /* Place GOT immediately after .text to avoid GOT16 overflow */
    .got : ALIGN(4)
    {
        _GLOBAL_OFFSET_TABLE_ = .;
        *(.got.plt)
        *(.got)
    } > ram

    /* PLT section if needed */
    .plt : ALIGN(4)
    {
        *(.plt)
    } > ram

    /* Read-only data */
    .rodata : ALIGN(4)
    {
        *(.rodata .rodata.*)
    } > ram

    /* Initialized data */
    .data : ALIGN(4)
    {
        _data_start = .;
        
        /* Constructor/Destructor tables */
        __CTOR_LIST__ = .;
        KEEP(*crtbegin*.o(.ctors))
        KEEP(*(SORT(.ctors.*)))
        KEEP(*(.ctors))
        KEEP(*crtend*.o(.ctors))
        LONG(0)
        __CTOR_END__ = .;

        __DTOR_LIST__ = .;
        KEEP(*crtbegin*.o(.dtors))
        KEEP(*(SORT(.dtors.*)))
        KEEP(*(.dtors))
        KEEP(*crtend*.o(.dtors))
        LONG(0)
        __DTOR_END__ = .;

        *(.data .data.*)
        . = ALIGN(4);
        _edata = .;
    } > ram

    /* Uninitialized data */
    .bss : ALIGN(4)
    {
        __bss_start = .;
        _bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(4);
        _end = .;
        __end = .;
    } > ram

    /* Stack area - fixed size after BSS */
    . = ALIGN(8);
    . = . + 0x2000;  /* 8KB stack space */
    __stack = .;     /* Top of stack (SP starts here) */
    
    /* Heap starts after stack, grows upward */
    _heap_start = . + 4;

    /* Debug sections (not loaded into memory) */
    .stab 0 (NOLOAD) : { *(.stab) }
    .stabstr 0 (NOLOAD) : { *(.stabstr) }
    .debug_info 0 (NOLOAD) : { *(.debug_info) }
    .debug_abbrev 0 (NOLOAD) : { *(.debug_abbrev) }
    .debug_line 0 (NOLOAD) : { *(.debug_line) }
    .debug_str 0 (NOLOAD) : { *(.debug_str) }
    .debug_ranges 0 (NOLOAD) : { *(.debug_ranges) }
}

/* Memory layout summary */
/*
 * 0x130000 - .text (code)
 * xxxxxxxx - .got (Global Offset Table)
 * xxxxxxxx - .plt (Procedure Linkage Table)
 * xxxxxxxx - .rodata (read-only data)
 * xxxxxxxx - .data (initialized data)
 * xxxxxxxx - .bss (uninitialized data)
 * xxxxxxxx - stack (16KB, grows downward from __stack)
 * xxxxxxxx - heap (grows upward to end of RAM)
 */
