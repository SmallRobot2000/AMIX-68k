#m68k-linux-gnu-as -o --register-prefix-optional bin/main.o main.asm
#vasmm68k_mot -m68010 -Felf  -o bin/main.o main.asm
vasmm68k_mot -m68010 -Felf -pic -o bin/main.o main.asm
m68k-linux-gnu-ld -T build/link.ld -N -o bin/main.elf bin/main.o
m68k-linux-gnu-objcopy -O binary bin/main.elf bin/program.bin

