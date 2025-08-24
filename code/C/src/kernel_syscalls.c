#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/reent.h>  // For struct _reent
#include <fcntl.h>
#include <string.h>
#include <kernel_syscalls.h>
#include <ff.h>
#include <stddef.h>
#include <sys/unistd.h>  // For ssize_t etc.
#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/errno.h>
extern int fatfs_to_errno(FRESULT res);
//extern defines
extern int _open_r(struct _reent *, const char *, int, int);
extern int _close_r(struct _reent *, int);
extern int _read_r(struct _reent *, int, void *, size_t);
extern int _write_r(struct _reent *, int, const void *, size_t);
extern int _lseek_r(struct _reent *, int, int, int);
extern int _fstat_r(struct _reent *, int, void *);
extern int _isatty_r(struct _reent *, int);
extern int _stat_r(struct _reent *, const char *, void *);
extern int _gettimeofday_r(struct _reent *r, void *, void *);

//other FS stuff
int _chdir_r(struct _reent *r, const char *str)
{
    FRESULT res = f_chdir(str);
    if(res == FR_OK) //if ok
    {
        setenv("PWD",str,1);
    }
    r->_errno = fatfs_to_errno(res);
    return r->_errno;

}
char* _getcwd_r(struct _reent *r, char *str, size_t len)
{
    
    if(!len)
    {
        r->_errno = EINVAL;
        return NULL;
    }
    if(strlen(getenv("PWD")) > len)
    {
        r->_errno = ERANGE;
        return NULL;
    }
    return getenv("PWD");
    
    
}

/* Prototype of your trap handler - must be a function with 
   proper 68010 assembly prologue to handle the trap */

extern void trap1_handler(void);



static inline uintptr_t read_vbr(void) {
    uintptr_t vbr;
    __asm__ volatile (
        "movec %%vbr,%0"
        : "=r"(vbr)
    );
    return vbr;
}

void trap1_init(void) {
    uintptr_t vbr = read_vbr();

    /* Vector #33 (trap #1) offset in vector table */
    uintptr_t *trap1_vector = (uintptr_t *)(vbr + 4 * (32 + 1));

    /* Write address of trap handler */
    *trap1_vector = (uintptr_t)trap1_handler;

    /* Optionally, flush caches or invalidate instruction cache here if needed */

}


//dirent


// Adapted opendir, readdir, closedir

DIR *_opendir_r(struct _reent *r, const char *path) {
    r->_errno = ENOMEM;
    DIR *d = malloc(sizeof(DIR));
    if (!d) return NULL;
    FRESULT res = f_opendir(&d->fatfs_dir, path);
    if (res != FR_OK) {
        free(d);
        r->_errno = fatfs_to_errno(res);
        return NULL;
    }
    r->_errno = 0; //OK
    d->first = 1;
    return d;
}

struct dirent *_readdir_r(struct _reent *r, DIR *d) {
    static struct dirent entry;
    FRESULT res;
    r->_errno = 0;
    if (d->first) {
        res = f_readdir(&d->fatfs_dir, &d->finfo); // first call
        d->first = 0;
    } else {
        res = f_readdir(&d->fatfs_dir, &d->finfo);
    }
    if (res != FR_OK){
        r->_errno = fatfs_to_errno(res);
        return NULL;
    }else if(d->finfo.fname[0] == 0) {
        return NULL; // End of dir
    }
    strncpy(entry.d_name, d->finfo.fname, sizeof(entry.d_name));
    entry.d_name[sizeof(entry.d_name)-1] = 0;
    
    return &entry;
}

int _closedir_r(struct _reent *r, DIR *d) {
    r->_errno = fatfs_to_errno( f_closedir(&d->fatfs_dir));
    free(d);
    if(r->_errno)
    {
        return -1;
    }
    return 0;
}


int trap1_dispatch(void) {
    int syscall_no, arg1, arg2, arg3;
    struct _reent *r;
    int ret = -1;

    __asm__ volatile (
        "move.l %%d0, %0\n\t"
        "move.l %%d1, %1\n\t"
        "move.l %%d2, %2\n\t"
        "move.l %%d3, %3\n\t"
        "move.l %%d4, %4\n\t"
        : "=r"(syscall_no), "=r"(arg1), "=r"(arg2), "=r"(arg3), "=r"(r)
        :
        : "d0", "d1", "d2", "d3", "d4", "memory"
    );

    switch (syscall_no) {
        case SYSCALL_OPEN:
            ret = _open_r(r, (const char *)arg1, arg2, arg3);
            break;
        case SYSCALL_CLOSE:
            ret = _close_r(r, arg1);
            break;
        case SYSCALL_READ:
            ret = _read_r(r, arg1, (void *)arg2, arg3);
            break;
        case SYSCALL_WRITE:
            ret = _write_r(r, arg1, (const void *)arg2, arg3);
            break;
        case SYSCALL_LSEEK:
            ret = _lseek_r(r, arg1, arg2, arg3);
            break;
        case SYSCALL_FSTAT:
            ret = _fstat_r(r, arg1, (void *)arg2);
            break;
        case SYSCALL_ISTTY:
            ret = _isatty_r(r, arg1);
            break;
        case SYSCALL_STAT:
            ret = _stat_r(r, (const char *)arg1, (void *)arg2);
            break;
        case SYSCALL_TIME:
            ret = _gettimeofday_r(r, (void *)arg1, (void*)arg2);
            break;
        case SYSCALL_CWD:
            ret = (uintptr_t)_getcwd_r(r, (char*)arg1, arg2); //Returns string in arg3
            break;
        case SYSCALL_CD:
            ret = _chdir_r(r, (const char*)arg1);
            break;
        case SYSCALL_OPENDIR:
            ret = (uintptr_t)_opendir_r(r, (const char*)arg1);
            break;
        case SYSCALL_CLOSEDIR:
            ret = _closedir_r(r, (DIR*)arg1);
            break;
        case SYSCALL_READDIR:
            ret = (uintptr_t)_readdir_r(r, (DIR*)arg1);
            break;
        default:
            ret = -1; // Unknown syscall
            break;
    }

    return ret;
}

static inline int syscall_trap1(uintptr_t r, int callno, uintptr_t arg1, uintptr_t arg2, uintptr_t arg3)
{
    int ret;
    //printf("Fname add sent:\n %lx",arg1);
    __asm__ volatile (
        "move.l %1, %%d0\n\t"
        "move.l %2, %%d1\n\t"
        "move.l %3, %%d2\n\t"
        "move.l %4, %%d3\n\t"
        "move.l %5, %%d4\n\t"
        "trap #1\n\t"
        "move.l %%d0, %0\n\t"
        : "=r"(ret)
        : "r"(callno), "r"(arg1), "r"(arg2), "r"(arg3), "r"(r)
        : "d0", "d1", "d2", "d3", "d4", "memory"
    );
    //printf("ret got= %d\n",ret);
    return ret;
}

