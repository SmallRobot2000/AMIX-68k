#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ff.h>
#include <stdint.h>
#include <xmodem.h>
#include <elf_loader.h>
#include <kernel.h>
#include <history.h>
#include <stdbool.h>

#define PRG_MIN_ADD 0x180000
#define PRG_FOLDER "/bin/"
#define LINE_HISTORY "/etc/history"
#define DEFAULT_PROMPT "$"
uint8_t * buffer;
PARTITION VolToPart[FF_VOLUMES] = {
        {0, 1},    /* "0:" ==> 1st partition in physical drive 0 */
        {0, 2}     /* "1:" ==> 2nd partition in physical drive 0 */
    };
LBA_t plist[] = {100, 0, 0};  /* Divide the drive to one full volume and one empty */

BYTE work[FF_MAX_SS];         /* Working buffer */

FRESULT list_dir (const char *path)
{
    FRESULT res;
    DIR dir;
    FILINFO fno;
    int nfile, ndir;
    

    res = f_opendir(&dir, path);                   /* Open the directory */
    if (res == FR_OK) {
        nfile = ndir = 0;
        for (;;) {
            res = f_readdir(&dir, &fno);           /* Read a directory item */
            if (fno.fname[0] == 0) break;          /* Error or end of dir */
            if (fno.fattrib & AM_DIR) {            /* It is a directory */
                printf("   <DIR>   %s\n", fno.fname);
                ndir++;
            } else {                               /* It is a file */
                printf("%10lu %s\n", fno.fsize, fno.fname);
                nfile++;
            }
        }
        f_closedir(&dir);
        printf("%d dirs, %d files.\n", ndir, nfile);
    } else {
        printf("Failed to open \"%s\". (%u)\n", path, res);
    }
    return res;
}


void parse_line(char* line)
{
    char * linePtr = strtok(line, " ");
    if(strcmp(linePtr,"clear") == 0) //no diff
    {
        //printf("We are testing!!\n");
        sys_scroll(32);
        syscall_trap0(0x0CL,0x00L,0x00); //set cursor to 0,0
        //fs
    }else if(strcmp(linePtr,"fdisk") == 0){
        printf("Result of fdisk: %x\n", f_fdisk(0, plist, work));            /* Divide the physical drive 0 */
        printf("Hello??? \n");


    }else if(strcmp(linePtr,"getfree") == 0)
    {
        DWORD fre_clust, fre_sect, tot_sect;
        FATFS *fatfs;
        if(f_getfree("0",&fre_clust,&fatfs)){printf("Error!");}            /* Divide the physical drive 0 */
        /* Get total sectors and free sectors */
        tot_sect = (fatfs->n_fatent - 2) * fatfs->csize;
        fre_sect = fre_clust * fatfs->csize;
        /* Print the free space (assuming 512 bytes/sector) */
        printf("%10lu KiB total drive space.\n%10lu KiB available.\n", tot_sect / 2, fre_sect / 2);
        
    }else if(strcmp(linePtr,"mkfs") == 0)
    {
        
        printf("Result of mkfs: %d\n",f_mkfs("0:",NULL,work,FF_MAX_SS)); //default params
    }else if(strcmp(linePtr,"mnt") == 0)
    {
        printf("Result of mnt: %d\n",f_mount(&fs,"0:",0)); //default params
    }else if(strcmp(linePtr,"print") == 0)
    {
        char * arg;
        arg = strtok(NULL," ");
        printf("\n%s\n",arg);
    }else if(strcmp(linePtr,"mkdir") == 0)
    {
        char * arg;
        arg = strtok(NULL," ");
        if(f_mkdir(arg)){printf("Error");}
        printf("\n");
    }else if(strcmp(linePtr,"cd") == 0)
    {
        char * arg;
        arg = strtok(NULL," ");
        if(f_chdir(arg)){printf("Error");}
        printf("\n");
    }else if(strcmp(linePtr,"ls") == 0)
    {
        char * arg;
        arg = strtok(NULL," ");
        if(arg == NULL)
        {
            arg = ".";
        }
        printf("\n");
        if(list_dir(arg)){printf("Error");}
        
    }else if(strcmp(linePtr,"pwd") == 0)
    {
        char path[80];
        printf("\n");
        if(f_getcwd(path, 80)){printf("Error");}
        printf("%s\n",path);
        
    }else if(strcmp(linePtr,"xmodem") == 0)
    {
        char * arg;
        arg = strtok(NULL," ");
        if(arg == NULL)
        {
            printf("Usage: xmodem <file_name>");
            return;
        }
        xmodem_receive(arg);
        
    }else if(strcmp(linePtr,"cat") == 0)
    {
        char * arg;
        arg = strtok(NULL," ");
        if(arg == NULL)
        {
            printf("Usage: xmodem <file_name>");
            return;
        }
        FIL fp;
        FRESULT res = f_open(&fp, arg, FA_READ);
        if(res)
        {
            printf("Error opening file %s\n",arg);
        }
        char cbuf[32];
        unsigned int bw;
        while(1)
        {
            res = f_read(&fp, cbuf, 32, &bw);
            if(res)
            {
                printf("Error reading file\n");
                f_close(&fp);
                return;
            }
            if(bw == 0)
            {
                break;
            }
            for(int i = 0; i < bw; i++)
            {
                printf("%c",cbuf[i]);
            }
        }
        printf("\n");
    }else if(strcmp(linePtr,"load") == 0)
    {
        printf("\n");
        char * arg;
        arg = strtok(NULL," ");
        if(arg == NULL)
        {
            printf("Usage: load <.elf file> <address>\n");
            return;
        }
        char path[128];
        memcpy(path, arg, strlen(arg)+1);

        arg = strtok(NULL," ");
        if(arg == NULL)
        {
            printf("Usage: load <.elf file> <address>\n");
            return;
        }
        char *end;
        long add = strtol(arg, &end, 0);

        if (errno == ERANGE) {
            printf("Error converting address\n");
            return;
        }
        if(end == arg || add < PRG_MIN_ADD)
        {
            printf("Invalid address\n");
            return;
        }
        
        printf("Load exit code: %lu\n", load_elf(path, (void*)add));
    }else if(strcmp(linePtr,"run") == 0)
    {
        printf("\n");
        char * arg;
        arg = strtok(NULL," ");
        
        if(arg == NULL)
        {
            printf("Usage: run <ELF file>\n");
            return;
        }
        uint32_t add = _WORKING_PROGRAM_ADD;
        if(load_elf(arg, (void *)add) < 0)
        {
            printf("Error loading file\n");
        }else{
            printf("Return exit code: 0x%04x\n", call_address(add));
        }
        
        
        
    }else if(strcmp(linePtr,"dump") == 0)
    {
        printf("\n");
        char * arg;
        arg = strtok(NULL," ");
        char *end;
        
        if(arg == NULL)
        {
            printf("Usage: dump <address> <lenght>\n");
            return;
        }
        long add = strtol(arg, &end, 0);

        if (errno == ERANGE) {
            printf("Error converting address\n");
            return;
        }
        if(end == arg)
        {
            printf("Invalid address\n");
            return;
        }
        arg = strtok(NULL," ");
        if(arg == NULL)
        {
            printf("Usage: dump <address> <lenght>\n");
            return;
        }
        long len = strtol(arg, &end, 0);

        if (errno == ERANGE) {
            printf("Error converting address\n");
            return;
        }
        if(end == arg)
        {
            printf("Invalid address\n");
            return;
        }

        printf("Dumping at 0x%08lx lengh 0x%08lx\n",add, len);
        dump_memory((void *)add, (size_t)len);
        printf("\n");
        
    }else if(strcmp(linePtr,"rm") == 0)
    {
        printf("\n");
        char *arg = strtok(NULL, " ");
        if(arg == NULL)
        {
            printf("Usage: rm <path>\n");
        }
        FRESULT res = f_unlink(arg);
        if(res)
        {
            printf("Error removing file\n");
        }
    }else if(strcmp(linePtr,"umnt") == 0)
    {
        char *arg = strtok(NULL, " ");
        if(arg == NULL)
        {
            printf("Usage: umnt <path>\n");
        }
        FRESULT res = f_unmount(arg);
        if(res)
        {
            printf("Error unmounting drive %d\n",res);
        }
        return;
    }else if(strcmp(linePtr, "mv") == 0)
    {
        printf("\n");
        char *arg = strtok(NULL, " ");
        char *arg1 = strtok(NULL, " ");
        if(arg == NULL || arg1 == NULL)
        {
            printf("Usage: mv <old path> <new path>\n");
        }
        FRESULT res = f_rename(arg,arg1);
        if(res)
        {
            printf("Fs error %d",res);
        }
    }else
    {
        printf("\n");
        char prgPath[256];
        strcpy(prgPath,_BIN_PATH);
        strcat(prgPath,linePtr);
        if(linePtr[0] == '.') //Is relative?
        {
            run_file(linePtr);
            
        }else{
            run_file(prgPath);
        }
        printf("\n");
    
    }

}

int main(int argc, char *argv[], char *environp[]) {

    printf("Kernel starting ...\n");
    if(kernel_start() != 0)
    {
        while(1); //Oh no
    }
    int i = 0;
    char line[81];
    char print_buf[81];
    int history_cur = 0;
    printf("%s",DEFAULT_PROMPT);
    fflush(stdout);
    memset(print_buf,' ',80);
    print_buf[79] = 0;
    while(1)
    {
    
    
        char ch = syscall_trap0(8L,0L,0L);
        
        if(i == 79){printf("\nToo long\n");i = 0;}
        
            
        
        if(ch == '\n')
        {
            ch = '\n';
            line[i] = ' ';
            i++;
            line[i] = 0;
            for (int y = 0; y < strlen(line); y++) {
                if (line[y] != ' ')
                {
                    history_cur = 0;
                    history_add(line);    
                    break;
                }
            }
            
            parse_line(line);
            i = 0;
            //printf("%s",DEFAULT_PROMPT);
            //fflush(stdout);
        }else if((uint8_t)ch == KYB_ARROW_UP || (uint8_t)ch == KYB_ARROW_DOWN){
            char* str;
            if((uint8_t)ch == KYB_ARROW_UP)
            {
                
                str = history_get(history_cur);
                history_cur += str == NULL ? 0 : 1;
            }else{
                history_cur -= history_cur == 0 ? 0 : 1;
                str = history_get(history_cur);
                
                
            }
            if (str != NULL){
                memset(line,' ',79);
                line[79] = 0; //Clear line buffer
                //printf("\r%s",line); //Clear screen line
                //fflush(stdout);

                strcpy(line,str);
                i = strlen(line)-1;
                line[i] = 0;
                //printf("\r%s%s",DEFAULT_PROMPT,line);
                //fflush(stdout);
            }
        }else if(ch == 0x1B /*ESC*/){
            memset(line,' ',79);
            line[79] = 0; //Clear line buffer
            //printf("\r%s%s\r",DEFAULT_PROMPT,line); //Clear screen line
            //fflush(stdout);
            i = 0;
            history_cur = 0;
            line[0] = 0;
        }else{
            line[i] = ch;
            i++;
            line[i] = 0;
            //printf("\r%s%s",DEFAULT_PROMPT,line);
            //fflush(stdout);
        }
        line[i] = 0;
        
    
        printf("\r%s\r%s%s",print_buf,DEFAULT_PROMPT,line);
        fflush(stdout);
        
        
    }
    return 0;
}
