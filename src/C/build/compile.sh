#!/bin/bash
set -e
if [ $# -ne 6 ]; then
  echo "Usage: $0 <source.c> <crt0.S> <linker_script.ld> <sys.c> <sys-calls.c> <sys-calls.asm>"
  exit 1
fi

BIN="../bin"
INCLUDE="../include"

SRC_C=$1
CRT0_S=$2
LDSCRIPT=$3
SRC_SYS=$4
SRC_SYS_CALLS=$5
ASM_SYS_CALLS=$6

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

COMMON_CFLAGS="-Os -g -m68000 -ffunction-sections -fdata-sections -Wall -I${INCDIR} -I${INCLUDE}"

$CC $COMMON_CFLAGS -c $SRC_C        -o $BIN/main.o
$CC $COMMON_CFLAGS -c $SRC_SYS      -o $BIN/sys.o
$CC $COMMON_CFLAGS -c $CRT0_S       -o $BIN/crt0.o
$CC $COMMON_CFLAGS -c $SRC_SYS_CALLS   -o $BIN/syscalls.o
$CC $COMMON_CFLAGS -c $ASM_SYS_CALLS     -o $BIN/syscalls_asm.o

echo "Linking..."
$CC -nostartfiles \
   $BIN/crt0.o $BIN/main.o $BIN/syscalls.o $BIN/sys.o $BIN/syscalls_asm.o \
   -T $LDSCRIPT \
   -L${LIBDIR} \
   -Wl,-Map=program.map,--gc-sections \
   -lc -lm -lgcc \
   -Wl,--strip-all \
   -o $BIN/program.elf

echo "Stripping symbols..."
$STRIP --strip-all $BIN/program.elf

echo "Build complete: program.elf"

echo "Size:"
${CROSS}size $BIN/program.elf

echo "Generating program.bin and program.srec..."
$OBJCOPY -O binary $BIN/program.elf $BIN/program.bin
$OBJCOPY -O srec $BIN/program.elf $BIN/program.srec

echo "Done."
