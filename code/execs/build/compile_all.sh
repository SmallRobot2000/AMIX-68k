MAIN=".."
SRC="../src"
BIN="../bin"
INC="../../include"
COMM="../common"
TMP="../tmp"
PROGRAMS=(ls)
set -e



for item in "${PROGRAMS[@]}"; do
C_FILE="$SRC/$item/$item.c"
echo amix.ld "$SRC/$item" $BIN $INC $item $COMM $TMP
./compile.sh amix.ld "$SRC/$item" $BIN $INC $item $COMM $TMP
#if [ ! -f $BIN/program.bin ]; then
    #echo "Build failed, aborting send."
    #exit 1
#fi
    
done

#./send.sh /dev/ttyUSB0 115200 $BIN/program.elf