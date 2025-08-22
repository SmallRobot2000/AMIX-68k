MAIN=".."
SRC="../src"
BIN="../bin"
set -e
cd ../RAM_API
./program.sh
cd ../C
cd build
cp ../test.c ../src/main.c
./compile.sh amix.ld ../../include
if [ ! -f $BIN/program.bin ]; then
    echo "Build failed, aborting send."
    exit 1
fi
./send_with_boot.sh