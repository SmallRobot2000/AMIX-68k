#include <stdio.h>
#include <dirent.h>
#include <errno.h>
#include <sys/stat.h>
#include <string.h>
#include <stdbool.h>
#include <malloc.h>
//ls


// Comparison function to sort strings in ascending order
int compareStrings(const void *a, const void *b) {
    const char *strA = *(const char **)a;
    const char *strB = *(const char **)b;
    return strcmp(strA, strB);
}
char* nameBuf;
char **entryStr;
int main(int argc, char *argv[]) {
    //name <path> <flags>
    bool flagL = false; //long
    bool flagH = false; //Human readable
    bool flagA = false; //All files
    bool flagF = false; //Append indicator(/ for directories * for executables)

    int pathCnt = 0;
    char** paths = malloc(argc * sizeof(char*)); //Max possilbe paths
    for(int i = 1;i < argc; i++)
    {
        if(argv[i] == NULL){break;} //End

        if(argv[i][0] == '-')
        {//Flags
            if(strchr(argv[i],'l'))
            {//long
                flagL = true;
            }
            if(strchr(argv[i],'h'))
            {//long
                flagH = true;
            }
            if(strchr(argv[i],'a'))
            {//long
                flagA = true;
            }
            if(strchr(argv[i],'F'))
            {//long
                flagF = true;
            }
        }else{ //Path
            paths[pathCnt] = malloc(strlen(argv[i])+1);
            strcpy(paths[pathCnt], argv[i]);
            pathCnt++;
            
        }
    }
    

    int prints;
    if(pathCnt == 0)
    {
        //Only cur directory
        paths[0] = ".";
        prints = 1;
    }else{ //Multiple paths
        prints = pathCnt;
    }
    int strPrintLineCnt = 0;

    for(int i = 0; i < prints; i++)
    {//For every path
        
        DIR *dir = opendir(paths[i]);
        if (dir == NULL) {
            perror("opendir");
            return -1;
        }//Chek if dir exists
        struct dirent *entry;
        if(prints > 1)
        {//Printh path if more than one
            printf("%s:\n",paths[i]);
        }
        //print entrys with flags:
        entryStr = malloc(sizeof(char*));
        int entrys = 0;
        
        while ((entry = readdir(dir)) != NULL) {
            //flags:    l - long
            //          h - human readable
            //          a - hidden fiels also
            //          F - append indicator
            char* fullpath = malloc(strlen(paths[i])+strlen(entry->d_name)+2); //+2 for / and 0
            strcpy(fullpath, paths[i]);
            strcat(fullpath, "/");
            strcat(fullpath, entry->d_name);

            //First chek if we parse it
            if(entry->d_name[0] == '.' && !flagA){continue;} //Skip if hidden file and no all flag set
            entrys++;

            //Expand entryStr
            char **tmp = malloc((entrys)*sizeof(char*));
            memcpy(tmp, entryStr, (entrys)*sizeof(char*));
            entryStr = realloc(entryStr, entrys*sizeof(char*));
            memcpy(entryStr, tmp, (entrys)*sizeof(char*));
            free(tmp);


            //entryStr[entrys-1] = strdup(entry->d_name); //Fills entryStr with all entry names
            struct stat st;
            if(stat(fullpath, &st) != 0)
            {
                printf("Path: %s\n",fullpath);
                perror("stat");
                return -1;
            }


            char* entryName = malloc(strlen(entry->d_name) + 5); //for append if needed and end of string
            strcpy(entryName, entry->d_name);
            
            
            if(flagF){
                if(S_ISDIR(st.st_mode)) //Chek directory
                {
                strcat(entryName, "/");
                }else if(S_IXUSR & st.st_mode) //Chek user executable
                strcat(entryName, "*");
            }else{
                strcat(entryName, "");
            }

            if(flagL){
                //flags + size + date + name
                //flags = 9, size = ?, date = ?, name = strlen(entryName)
                //All added to entryName
                //Flags

                char* flagsStr = malloc(11*sizeof(char)); //10 for flags + 1 for 0
                strcpy(flagsStr, (S_ISDIR(st.st_mode)) ? "d" : "-");

                strcat(flagsStr, (st.st_mode & S_IRUSR) ? "r" : "-");
                strcat(flagsStr, (st.st_mode & S_IWUSR) ? "w" : "-");
                strcat(flagsStr, (st.st_mode & S_IXUSR) ? "x" : "-");

                strcat(flagsStr, (st.st_mode & S_IRGRP) ? "r" : "-");
                strcat(flagsStr, (st.st_mode & S_IWGRP) ? "w" : "-");
                strcat(flagsStr, (st.st_mode & S_IXGRP) ? "x" : "-");

                strcat(flagsStr, (st.st_mode & S_IROTH) ? "r" : "-");
                strcat(flagsStr, (st.st_mode & S_IWOTH) ? "w" : "-");
                strcat(flagsStr, (st.st_mode & S_IXOTH) ? "x" : "-");






                long FileSize = st.st_size;
                long FileSizeDiv = 1;
                char FileSizeChar = ' ';

                if(flagH)
                {
                    if(FileSize > 1024 && FileSize < 1024*1024)
                    {
                        FileSizeChar = 'K';
                        FileSizeDiv = 1024; //divider
                    }else if(FileSize > 1024*1024)
                    {
                        FileSizeChar = 'M';
                        FileSizeDiv = 1024*1024; //divider
                    }else{
                        FileSizeChar = 'B';
                    }
                }

                double FileSizeNum = (double)FileSize/FileSizeDiv; //Get wanted number for file size in coralatio with devider
                char *FileSizeStr = malloc(23*sizeof(char)); //enough for 64 bit long + B/K/M
                sprintf(FileSizeStr, "%.1lf%c",FileSizeNum,FileSizeChar); //example 32.3M


                int strSize = strlen(flagsStr) + strlen(FileSizeStr) + strlen(entryName) + 10; //10 for safety
                nameBuf = malloc(strSize*sizeof(char));
                //Combine it all
                snprintf(nameBuf, strSize,"%10s %10s %s", flagsStr, FileSizeStr, entryName);
                
                entryStr[entrys-1] = nameBuf; //Save full string

                free(flagsStr);
                free(FileSizeStr);



                
            }else{ //Normal formating not long formating
                nameBuf = malloc(21 * sizeof(char));

                snprintf(nameBuf, 20, "%.19s ", entryName);
                
                entryStr[entrys-1] = nameBuf; //Save full string
            }
            free(entryName);
            free(fullpath);
        
            
        }


        for(int n = 0; n < entrys; n++)
        {
            if(!flagL && (strPrintLineCnt + strlen(entryStr[n])) > 80)
            {
                strPrintLineCnt = 0;
                printf("\n\n"); //New line when too much for single line(double for clearncy)
            }
            if(!flagL)
            {
                printf("%s", entryStr[n]);
                strPrintLineCnt += strlen(entryStr[n]);
            }else{
                printf("%s\n", entryStr[n]);
            
            }
            
        }
    }
    printf("\n");
    free(paths);
    fflush(stdout);
    return 0;

}

/*
const char *path = ".";  // Default to current directory
    if (argc > 1) {
        path = argv[1];
    }

    DIR *dir = opendir(path);
    if (dir == NULL) {
        perror("opendir");
        return 1;
    }
char fullpath[PATH_MAX];
struct stat st;
    struct dirent *entry;
    printf("Contents of directory: %s\n", path);
    while ((entry = readdir(dir)) != NULL) {
        printf("%s\n", entry->d_name);

        snprintf(fullpath, sizeof(fullpath), "%s/%s", path, entry->d_name);
if (stat(fullpath, &st) == 0) {
    if (S_ISDIR(st.st_mode))
        printf("%s is a directory\n", entry->d_name);
    else if (S_IS (st.st_mode))
        printf("%s is a regular file\n", entry->d_name);
    else
        printf("%s is other type\n", entry->d_name);
} else {
    perror("stat");
}

    }

    if (closedir(dir) != 0) {
        perror("closedir");
        return 1;
    }


*/
