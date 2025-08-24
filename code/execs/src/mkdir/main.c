#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>
#include <malloc.h>
int make_dir_nor(const char* path)
{
    if(mkdir(path,0777))
    {
        perror("Error creating directory");
        return -1;
    }
    return 0;
}
int make_dir_p(const char* path) {
    char tmp[512];
    size_t len;
    char *p;

    if (!path || !*path) {
        errno = EINVAL;
        return -1;
    }

    // Copy path to temporary buffer
    snprintf(tmp, sizeof(tmp), "%s", path);
    len = strlen(tmp);

    // Remove trailing slash if present
    if (len > 1 && tmp[len - 1] == '/') {
        tmp[len - 1] = '\0';
    }

    // Iterate through each part of the path to create parents
    for (p = tmp + 1; *p; p++) {
        if (*p == '/') {
            *p = '\0';
            if (mkdir(tmp, 0777) != 0) {
                if (errno != EEXIST) {
                    return -1;
                }
            }
            *p = '/';
        }
    }

    // Create the final directory
    if (mkdir(tmp, 0777) != 0) {
        if (errno != EEXIST) {
            return -1;
        }
    }

    return 0;
}
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <flags> <directory_name>\n", argv[0]);
        return 1;
    }

    bool flagP = false;
    char** dirs = malloc(argc*sizeof(char*));\
    int dirsCnt = 0;
    for(int i = 1; i < argc; i++)
    {
        if(!strchr(argv[i], '-'))
        {
            dirs[dirsCnt] = argv[i];
            dirsCnt++;
        }else{
            if(strchr(argv[i], 'p'))
            {
                flagP = true;
            }
        }
        
    }
    
    for(int i = 0; i < dirsCnt; i++)
    {
        if(flagP)
        {
            if(make_dir_p(dirs[i]) != 0)
            {
                return -1;
            }
        }else{
            if(make_dir_nor(dirs[i]) != 0)
            {
                return -1;
            }
        }
    }
    

    fflush(stdout);
    return 0;
}
