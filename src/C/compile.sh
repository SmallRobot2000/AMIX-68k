#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: $0 <source.c> <crt0.S> <linker_script.ld>"
  exit 1
fi

SRC_C=$1
CRT0_S=$2
LDSCRIPT=$3

CROSS=m68k-elf-
CC=${CROSS}gcc
STRIP=${CROSS}strip
OBJCOPY=${CROSS}objcopy

NEWLIB_BASE="$HOME/opt/cross-newlib"
TARGET_PREFIX="m68k-elf-rosco"
INCDIR="${NEWLIB_BASE}/${TARGET_PREFIX}/include"
LIBDIR="${NEWLIB_BASE}/${TARGET_PREFIX}/lib"

echo "=== Custom TRAP #0 Size-Optimized Build ==="

# Clean
rm -f *.o *.elf *.bin *.srec *.map

COMMON_CFLAGS="-Os -g -m68000 -ffunction-sections -fdata-sections -Wall -I${INCDIR}"

$CC $COMMON_CFLAGS -c $SRC_C        -o main.o -I ./include
$CC $COMMON_CFLAGS -c $CRT0_S       -o crt0.o
$CC $COMMON_CFLAGS -c amix-syscalls.c   -o syscalls.o
$CC $COMMON_CFLAGS -c syscalls_asm.S     -o syscalls_asm.o

echo "Linking..."
$CC -nostartfiles \
   crt0.o main.o syscalls.o syscalls_asm.o \
   -T $LDSCRIPT \
   -L${LIBDIR} \
   -Wl,-Map=program.map,--gc-sections \
   -lc -lm -lgcc \
   -Wl,--strip-all \
   -o program.elf

echo "Stripping symbols..."
$STRIP --strip-all program.elf

echo "Build complete: program.elf"

echo "Size:"
${CROSS}size program.elf

echo "Generating program.bin and program.srec..."
$OBJCOPY -O binary program.elf program.bin
$OBJCOPY -O srec program.elf program.srec

echo "Done."
