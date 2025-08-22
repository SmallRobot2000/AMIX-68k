#m68k-linux-gnu-as -o --register-prefix-optional bin/main.o main.asm
vasmm68k_mot -m68010 -Felf  -o bin/main.o main.asm
m68k-linux-gnu-ld -T build/link.ld -N -o bin/main.elf bin/main.o
m68k-linux-gnu-objcopy -O binary bin/main.elf bin/program.bin


python3 build/split.py

echo put even/lower ROM
read -n 1 -s
minipro -p "SST39SF040" -w bin/even.bin -s

echo put odd/upper ROM
read -n 1 -s
minipro -p "SST39SF040" -w bin/odd.bin -s
