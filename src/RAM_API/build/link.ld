SECTIONS
{
  .text : {
    KEEP(*(.text))
  }

  /DISCARD/ : { *(.bss) }
}
