SECTIONS
{
  . = 0x000000;

  .vectors : {
    KEEP(*(.vectors))
  }

  . = 0x000008;

  .text : {
    KEEP(*(.text))
  }
}
