/* elf_loader_68k.c – loader using a dynamically allocated 128 KiB buffer */

#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <elf.h>
#include "ff.h"      // FatFS

#define BIGBUF_SIZE   (128 * 1024)
#define MAX_SHDR      128

uint32_t load_elf(const char *path, void *base_addr) {
    FIL fil;
    FRESULT res;
    /* 1) Open file and check size */
    if ((res = f_open(&fil, path, FA_READ)) != FR_OK) {
        printf("Error: open '%s' (FatFS %d)\n", path, res);
        return (uint32_t)-1;
    }
    FSIZE_t fsize = f_size(&fil);
    if (fsize > BIGBUF_SIZE) {
        printf("Error: ELF too large (%lu bytes > %u)\n",
               (unsigned long)fsize, BIGBUF_SIZE);
        f_close(&fil);
        return (uint32_t)-1;
    }

    /* 2) Allocate a big buffer for the entire file */
    uint8_t *bigbuf = malloc(fsize);
    if (!bigbuf) {
        printf("Error: malloc %lu bytes\n", (unsigned long)fsize);
        f_close(&fil);
        return (uint32_t)-1;
    }

    /* 3) Read entire ELF into bigbuf */
    UINT br;
    if (f_read(&fil, bigbuf, fsize, &br) != FR_OK || br != fsize) {
        printf("Error: read entire ELF\n");
        free(bigbuf);
        f_close(&fil);
        return (uint32_t)-1;
    }
    f_close(&fil);

    /* 4) Validate ELF header */
    Elf32_Ehdr *ehdr = (Elf32_Ehdr*)bigbuf;
    if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0 ||
        ehdr->e_ident[EI_CLASS] != ELFCLASS32) {
        printf("Error: invalid ELF header\n");
        free(bigbuf);
        return (uint32_t)-1;
    }

    /* 5) Load PT_LOAD segments */
    for (int i = 0; i < ehdr->e_phnum; i++) {
        Elf32_Phdr *ph = (Elf32_Phdr*)(bigbuf +
            ehdr->e_phoff + i * ehdr->e_phentsize);
        if (ph->p_type != PT_LOAD) continue;

        /* copy file data */
        memcpy((uint8_t*)base_addr + ph->p_vaddr,
               bigbuf + ph->p_offset,
               ph->p_filesz);
        /* zero .bss */
        if (ph->p_memsz > ph->p_filesz) {
            memset((uint8_t*)base_addr + ph->p_vaddr + ph->p_filesz,
                   0, ph->p_memsz - ph->p_filesz);
        }
    }

    /* 6) Read section headers */
    if (ehdr->e_shnum > MAX_SHDR) {
        printf("Error: too many sections (%u)\n", ehdr->e_shnum);
        free(bigbuf);
        return (uint32_t)-1;
    }
    Elf32_Shdr shdrs[MAX_SHDR];
    memcpy(shdrs,
           bigbuf + ehdr->e_shoff,
           ehdr->e_shnum * ehdr->e_shentsize);

    /* 7) Locate symtab and strtab */
    Elf32_Sym *symtab = NULL;
    uint32_t symcnt = 0;
    char *strtab = NULL;
    for (int i = 0; i < ehdr->e_shnum; i++) {
        if (shdrs[i].sh_type == SHT_SYMTAB) {
            symtab = (Elf32_Sym*)(bigbuf + shdrs[i].sh_offset);
            symcnt = shdrs[i].sh_size / shdrs[i].sh_entsize;
            Elf32_Shdr *strsh = &shdrs[shdrs[i].sh_link];
            strtab = (char*)(bigbuf + strsh->sh_offset);
            break;
        }
    }
    if (!symtab) {
        printf("Error: no symbol table\n");
        free(bigbuf);
        return (uint32_t)-1;
    }

    /* 8) Apply relocations */
    for (int i = 0; i < ehdr->e_shnum; i++) {
        uint32_t t = shdrs[i].sh_type;
        if (t != SHT_REL && t != SHT_RELA) continue;
        uint32_t ents = shdrs[i].sh_size / shdrs[i].sh_entsize;
        uint8_t *relbase = bigbuf + shdrs[i].sh_offset;

        for (uint32_t r = 0; r < ents; r++) {
            Elf32_Rela rela;
            if (t == SHT_RELA) {
                rela = ((Elf32_Rela*)relbase)[r];
            } else {
                Elf32_Rel rel = ((Elf32_Rel*)relbase)[r];
                rela.r_offset = rel.r_offset;
                rela.r_info   = rel.r_info;
                rela.r_addend = *(uint32_t*)((uint8_t*)base_addr + rel.r_offset);
            }

            uint32_t symi = ELF32_R_SYM(rela.r_info);
            if (symi >= symcnt) continue;
            Elf32_Sym *sym = &symtab[symi];
            uint32_t orig = sym->st_value;
            uint32_t S = (sym->st_shndx != SHN_ABS && sym->st_shndx != SHN_COMMON)
                         ? orig + (uint32_t)base_addr
                         : orig;
            uint32_t P = (uint32_t)base_addr + rela.r_offset;
            uint32_t A = rela.r_addend;
            uint32_t *where = (uint32_t*)((uint8_t*)base_addr + rela.r_offset);

            switch (ELF32_R_TYPE(rela.r_info)) {
                case R_68K_32:   *where = S + A;      break;
                case R_68K_PC32: *where = S + A - P;  break;
                default: /* skip */                  break;
            }
        }
    }

    uint32_t entry = (uint32_t)base_addr + ehdr->e_entry;
    free(bigbuf);
    return entry;
}
