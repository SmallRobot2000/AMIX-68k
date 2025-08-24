#!/usr/bin/env bash
set -e

LDSCRIPT=$1
SRC_DIR=$2
BIN_DIR=$3
INC_DIR=$4
NAME=$5
COMM_DIR=$6 #common directory
TMP_DIR=$7


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
#rm -f "$BIN_DIR"/*.{o,elf,bin,srec,map}

# Enable debug info for .symtab, keep relocations
COMMON_CFLAGS="-Os -g -m68010 -ffunction-sections -fdata-sections -Wall -I${INCDIR} -I${INC_DIR}"

#echo "Compiling C files..."
for src in "$SRC_DIR"/*.c; do
  [ -e "$src" ] || continue
  obj="$TMP_DIR/$(basename "${src%.c}").o"
  echo "  $src -> $obj"
  $CC $COMMON_CFLAGS -c "$src" -o "$obj"
done

for comm in "$COMM_DIR"/*.c; do
  [ -e "$comm" ] || continue
  obj="$TMP_DIR/$(basename "${comm%.c}").o"
  echo "  $comm -> $obj"
  $CC $COMMON_CFLAGS -c "$comm" -o "$obj"
done

#echo "Compiling assembly files..."
for src in "$SRC_DIR"/*.S; do
  [ -e "$src" ] || continue
  obj="$TMP_DIR/$(basename "${src%.S}").o"
  echo "  $src -> $obj"
  $CC $COMMON_CFLAGS -c "$src" -o "$obj"
done

for comm in "$COMM_DIR"/*.S; do
  [ -e "$comm" ] || continue
  obj="$TMP_DIR/$(basename "${comm%.S}").o"
  echo "  $comm -> $obj"
  $CC $COMMON_CFLAGS -c "$comm" -o "$obj"
done

OBJ_FILES=("$TMP_DIR"/*.o)
if [ "${#OBJ_FILES[@]}" -eq 0 ]; then
  echo "Error: No object files found in $TMP_DIR"
  exit 1
fi

#echo "Linking into $NAME.elf (with relocations)..."
CRT0="$TMP_DIR/crt0.o"
MAIN="$TMP_DIR/main.o"
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
    -Wl,-Map="$TMP_DIR/$NAME.map",--gc-sections,--emit-relocs \
    -lc -lm -lgcc -Wl,--no-warn-rwx-segments \
    -o "$BIN_DIR/$NAME.elf"

#echo "Stripping debug symbols only..."
$STRIP --strip-unneeded "$BIN_DIR/$NAME.elf"


#echo "Size of $NAME.elf:"
#$SIZE "$BIN_DIR/$NAME.elf"

#echo "Generating binary and SREC..."
$OBJCOPY -O binary "$BIN_DIR/$NAME.elf" "$BIN_DIR/$NAME.bin"
#$OBJCOPY -O srec   "$BIN_DIR/$NAME.elf" "$BIN_DIR/$NAME.srec"

#echo "Build complete."
