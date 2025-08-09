#!/bin/bash
set -e

LDSCRIPT=$1
SRC_DIR=${2:-../src}
BIN_DIR=${3:-../bin}
INC_DIR=${4:-../include}

CROSS=m68k-elf-
CC=${CROSS}gcc
STRIP=${CROSS}strip
OBJCOPY=${CROSS}objcopy
SIZE=${CROSS}size

NEWLIB_BASE="$HOME/opt/cross-newlib"
TARGET_PREFIX="m68k-elf-rosco"
INCDIR="${NEWLIB_BASE}/${TARGET_PREFIX}/include"
LIBDIR="${NEWLIB_BASE}/${TARGET_PREFIX}/lib"

# Clean previous builds
rm -f "$BIN_DIR"/*.o "$BIN_DIR"/*.elf "$BIN_DIR"/*.bin "$BIN_DIR"/*.srec "$BIN_DIR"/*.map

COMMON_CFLAGS="-Os -m68010 -ffunction-sections -fdata-sections -g -Wall -I${INCDIR} -I${INC_DIR}"

echo "Compiling C files..."
for c in "$SRC_DIR"/*.c; do
  [ -e "$c" ] || continue
  obj="$BIN_DIR/$(basename "${c%.c}").o"
  echo "  $c → $obj"
  $CC $COMMON_CFLAGS -c "$c" -o "$obj"
done

echo "Compiling assembly files..."
for s in "$SRC_DIR"/*.S; do
  [ -e "$s" ] || continue
  obj="$BIN_DIR/$(basename "${s%.S}").o"
  echo "  $s → $obj"
  $CC $COMMON_CFLAGS -c "$s" -o "$obj"
done

OBJ_FILES=$(find "$BIN_DIR" -maxdepth 1 -name '*.o' -print)
if [ -z "$OBJ_FILES" ]; then
  echo "Error: no .o files in $BIN_DIR"
  exit 1
fi

echo "Linking into ELF (symbols preserved)..."
CRT0_OBJ="$BIN_DIR/crt0.o"
MAIN_OBJ="$BIN_DIR/main.o"
OTHER_OBJS=$(for o in $OBJ_FILES; do
  case "$o" in
    "$CRT0_OBJ"|"$MAIN_OBJ") ;;
    *) printf ' %s' "$o" ;;
  esac
done)

$CC -nostartfiles \
    "$CRT0_OBJ" "$MAIN_OBJ" $OTHER_OBJS \
    -T "$LDSCRIPT" \
    -L "$LIBDIR" \
    -Wl,-Map="$BIN_DIR/program.map",--gc-sections \
    -lc -lm -lgcc \
    -o "$BIN_DIR/program.elf"

echo "Generated $BIN_DIR/program.elf (symbols intact)"

echo "Size:"
$SIZE "$BIN_DIR/program.elf"

echo "Stripping debug symbols only..."
$STRIP --strip-debug "$BIN_DIR/program.elf"

echo "Size of program.elf:"
$SIZE "$BIN_DIR/program.elf"

echo "Generating binary and SREC..."
$OBJCOPY -O binary "$BIN_DIR/program.elf" "$BIN_DIR/program.bin"
$OBJCOPY -O srec   "$BIN_DIR/program.elf" "$BIN_DIR/program.srec"
echo "Build complete."
