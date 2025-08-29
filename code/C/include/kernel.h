
extern char _SRC_PATH[256];
extern char _BIN_PATH[256];
extern char _SYS_PATH[256];
extern uint32_t _WORKING_PROGRAM_ADD;
extern uint32_t _WORKING_PROGRAM_MAX_SIZE;
extern void kernel_start();
extern int fatfs_to_errno(FRESULT res);