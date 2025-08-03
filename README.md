# AMIX-68k
This is my Motorola 68010 CPU based system.
I plan to make it with 68010 CPU @ 12Mhz, DMA(68450) and othere periferials @ 10Mhz, IDE disk (CF card or good old HDD), Video output (Xosera), Aduio output (Aslo Xosera), Timers (again Xosera and 68230), Keyboard (68230 with RC2014 Yellow series MSX style keyboard), UART (16550 @ 115200 bps)

This isn't my first or (hopefully)last Retro style computer system, I alredy made two 6502 based computers, 8088 based system that is IBM compatable with 8 bit ISA, and built and coded for a handfull of z80/z180 based systems, mostly two RC2014 (Its funny that i like z80 MUCH more than 6502 but never made a system araund z80).
And also have ZX Spectrum 48k and ZX Spectrum NEXT.

But somehow this is the first time working with 68k chip, I known for 68k style systems but was afraid to touch them because they are two times more complex thatn 8 bit(right?) especely when i made 8088 system that was 8/16 bit and coudnt think how complecated would a full 16 bit system be, but when i looked closer at Motorola 68000 i thought i steped in to heven because of all the documentation and datasheet, and how a SINGLE datasheet was enough to understand almost everything to know(looking at you Intel).

# SPECS

|CPU | Motorola 68010 @ 12Mhz|
|----|-----------------------|
|RAM | 2 MB SRAM (Maybe DRAM in future)
|DMA | 68450 @ 10 Mhz|
|VIDEO & AUDIO| Xosera 640x480 2 playfields and Copper ( ͡❛ ͜ʖ ͡❛)|
|Keyboard| RC2014 Yellow series MSX style keyboard with n key rollover|
|DISK| IDE interface CF card or clasic HDD|
|UART| 16550 @ 18.432 Mhz -> 115200 bps|
|POWER| ATX PSU or 12V in|
|TIME & TIMERS| Tmers in Xosera and 68230, and RTC (SparkFun BOB-10160)|

# Present (problems)
For now the keyboard, Video output, UART and DISK work.

Xosera has problems reading and making interrupts, but i fixed this by using PIT interrupts.

PCB is flawed, will continue testing and changing the schematic/pcb design.

Started porting newlib got printf and string stuff working
# Future (TODO)

Fix all the above issues

~~make a C compiler working~~

C memory allocation

nice API (kinda not full)

~~libc (newlib)~~

relocatable programs

some sort of kernel

simple OS the AMIX OS

