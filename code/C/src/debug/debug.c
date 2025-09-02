#include <stdio.h>
#include <stdarg.h>

// Set to 1 to enable debug prints, 0 to disable
#define DEBUG_ENABLED 1

void dbg_printf(const char *format, ...) {
    if (DEBUG_ENABLED) {
        va_list args;
        va_start(args, format);
        vprintf(format, args);
        va_end(args);
    }
}
