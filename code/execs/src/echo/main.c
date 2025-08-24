#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

// Function to interpret escape sequences like \n, \t, etc.
void print_with_escapes(const char *str) {
    while (*str) {
        if (*str == '\\') {
            str++;
            switch (*str) {
                case 'n': putchar('\n'); break;
                case 't': putchar('\t'); break;
                case 'r': putchar('\r'); break;
                case '\\': putchar('\\'); break;
                case '0': putchar('\0'); break;
                case '\0': return;
                default:
                    putchar('\\');
                    putchar(*str);
            }
        } else {
            putchar(*str);
        }
        if (*str)
            str++;
    }
}

// Print argument, expanding environment variable if it starts with '$'
void print_arg(const char *arg, bool interpret_escapes) {
    if (arg[0] == '$') {
        const char *env_val = getenv(arg + 1);  // Skip the '$'
        if (env_val) {
            if (interpret_escapes) {
                print_with_escapes(env_val);
            } else {
                fputs(env_val, stdout);
            }
        } else {
            // Environment variable not found, print empty string (do nothing)
            // If you want to print a placeholder instead, you can do so here.
        }
    } else {
        if (interpret_escapes) {
            print_with_escapes(arg);
        } else {
            fputs(arg, stdout);
        }
    }
}


int main(int argc, char *argv[], char *envp[]) {
    bool interpret_escapes = false;

    int arg_start = 1;
    if (argc > 1 && strcmp(argv[1], "-e") == 0) {
        interpret_escapes = true;
        arg_start = 2;
    }

    for (int i = arg_start; i < argc; i++) {
        print_arg(argv[i], interpret_escapes);

        if (i < argc - 1)
            putchar(' ');
    }

    putchar('\n');

    return 0;
}