MAIN=".."
SRC="../src"
BIN="../bin"
set -e
cd ../RAM_API
./program.sh
cd ../C
cd build
./compile.sh $MAIN/test.c $SRC/amix-crt0.S $SRC/amix.ld $SRC/amix_sys.c  $SRC/amix-syscalls.c $SRC/syscalls_asm.S
if [ ! -f $BIN/program.bin ]; then
    echo "Build failed, aborting send."
    exit 1
fi
./send_with_boot.sh