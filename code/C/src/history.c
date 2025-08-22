#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
#include <elf_loader.h>
#include <history.h>

#define HISTORY_SIZE 25
#define HISTORY_LINE_LENGTH 80

int history_ptr;
char history_buffer[HISTORY_SIZE][HISTORY_LINE_LENGTH+1];
int history_start()
{
    history_ptr = 0;
    for(int i = 0; i < HISTORY_SIZE; i++)
    {
        memcpy(history_buffer[i], "", 2);    
    }
    
    return 0;
}

void history_add(char *str)
{
    history_ptr = history_ptr == HISTORY_SIZE-1 ? 0 : history_ptr+1; //Set to 0 if end
    strncpy(history_buffer[history_ptr], str, HISTORY_LINE_LENGTH);
    history_buffer[history_ptr][HISTORY_LINE_LENGTH] = '\0';
}
char* history_get(int from_top) {
    if (from_top < 0 || from_top >= HISTORY_SIZE) {
        return NULL;
    }
    // calculate wrapped index
    int ptr = (history_ptr - from_top + HISTORY_SIZE) % HISTORY_SIZE;
    if (history_buffer[ptr][0] == '\0') {
        return NULL; // empty slot
    }
    return history_buffer[ptr];
}