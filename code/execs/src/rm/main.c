#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>    // for rmdir
#include <sys/stat.h>  // for stat
#include <stdbool.h>
#include <stdarg.h>
#include <dirent.h>

void eprintf(const char *format, ...) {
    va_list args;
    va_start(args, format);

    // Print the formatted user message first
    vfprintf(stderr, format, args);
    
    va_end(args);

    // Print colon, space, and error message related to errno
    fprintf(stderr, ": %s\n", strerror(errno));
}

int rm_nor(const char *path) {
    struct stat path_stat;
    
    if (stat(path, &path_stat) != 0) {
        perror("rm");
        return -1;
    }

    if (S_ISDIR(path_stat.st_mode)) {
        // It's a directory, try to remove directory (must be empty)
        errno = EISDIR;
        eprintf("rm: cannot remove '%s'",path);
        return -1;
    } else {
        // It's a file (or other), remove file
        if (remove(path) != 0) {
            eprintf("rm: cannot remove '%s'",path);
            return -1;
        }
    }
    
    return 0;
}

int rm_r(const char *path) {
    struct stat path_stat;
    
    if (stat(path, &path_stat) != 0) {
        eprintf("rm: cannot remove '%s'",path);
        return -1;
    }

    if (S_ISDIR(path_stat.st_mode)) {
        // It's a directory, try to remove directory (must be empty) so recusevly empty it
        DIR *dir = opendir(path);
        struct dirent *dr = readdir(dir);
        if(dr != NULL)
        {
            char* newPath = malloc(strlen(path) + strlen(dr->d_name) + 2);
            strcpy(newPath, path);
            strcat(newPath, "/");
            strcat(newPath, dr->d_name); //newpath
            rm_r(newPath); //remove that dir
            free(newPath);
        }
        closedir(dir);
            if(rmdir(path))
            {
                eprintf("rm: cannot remove '%s'",path);
                return -1;
            }
        
        
        
    } else {
        // It's a file (or other), remove file
        if (remove(path) != 0) {
            eprintf("rm: cannot remove '%s'",path);
            return -1;
        }
    }
    
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <flags> <file_or_directory_path>\n", argv[0]);
        return 1;
    }
    bool flagR = false;
    char** paths = malloc(argc*sizeof(char*)); //Max number of paths
    int pathCnt = 0;
    for(int i = 1; i < argc; i++)
    {
        if(strchr(argv[i],'-') && strchr(argv[i],'r')) //Reculsive
        {
            flagR = true;
        }
        if(!strchr(argv[i],'-'))
        {
            //Not a flag
            paths[pathCnt] = argv[i];
            pathCnt++;
        }

    }
    for(int i = 0; i < pathCnt; i++)
    {
        //For every path
        if(flagR)
        {
            //Remove recursivly
            rm_r(paths[i]);
        }else{
            //Remove only files
            rm_nor(paths[i]);
        }
    }
    fflush(stdout);
    return 0;
}
