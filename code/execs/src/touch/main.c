#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>
#include <errno.h>
#include <string.h>
int touch(const char *filename) {
    FILE *fil;
    fil = fopen(filename, "w");
    if (fil == NULL) {
        perror("touch");
        return -1;
    }


    fclose(fil);
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s filename\n", argv[0]);
        return 1;
    }

    if (touch(argv[1]) != 0) {
        fprintf(stderr, "Failed to touch file '%s'%s\n", argv[1], strerror(errno));
        return -1;
    }
    return 0;
}
