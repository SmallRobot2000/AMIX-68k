SECTIONS
{
  . = 120000;
  .text : {
    KEEP(*(.text))
  }
  .rodata : {
    KEEP(*(.rodata))
  }

  /DISCARD/ : { *(.bss.*) }
}
