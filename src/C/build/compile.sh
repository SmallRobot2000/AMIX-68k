#!/bin/bash
set -e

LDSCRIPT=$1
SRC_DIR=${2:-../src}  # Default to 'src' if not provided
BIN_DIR=${3:-../bin}  # Default to 'bin' if not provided
INC_DIR=${4:-../include}



CROSS=m68k-elf-
CC=${CROSS}gcc
STRIP=${CROSS}strip
OBJCOPY=${CROSS}objcopy

NEWLIB_BASE="$HOME/opt/cross-newlib"
TARGET_PREFIX="m68k-elf-rosco"
INCDIR="${NEWLIB_BASE}/${TARGET_PREFIX}/include"
LIBDIR="${NEWLIB_BASE}/${TARGET_PREFIX}/lib"

# Clean previous builds
rm -f $BIN_DIR/*.o $BIN_DIR/*.elf $BIN_DIR/*.bin $BIN_DIR/*.srec $BIN_DIR/*.map

COMMON_CFLAGS="-Os -g -m68000 -ffunction-sections -fdata-sections -Wall -I${INCDIR} -I${INC_DIR}"

# Find and compile all .c files in src directory
echo "Compiling C files..."
for c_file in $SRC_DIR/*.c; do
    if [ -f "$c_file" ]; then
        basename=$(basename "$c_file" .c)
        echo "  Compiling $c_file -> $BIN_DIR/${basename}.o"
        $CC $COMMON_CFLAGS -c "$c_file" -o "$BIN_DIR/${basename}.o"
    fi
done

# Find and compile all .S files in src directory
echo "Compiling assembly files..."
for s_file in $SRC_DIR/*.S; do
    if [ -f "$s_file" ]; then
        basename=$(basename "$s_file" .S)
        echo "  Compiling $s_file -> $BIN_DIR/${basename}.o"
        $CC $COMMON_CFLAGS -c "$s_file" -o "$BIN_DIR/${basename}.o"
    fi
done

# Collect all object files for linking
OBJ_FILES=$(find $BIN_DIR -name "*.o" -type f)

if [ -z "$OBJ_FILES" ]; then
    echo "Error: No object files found in $BIN_DIR"
    exit 1
fi

echo "Object files created:"
for obj in $OBJ_FILES; do
    echo "  $obj"
done


# Link all object files
echo "Linking..."
# Ensure crt0.o is first, main.o second, then all other objects
CRT0_OBJ=$BIN_DIR"/crt0.o"
MAIN_OBJ=$BIN_DIR"/main.o"

# Collect all object files except crt0.o and main.o
OTHER_OBJS=$(find "$BIN_DIR" -maxdepth 1 -name '*.o' ! -name 'crt0.o' ! -name 'main.o' | tr '\n' ' ')

$CC -nostartfiles \
    $CRT0_OBJ $MAIN_OBJ $OTHER_OBJS \
    -T "$LDSCRIPT" \
    -L "${LIBDIR}" \
    -Wl,-Map=./program.map,--gc-sections \
    -lc -lm -lgcc \
    -Wl,--strip-all \
    -o "$BIN_DIR"/program.elf


echo "Stripping symbols..."
$STRIP --strip-all $BIN_DIR/program.elf

echo "Build complete: program.elf"

echo "Size:"
${CROSS}size $BIN_DIR/program.elf

# Generate binary and SREC files
echo "Generating output files..."
$OBJCOPY -O binary $BIN_DIR/program.elf $BIN_DIR/program.bin
$OBJCOPY -O srec $BIN_DIR/program.elf $BIN_DIR/program.srec

echo "Done."
