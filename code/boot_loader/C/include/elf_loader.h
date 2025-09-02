#include<stdint.h>
#include <stdbool.h>
uint32_t load_elf(const char *path, void *base_addr);
uint32_t load_and_file_elf(const char *path, void *base_addr, const char *bin_path);
bool is_elf_file(const char *path);
int call_address(uint32_t add, char **argv, int argc);
int run_file(const char* path, char **argv, int argc); //sets $?