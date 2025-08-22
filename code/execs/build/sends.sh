#send simple
set -e
SERIAL_DEV="/dev/ttyUSB0"
BAUDRATE="115200"
./send.sh $SERIAL_DEV $BAUDRATE $1