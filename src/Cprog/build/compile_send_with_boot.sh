MAIN=".."
SRC="../src"
BIN="../bin"
set -e

cd build
cp ../test.c ../src/main.c
./compile.sh amix.ld
if [ ! -f $BIN/program.bin ]; then
    echo "Build failed, aborting send."
    exit 1
fi

./send.sh /dev/ttyUSB0 115200 $BIN/program.elf