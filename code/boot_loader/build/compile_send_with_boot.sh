MAIN=".."
SRC="../src"
BIN="../bin"
set -e
cd build

./compile.sh amix.ld ../../include
if [ ! -f $BIN/program.bin ]; then
    echo "Build failed, aborting send."
    exit 1
fi

cd ../../RAM_API
./program.sh
cd ../C

#./send_with_boot.sh