cd ../RAM_API
./program.sh
cd ../C
./compile.sh test.c amix-crt0.S amix.ld amix_sys.c 
if [ ! -f program.bin ]; then
    echo "Build failed, aborting send."
    exit 1
fi
./send_with_boot.sh