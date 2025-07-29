SECTIONS
{
  . = 0x000000;

  .vectors : {
    KEEP(*(.vectors))
  }
  . = 0x000100;

  .text : {
    KEEP(*(.text))
  }
  .rodata : {
    KEEP(*(.text))
  }

  _bss_start = 0x100000;
  . = 0x100000;
  /DISCARD/ : { *(.bss.*) }
}
