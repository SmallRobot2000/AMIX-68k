MAIN=".."
SRC="../src"
BIN="../bin"
INC="../../include"
INC2="../include"
COMM="../common"
TMP="../tmp"
set -e



./compile.sh amix.ld "$SRC/main.c" $BIN $INC kernel $COMM $TMP
echo "$item done"
#if [ ! -f $BIN/program.bin ]; then
    #echo "Build failed, aborting send."
    #exit 1
#fi
    


#./send.sh /dev/ttyUSB0 115200 $BIN/program.elf