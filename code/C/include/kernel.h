extern FATFS fs; //kernel FS
char _SRC_PATH[256];
char _BIN_PATH[256];
char _SYS_PATH[256];
uint32_t _WORKING_PROGRAM_ADD;
uint32_t _WORKING_PROGRAM_MAX_SIZE;
int kernel_start();