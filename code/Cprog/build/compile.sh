#!/usr/bin/env bash
set -e

LDSCRIPT=$1
COMM_INC=$2
SRC_DIR=${3:-../src}
BIN_DIR=${4:-../bin}
INC_DIR=${5:-../include}

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
rm -f "$BIN_DIR"/*.{o,elf,bin,srec,map}

# Enable debug info for .symtab, keep relocations
COMMON_CFLAGS="-Os -g -m68010 -ffunction-sections -fdata-sections -Wall -I${INCDIR} -I${INC_DIR} -I${COMM_INC}"

echo "Compiling C files..."
for src in "$SRC_DIR"/*.c; do
  [ -e "$src" ] || continue
  obj="$BIN_DIR/$(basename "${src%.c}").o"
  echo "  $src -> $obj"
  $CC $COMMON_CFLAGS -c "$src" -o "$obj"
done

echo "Compiling assembly files..."
for src in "$SRC_DIR"/*.S; do
  [ -e "$src" ] || continue
  obj="$BIN_DIR/$(basename "${src%.S}").o"
  echo "  $src -> $obj"
  $CC $COMMON_CFLAGS -c "$src" -o "$obj"
done

OBJ_FILES=("$BIN_DIR"/*.o)
if [ "${#OBJ_FILES[@]}" -eq 0 ]; then
  echo "Error: No object files found in $BIN_DIR"
  exit 1
fi

echo "Linking into program.elf (with relocations)..."
CRT0="$BIN_DIR/crt0.o"
MAIN="$BIN_DIR/main.o"
OTHER_OBJS=()
for o in "${OBJ_FILES[@]}"; do
  case "$(basename "$o")" in
    crt0.o|main.o) ;;
    *) OTHER_OBJS+=("$o") ;;
  esac
done

$CC -nostartfiles \
    "$CRT0" "$MAIN" "${OTHER_OBJS[@]}" \
    -T "$LDSCRIPT" \
    -L "$LIBDIR" \
    -Wl,-Map="$BIN_DIR/program.map",--gc-sections,--emit-relocs \
    -lc -lm -lgcc \
    -o "$BIN_DIR/program.elf"

echo "Stripping debug symbols only..."
$STRIP --strip-unneeded "$BIN_DIR/program.elf"


echo "Size of program.elf:"
$SIZE "$BIN_DIR/program.elf"

echo "Generating binary and SREC..."
$OBJCOPY -O binary "$BIN_DIR/program.elf" "$BIN_DIR/program.bin"
$OBJCOPY -O srec   "$BIN_DIR/program.elf" "$BIN_DIR/program.srec"

echo "Build complete."
