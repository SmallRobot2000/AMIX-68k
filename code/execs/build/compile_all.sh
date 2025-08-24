MAIN=".."
SRC="../src"
BIN="../bin"
INC="../../include"
COMM="../common"
TMP="../tmp"
PROGRAMS=(pwd ls cd echo env)
set -e



for item in "${PROGRAMS[@]}"; do
#Empty tmp
if [ -z "$(ls -A "$TMP")" ]; then
    #do nothing
    echo 123
else
    rm -r "$TMP"/*
fi


./compile.sh amix.ld "$SRC/$item" $BIN $INC $item $COMM $TMP
echo "$item done"
#if [ ! -f $BIN/program.bin ]; then
    #echo "Build failed, aborting send."
    #exit 1
#fi
    
done

#./send.sh /dev/ttyUSB0 115200 $BIN/program.elf