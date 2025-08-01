#!/bin/bash

# Example shell script to compile and link a simple m68k program with Newlib and custom BSP

# Usage: ./build.sh test.c amix-crt0.S amix.ld

if [ $# -ne 3 ]; then
  echo "Usage: $0 <source.c> <crt0.S> <linker_script.ld>"
  exit 1
fi

SRC_C=$1
CRT0_S=$2
LDSCRIPT=$3

# Cross compiler prefix
CROSS=m68k-elf-

CC=${CROSS}gcc
OBJCOPY=${CROSS}objcopy

# Directories for includes and libs - adjust as needed
INCDIR=/usr/local/m68k-elf/m68k-elf/include
LIBDIR=/usr/local/m68k-elf/m68k-elf/lib

# Output file names
OBJS="main.o crt0.o"
TARGET=program.elf

echo "Compiling $SRC_C ..."
$CC -O2 -g -Wall -m68000 -nostdinc -I${INCDIR} -c $SRC_C -o main.o
if [ $? -ne 0 ]; then
  echo "Error: compiling $SRC_C failed"
  exit 2
fi

echo "Assembling $CRT0_S ..."
$CC -O2 -g -Wall -m68000 -nostdinc -I${INCDIR} -c $CRT0_S -o crt0.o
if [ $? -ne 0 ]; then
  echo "Error: assembling $CRT0_S failed"
  exit 3
fi

echo "Linking ..."
$CC main.o crt0.o -T $LDSCRIPT -L${LIBDIR} -Lamix -lc -lgcc -nostartfiles -o $TARGET
if [ $? -ne 0 ]; then
  echo "Error: linking failed"
  exit 4
fi

echo "Build complete: $TARGET"

echo "Generating binary and srec files ..."
$OBJCOPY -O binary $TARGET program.bin
$OBJCOPY -O srec $TARGET program.srec

echo "Generated program.bin and program.srec"

exit 0
