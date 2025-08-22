#!/bin/bash
# send_xmodem.sh – Send a file over UART using XMODEM and then send ENTER
#
# Usage: ./send_xmodem.sh <serial_device> <baudrate> <file_to_send>
# Example: ./send_xmodem.sh /dev/ttyUSB0 115200 firmware.bin

if [ $# -ne 3 ]; then
  echo "Usage: $0 <serial_device> <baudrate> <file_to_send>"
  exit 1
fi

SERIAL_DEV=$1
BAUDRATE=$2
FILE_TO_SEND=$3

if [ ! -c "$SERIAL_DEV" ]; then
  echo "Error: Serial device $SERIAL_DEV not found."
  exit 2
fi

if [ ! -f "$FILE_TO_SEND" ]; then
  echo "Error: File $FILE_TO_SEND not found."
  exit 3
fi

# Configure serial port
stty -F "$SERIAL_DEV" "$BAUDRATE" cs8 -cstopb -parenb -ixon -ixoff raw
if [ $? -ne 0 ]; then
  echo "Error: Failed to configure $SERIAL_DEV."
  exit 4
fi

echo "Sending $FILE_TO_SEND to $SERIAL_DEV at ${BAUDRATE}baud using XMODEM..."
echo "Please put the target into XMODEM receive mode now."

# Send file via XMODEM
sx "$FILE_TO_SEND" > "$SERIAL_DEV" < "$SERIAL_DEV"
STATUS=$?

if [ $STATUS -ne 0 ]; then
  echo "Error: XMODEM transfer failed with status $STATUS."
  exit 5
fi

# After successful transfer, send ENTER (CR+LF)
printf '\r' > "$SERIAL_DEV"

echo "Transfer complete and ENTER key sent."
exit 0
