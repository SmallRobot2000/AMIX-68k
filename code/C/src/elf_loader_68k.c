/* elf_loader_68k.c – optimized loader with local buffer */

#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <elf.h>
#include <ext4.h>
//#include <fcntl.h>
#include <unistd.h>
#include <stdbool.h>
#include <kernel.h>
#include <process.h>
#include <debug.h>
extern uint32_t _WORKING_PROGRAM_ADD;
extern uint32_t _WORKING_PROGRAM_MAX_SIZE;
    /* Buffer for entire file */
extern uint8_t *bigbuf;
uint32_t load_elf(const char *path, void *base_addr) {

    
    ext4_file fil;
     DBG_ELF_PRINTF("ELF file %s\n",path);
    /* 1) Open file and check size */
    if (ext4_fopen(&fil, path, "r") != EOK) return (uint32_t)-1;
    
    size_t fsize = ext4_fsize(&fil);
    DBG_ELF_PRINTF("ELF size %lu\n",fsize);
    if (fsize > _WORKING_PROGRAM_MAX_SIZE) {
        ext4_fclose(&fil);
        return (uint32_t)-1;
    }
    
    /* 2) Read entire file */
    size_t br;
     DBG_ELF_PRINTF("ELF reading file\nBIG BUF: %p",bigbuf);
    if (ext4_fread(&fil, bigbuf, fsize, &br) != EOK || br != fsize) {
        ext4_fclose(&fil);
        return (uint32_t)-1;
    }
    ext4_fclose(&fil);
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


__attribute__((optimize("O2"))) uint32_t load_elf_from_buffer(uint8_t *buf, void *base_addr) {

    
    uint8_t *bigbuf = buf;
     
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
    
    
    /* 1) Open file and check size */
    ext4_file fil;
    int fres =  ext4_fopen(&fil, path, "r");
    if (fres != EOK) 
    {
        errno = fres;
        perror("fopen");
        return (uint32_t)-1;
    }

    size_t fsize = ext4_fsize(&fil);
    if (fsize > _WORKING_PROGRAM_ADD) {
        ext4_fclose(&fil);
        return (uint32_t)-1;
    }
    
    /* 2) Read entire file */
    size_t br;
    fres = ext4_fread(&fil, bigbuf, fsize, &br);
    
    if (fres != EOK || br != fsize) {
        perror("Error opening file");
        ext4_fclose(&fil);
        return (uint32_t)-1;
    }
    ext4_fclose(&fil);
    
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
        ext4_file binfile;
        if (ext4_fopen(&binfile, bin_path, "w") != EOK) {
            size_t bw;
            uint8_t *binary_start = (uint8_t*)base_addr + lowest;
            
            if (ext4_fwrite(&binfile, binary_start, binary_size, &bw) != EOK || bw != binary_size)
            {
                printf("Error writing to file\n");
            }
            ext4_fclose(&binfile);
        }
    }

    return base + ehdr->e_entry;
}

char *custom_env[] = {
    "PATH=/bin",
    "MYVAR=myvalue",
    NULL
};
char**__environ = custom_env;
extern char **environ;
typedef int (*prog_main_t)(int argc, char *argv[], char *custom_env[]);
tcb_t *call_address(uint32_t add, char **argv, int argc)
{
    //prog_main_t prog_main = (prog_main_t)add;
    //char *argv[] = {"My name! WHAT IS MY NAME???",NULL};
    //int argc = sizeof(argv) / sizeof(argv[0]) - 1;  // Count elements, subtract 1 for NULL terminator
    //return prog_main( argc, argv, custom_env);
    return create_task((void*)add, argv, argc, environ);
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
    ext4_file fil;
    int res;
    size_t br;

    /* 1) Open the file for reading */
    res = ext4_fopen(&fil, path, "r");
    if (res != EOK) {
        return false;
    }

    /* 2) Read exactly EI_NIDENT bytes (ELF e_ident) */
    unsigned char ident[EI_NIDENT];
    res = ext4_fread(&fil, ident, EI_NIDENT, &br);
    ext4_fclose(&fil);
    if (res != EOK || br != EI_NIDENT) {
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

bool is_elf_from_buf(uint8_t *buf)
{

  


    /* 2) Read exactly EI_NIDENT bytes (ELF e_ident) */
    unsigned char *ident;
    
    ident = buf;

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
int run_file(const char* path, char **argv, int argc) //sets $?
{
    DBG_ELF_PRINTF("RUNNING FILE: %s\n",path);
    ext4_file fil;
    int ret = ext4_fopen(&fil, path, "r");
    if(ret != 0)
    {
        errno = ret;
        perror("fopen");
        return -1;
    }
    size_t br;
    size_t size = ext4_fsize(&fil);
    if(size > _WORKING_PROGRAM_MAX_SIZE)
    {
        printf("File too large!\n");
        ext4_fclose(&fil);
        return -1;
    }

    ret = ext4_fread(&fil, bigbuf, size ,&br);
    if(ret != 0 || br != size)
    {
        errno = ret;
        perror("fread");
        ext4_fclose(&fil);
        return -1;
    }
    
    int is_elf = is_elf_from_buf(bigbuf);
    DBG_ELF_PRINTF("IS ELF: %d\n",is_elf);
    if(is_elf == true)
    {
        
        //uint32_t res = load_elf(path, (void *)_WORKING_PROGRAM_ADD);
        uint32_t res = load_elf_from_buffer(bigbuf, (void *)_WORKING_PROGRAM_ADD);
        DBG_ELF_PRINTF("Done loading\n");
        if(res < 0 || res != _WORKING_PROGRAM_ADD)
        {
            printf("Loading file failed %ld\n",res);
            return -1;
        
        }
        tcb_t *task = call_address(_WORKING_PROGRAM_ADD, argv, argc);
        wait_pid(task->pid);
        return 0;
    }else{
        printf("File type not suported, plese use ELF file\n");
        return -1;
    }
    ret = ext4_fclose(&fil);
    if(ret != 0)
    {
        errno = ret;
        perror("fclose");
    }
    return 0;
}