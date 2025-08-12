/* elf_loader_68k.c – optimized loader with local buffer */

#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <elf.h>
#include "ff.h"      // FatFS

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
