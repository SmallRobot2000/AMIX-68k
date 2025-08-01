/* Linker script for m68k with Newlib, no IDP library by default */
/* Replace or add your own BSP library in GROUP() below if needed */

STARTUP(crt0.o)
OUTPUT_ARCH(m68k)

/* Uncomment this if you want S-record output */
/* OUTPUT_FORMAT(srec) */

SEARCH_DIR(.)

/* Group of libraries linked in order:  
   - Your BSP (Board Support Package) library here (optional)
   - C standard library (Newlib libc)
   - GCC support library (libgcc)
*/
GROUP(-lyourbsp -lc -lgcc)

/* Explicitly disable dynamic linking (common in bare-metal) */
__DYNAMIC = 0;

/* Memory layout definitions:
   Adjust ORIGIN and LENGTH to match your hardware RAM/ROM */
MEMORY
{
    ram (rwx) : ORIGIN = 0x00010000, LENGTH = 2M
    rom (rx)  : ORIGIN = 0x00000000, LENGTH = 1M
}

/* Provide default stack pointer location */
PROVIDE(__stack = ORIGIN(ram) + LENGTH(ram) - 8);

/* Provide optional BSP hooks; set to 0 if unused */
PROVIDE(hardware_init_hook = 0);
PROVIDE(software_init_hook = 0);

SECTIONS
{
    /* Text section in RAM (or you can place in ROM based on your board) */
    .text :
    {
        /* Setup for constructors and destructors */
        KEEP (*crtbegin.o(.ctors))
        KEEP (*(SORT(.ctors.*)))
        KEEP (*(.ctors))
        KEEP (*crtbegin.o(.dtors))
        KEEP (*(SORT(.dtors.*)))
        KEEP (*(.dtors))

        *(.text .text.*)

        . = ALIGN(4);
        _etext = .;

        /* Read-only data */
        *(.rodata .rodata.*)

        . = ALIGN(4);

        /* Exception handling frames */
        *(.gcc_except_table)

        . = ALIGN(4);

        *(.eh_frame)
    } > ram

    /* Data section in RAM */
    .data :
    {
        *(.got.plt) /* Global Offset Table for PIC if used */
        *(.got)
        *(.data .data.*)
        _edata = .;
    } > ram

    /* Zero-initialized BSS section in RAM */
    .bss :
    {
        . = ALIGN(4);
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        _end = ALIGN(8);
    } > ram

    /* Optional debug symbols discarded */
    .stab 0 (NOLOAD) :
    {
        *(.stab)
    }

    .stabstr 0 (NOLOAD) :
    {
        *(.stabstr)
    }
}
