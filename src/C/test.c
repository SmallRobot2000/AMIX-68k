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

#define PRG_MIN_ADD 0x180000
uint8_t * buffer;
PARTITION VolToPart[FF_VOLUMES] = {
        {0, 1},    /* "0:" ==> 1st partition in physical drive 0 */
        {0, 2}     /* "1:" ==> 2nd partition in physical drive 0 */
    };
LBA_t plist[] = {100, 0, 0};  /* Divide the drive to one full volume and one empty */

BYTE work[FF_MAX_SS];         /* Working buffer */

FATFS fs;
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

typedef int (*prog_main_t)(void);
int call_address(uint32_t add)
{
    prog_main_t prog_main = (prog_main_t)add;
    int result = prog_main();
    return result;
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
        char *end;
        
        if(arg == NULL)
        {
            printf("Usage: run <address>\n");
            return;
        }
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
        printf("Running at 0x%08lx\n",add);
        printf("Return exit code: 0x%04x\n", call_address(add));
        
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
            printf("Usage: rm <path>\n");
        }
        FRESULT res = f_unmount(arg);
        if(res)
        {
            printf("Error unmounting drive %d\n",res);
        }
    }else
    {
        printf("\n");
    }

}
int main(void) {
    double c = 0.071264;
    int i    = 63000;
    buffer = malloc(512);
    char *str1 = "ooa str!";

    //scanf(" %c",&ch);
    uint8_t *buffer = malloc(2000);
    memcpy(buffer,str1,strlen(str1) + 1);
    printf("Haljo %f\n", c);
    printf("123dasdas %d\n", i);
    printf("Hej there\n");
    printf("test \niiii \nm\n%s",buffer);
    i = 0;
    char line[80];
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
            parse_line(line);
            i = 0;
        }else if(ch == 8){ //BS
            i --;
            sys_print_screen(ch);
        }else{
            line[i] = ch;
            sys_print_screen(line[i]);
            i++;
        }
        
        
    }
    return 0;
}
