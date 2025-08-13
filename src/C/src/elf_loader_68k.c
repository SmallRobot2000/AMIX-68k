/* elf_loader_68k.c – optimized loader with local buffer */

#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <elf.h>
#include "ff.h"      // FatFS
#include <fcntl.h>
#include <unistd.h>
#include <stdbool.h>
#include <kernel.h>

#define BIGBUF_SIZE   (128 * 1024)
    /* Buffer for entire file */
    uint8_t bigbuf[BIGBUF_SIZE];
uint32_t load_elf(const char *path, void *base_addr) {

    
    FIL fil;
    
    /* 1) Open file and check size */
    if (f_open(&fil, path, FA_READ) != FR_OK) return (uint32_t)-1;
    
    FSIZE_t fsize = f_size(&fil);
    if (fsize > BIGBUF_SIZE) {
        f_close(&fil);
        return (uint32_t)-1;
    }
    
    /* 2) Read entire file */
    UINT br;
    if (f_read(&fil, bigbuf, fsize, &br) != FR_OK || br != fsize) {
        f_close(&fil);
        return (uint32_t)-1;
    }
    f_close(&fil);
    /* 3) Fast ELF validation */
    Elf32_Ehdr *ehdr = (Elf32_Ehdr*)bigbuf;
    /* Compare the first 4 magic bytes */
    if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0)
        return (uint32_t)-1;

    /* Check class is 32-bit */
    if (ehdr->e_ident[EI_CLASS] != ELFCLASS32)
        return (uint32_t)-1;


    /* 4) Load PT_LOAD segments */
    uint8_t *phdrs_base = bigbuf + ehdr->e_phoff;
    for (int i = 0; i < ehdr->e_phnum; i++) {
        Elf32_Phdr *ph = (Elf32_Phdr*)(phdrs_base + i * ehdr->e_phentsize);
        if (ph->p_type != PT_LOAD) continue;

        uint8_t *dest = (uint8_t*)base_addr + ph->p_vaddr;
        memcpy(dest, bigbuf + ph->p_offset, ph->p_filesz);
        
        /* Zero BSS if needed */
        uint32_t bss_size = ph->p_memsz - ph->p_filesz;
        if (bss_size) memset(dest + ph->p_filesz, 0, bss_size);
    }

    /* 5) Direct section header access */
    if (ehdr->e_shnum > 256) return (uint32_t)-1;
    
    Elf32_Shdr *shdrs = (Elf32_Shdr*)(bigbuf + ehdr->e_shoff);

    /* 6) Find symbol table */
    Elf32_Sym *symtab = NULL;
    uint32_t symcnt = 0;
    
    for (int i = 0; i < ehdr->e_shnum; i++) {
        if (shdrs[i].sh_type == SHT_SYMTAB) {
            symtab = (Elf32_Sym*)(bigbuf + shdrs[i].sh_offset);
            symcnt = shdrs[i].sh_size / sizeof(Elf32_Sym);
            break;
        }
    }
    if (!symtab) return (uint32_t)-1;

    /* 7) Process relocations */
    uint32_t base = (uint32_t)base_addr;
    
    for (int i = 0; i < ehdr->e_shnum; i++) {
        uint32_t t = shdrs[i].sh_type;
        if (t != SHT_REL && t != SHT_RELA) continue;
        
        uint32_t ents = shdrs[i].sh_size / shdrs[i].sh_entsize;
        void *relbase = bigbuf + shdrs[i].sh_offset;

        if (t == SHT_RELA) {
            Elf32_Rela *rela = (Elf32_Rela*)relbase;
            for (uint32_t r = 0; r < ents; r++, rela++) {
                uint32_t symi = ELF32_R_SYM(rela->r_info);
                if (symi >= symcnt) continue;
                
                uint32_t S = symtab[symi].st_value;
                if (symtab[symi].st_shndx != SHN_ABS && 
                    symtab[symi].st_shndx != SHN_COMMON) {
                    S += base;
                }
                
                uint32_t *where = (uint32_t*)(base + rela->r_offset);
                uint32_t type = ELF32_R_TYPE(rela->r_info);
                
                if (type == R_68K_32) {
                    *where = S + rela->r_addend;
                } else if (type == R_68K_PC32) {
                    *where = S + rela->r_addend - (base + rela->r_offset);
                }
            }
        } else {
            Elf32_Rel *rel = (Elf32_Rel*)relbase;
            for (uint32_t r = 0; r < ents; r++, rel++) {
                uint32_t symi = ELF32_R_SYM(rel->r_info);
                if (symi >= symcnt) continue;
                
                uint32_t S = symtab[symi].st_value;
                if (symtab[symi].st_shndx != SHN_ABS && 
                    symtab[symi].st_shndx != SHN_COMMON) {
                    S += base;
                }
                
                uint32_t *where = (uint32_t*)(base + rel->r_offset);
                uint32_t A = *where;
                uint32_t type = ELF32_R_TYPE(rel->r_info);
                
                if (type == R_68K_32) {
                    *where = S + A;
                } else if (type == R_68K_PC32) {
                    *where = S + A - (base + rel->r_offset);
                }
            }
        }
    }

    return base + ehdr->e_entry;
}



uint32_t load_and_file_elf(const char *path, void *base_addr, const char *bin_path) {
    FIL fil;
    
    /* 1) Open file and check size */
    if (f_open(&fil, path, FA_READ) != FR_OK) return (uint32_t)-1;
    
    FSIZE_t fsize = f_size(&fil);
    if (fsize > BIGBUF_SIZE) {
        f_close(&fil);
        return (uint32_t)-1;
    }
    
    /* 2) Read entire file */
    UINT br;
    if (f_read(&fil, bigbuf, fsize, &br) != FR_OK || br != fsize) {
        f_close(&fil);
        return (uint32_t)-1;
    }
    f_close(&fil);
    
    /* 3) Fast ELF validation */
    Elf32_Ehdr *ehdr = (Elf32_Ehdr*)bigbuf;
    if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0)
        return (uint32_t)-1;

    if (ehdr->e_ident[EI_CLASS] != ELFCLASS32)
        return (uint32_t)-1;

    /* 4) Calculate memory extent for binary output */
    uint32_t lowest = 0xffffffff, highest = 0;
    uint8_t *phdrs_base = bigbuf + ehdr->e_phoff;
    
    for (int i = 0; i < ehdr->e_phnum; i++) {
        Elf32_Phdr *ph = (Elf32_Phdr*)(phdrs_base + i * ehdr->e_phentsize);
        if (ph->p_type != PT_LOAD) continue;
        
        uint32_t seg_start = ph->p_vaddr;
        uint32_t seg_end = ph->p_vaddr + ph->p_memsz;
        if (seg_start < lowest) lowest = seg_start;
        if (seg_end > highest) highest = seg_end;
    }
    
    uint32_t binary_size = highest - lowest;
    
    /* 5) Load PT_LOAD segments into memory */
    for (int i = 0; i < ehdr->e_phnum; i++) {
        Elf32_Phdr *ph = (Elf32_Phdr*)(phdrs_base + i * ehdr->e_phentsize);
        if (ph->p_type != PT_LOAD) continue;

        uint8_t *dest = (uint8_t*)base_addr + ph->p_vaddr;
        memcpy(dest, bigbuf + ph->p_offset, ph->p_filesz);
        
        /* Zero BSS if needed */
        uint32_t bss_size = ph->p_memsz - ph->p_filesz;
        if (bss_size) memset(dest + ph->p_filesz, 0, bss_size);
    }

    /* 6) Direct section header access */
    if (ehdr->e_shnum > 256) return (uint32_t)-1;
    
    Elf32_Shdr *shdrs = (Elf32_Shdr*)(bigbuf + ehdr->e_shoff);

    /* 7) Find symbol table */
    Elf32_Sym *symtab = NULL;
    uint32_t symcnt = 0;
    
    for (int i = 0; i < ehdr->e_shnum; i++) {
        if (shdrs[i].sh_type == SHT_SYMTAB) {
            symtab = (Elf32_Sym*)(bigbuf + shdrs[i].sh_offset);
            symcnt = shdrs[i].sh_size / sizeof(Elf32_Sym);
            break;
        }
    }
    if (!symtab) return (uint32_t)-1;

    /* 8) Process relocations */
    uint32_t base = (uint32_t)base_addr;
    
    for (int i = 0; i < ehdr->e_shnum; i++) {
        uint32_t t = shdrs[i].sh_type;
        if (t != SHT_REL && t != SHT_RELA) continue;
        
        uint32_t ents = shdrs[i].sh_size / shdrs[i].sh_entsize;
        void *relbase = bigbuf + shdrs[i].sh_offset;

        if (t == SHT_RELA) {
            Elf32_Rela *rela = (Elf32_Rela*)relbase;
            for (uint32_t r = 0; r < ents; r++, rela++) {
                uint32_t symi = ELF32_R_SYM(rela->r_info);
                if (symi >= symcnt) continue;
                
                uint32_t S = symtab[symi].st_value;
                if (symtab[symi].st_shndx != SHN_ABS && 
                    symtab[symi].st_shndx != SHN_COMMON) {
                    S += base;
                }
                
                uint32_t *where = (uint32_t*)(base + rela->r_offset);
                uint32_t type = ELF32_R_TYPE(rela->r_info);
                
                if (type == R_68K_32) {
                    *where = S + rela->r_addend;
                } else if (type == R_68K_PC32) {
                    *where = S + rela->r_addend - (base + rela->r_offset);
                }
            }
        } else {
            Elf32_Rel *rel = (Elf32_Rel*)relbase;
            for (uint32_t r = 0; r < ents; r++, rel++) {
                uint32_t symi = ELF32_R_SYM(rel->r_info);
                if (symi >= symcnt) continue;
                
                uint32_t S = symtab[symi].st_value;
                if (symtab[symi].st_shndx != SHN_ABS && 
                    symtab[symi].st_shndx != SHN_COMMON) {
                    S += base;
                }
                
                uint32_t *where = (uint32_t*)(base + rel->r_offset);
                uint32_t A = *where;
                uint32_t type = ELF32_R_TYPE(rel->r_info);
                
                if (type == R_68K_32) {
                    *where = S + A;
                } else if (type == R_68K_PC32) {
                    *where = S + A - (base + rel->r_offset);
                }
            }
        }
    }

    /* 9) Save the loaded binary to specified .bin file */
    if (bin_path != NULL) {
        FIL binfile;
        if (f_open(&binfile, bin_path, FA_CREATE_ALWAYS | FA_WRITE) == FR_OK) {
            UINT bw;
            uint8_t *binary_start = (uint8_t*)base_addr + lowest;
            
            if (f_write(&binfile, binary_start, binary_size, &bw) == FR_OK && bw == binary_size) {
                f_sync(&binfile);  /* Ensure data is written to disk */
            }
            f_close(&binfile);
        }
    }

    return base + ehdr->e_entry;
}


//extern char* environ[];
typedef int (*prog_main_t)(int argc, char *argv[], char *environ[]);
int call_address(uint32_t add)
{
    prog_main_t prog_main = (prog_main_t)add;
    char *argv[] = {"My name! WHAT IS MY NAME???",NULL};
    int argc = sizeof(argv) / sizeof(argv[0]) - 1;  // Count elements, subtract 1 for NULL terminator
    int result = prog_main( argc, argv, environ);
    return result;
}


/**
 * is_elf_file – Return true if the given file is a valid ELF file.
 * @path: filesystem path of the candidate file.
 *
 * Opens the file, reads the ELF header magic bytes, and checks:
 *   1) e_ident[EI_MAG0..EI_MAG3] == 0x7F 'E' 'L' 'F'
 *   2) e_ident[EI_CLASS] is ELFCLASS32 or ELFCLASS64
 *   3) e_ident[EI_DATA] is ELFDATA2LSB or ELFDATA2MSB
 *
 * Returns: true if file has correct ELF magic and class/data fields, else false.
 */
bool is_elf_file(const char *path)
{
    FIL fil;
    FRESULT res;
    UINT br;

    /* 1) Open the file for reading */
    res = f_open(&fil, path, FA_READ);
    if (res != FR_OK) {
        return false;
    }

    /* 2) Read exactly EI_NIDENT bytes (ELF e_ident) */
    unsigned char ident[EI_NIDENT];
    res = f_read(&fil, ident, EI_NIDENT, &br);
    f_close(&fil);
    if (res != FR_OK || br != EI_NIDENT) {
        return false;
    }

    /* 3) Verify ELF magic: 0x7F 'E' 'L' 'F' */
    if (ident[EI_MAG0] != ELFMAG0 ||
        ident[EI_MAG1] != ELFMAG1 ||
        ident[EI_MAG2] != ELFMAG2 ||
        ident[EI_MAG3] != ELFMAG3) {
        return false;
    }

    /* 4) Verify ELF class: 32-bit or 64-bit */
    if (ident[EI_CLASS] != ELFCLASS32 &&
        ident[EI_CLASS] != ELFCLASS64) {
        return false;
    }

    /* 5) Verify data encoding: little or big endian */
    if (ident[EI_DATA] != ELFDATA2LSB &&
        ident[EI_DATA] != ELFDATA2MSB) {
        return false;
    }

    return true;
}

char resbuff[256];
int run_file(const char* path)
{
    int is_elf = is_elf_file(path);
    if(is_elf == true)
    {
        uint32_t res = load_elf(path, (void *)_WORKING_PROGRAM_ADD);
        if(res < 0 || res != _WORKING_PROGRAM_ADD)
        {
            perror("Loading file failed");
            return -1;
        
        }
        int cres = call_address(_WORKING_PROGRAM_ADD);
        itoa(cres, resbuff, 256);
        setenv("?",resbuff, 1); //set error return
        
        return 0;
    }else{
        FIL fd;
        FRESULT res = f_open(&fd, path, FA_READ);
        if(res)
        {
            printf("Error opening file");
            return -1;
        }
        uint br;
        res = f_read(&fd, (void *)_WORKING_PROGRAM_ADD, _WORKING_PROGRAM_MAX_SIZE, &br);
        if(res != FR_OK)
        {
            printf("Error reading file %d",res);
        }
        if(br == _WORKING_PROGRAM_MAX_SIZE)
        {
            printf("Error file too big");
        }
        int cres = call_address(_WORKING_PROGRAM_ADD);
        itoa(cres, resbuff, 256);
        setenv("?",resbuff, 1); //set error return
        return 0;
    }
}