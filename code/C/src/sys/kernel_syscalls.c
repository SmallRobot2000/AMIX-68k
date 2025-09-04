#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/reent.h>  // For struct _reent
//#include <fcntl.h>
#include <string.h>
#include <kernel_syscalls.h>
#include <fs/ext4.h>
#include <stddef.h>
#include <sys/unistd.h>  // For ssize_t etc.
#include <sys/types.h>
//#include <sys/fcntl.h>
#include <sys/errno.h>
#include <process.h>

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
extern int _unlink_r(struct _reent *r, const char *path);
// Unlink (delete) file syscall replacement for newlib with FATfs

int chek_path_dir(const char* path)
{
    if(path == NULL)
    {
        return -1;
    }
    return 0;
}

int chek_path_file(const char* path)
{
    if(path == NULL)
    {
        return -1;
    }
    return 0;
}

__attribute__((optimize("O0"))) char* format_path_abs(char* path, char* ret_path)
{
    

    if(path[0] != '/')
        return NULL;
    
    char *fpath = malloc(256);
    char *fpath_fin = malloc(256);

    strcpy(fpath, path);
        
    char *path_part;
    if(!strchr(fpath, '/'))
    {
        path_part = fpath; 
    }else{
        path_part = strtok(fpath, "/");
    }
    
    strcpy(fpath_fin, "/");

    for(;;)
    {
        if(!strcmp(path_part, "")) //for a//b -> a/b
            goto for_next;
        
        if(!strcmp(path_part, ".")) //reset to cwd
        {
            goto for_next;
        }
        
        if(!strcmp(path_part, "..")) //set to last cwd and update cwd
        {

            //if(fpath_fin[strlen(fpath_cwd)-1] == '/' && strcmp(fpath_fin, "/") != 0)
            //    fpath_cwd[strlen(fpath_cwd)-1] = 0; //remove last / if not in root
                
            
            //printf("Fin after 1 .. %s\n",fpath_fin);
            char* pos = strrchr(fpath_fin, '/'); //make the dir before
            if(pos != NULL && pos == fpath_fin)
            {
                *(pos+sizeof(char)) = 0; //save '/'
            }else if(pos != NULL)
            {
                *pos = 0;
            }
                
            //printf("Fin after .. %s\n",fpath_fin);
            goto for_next;
        }
        
        
        if(fpath_fin[strlen(fpath_fin)-1] != '/')
            strcat(fpath_fin, "/");
            
        strcat(fpath_fin, path_part);
        for_next:
        //printf("Path part: %s Fin: %s\n",path_part,fpath_fin);
        if(!(path_part = strtok(NULL, "/")))
            break;
           
    }
    //Remove last / if not root
    while(strlen(fpath_fin) != 1 && fpath_fin[strlen(fpath_fin)-1] == '/')
        fpath_fin[strlen(fpath_fin)-1] = 0;
    
    
    strcpy(ret_path, fpath_fin);
    
    free(fpath_fin);
    free(fpath);
    return ret_path;
}
/*
@brief Translate relative to absolute path
@param path input path
@param ret_path pointer to char* buffer at least 256 bytes in size, not NULL
*/
__attribute__((optimize("O0"))) char* format_path(char *path, char *ret_path)
{
    if(path[0] == '/')
    {
        return format_path_abs(path, ret_path);
    }
    char *abs_path = malloc(256);
    sprintf(abs_path, "%s/%s", getenv("PWD"), path);
    ret_path = format_path_abs(abs_path, ret_path);
    free(abs_path);
    return ret_path;
}
//other FS stuff
int _chdir_r(struct _reent *r, const char *str)
{
    if(str != NULL) //if ok
    {
        char f_path[256];
        format_path((char*)str, f_path);
        if(_stat_r(NULL, f_path, NULL) == 0) //exists
        {
            setenv("PWD",f_path,1);
        }else{
            r->_errno = ENOENT;
        }
        
    }else{
        return EINVAL;
    }
    return EOK;

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
    char f_path[256];
    format_path((char*)path, f_path);

        
    r->_errno = EINVAL;
    if(chek_path_dir(f_path))
        return NULL;
    r->_errno = ENOMEM;
    DIR *d = malloc(sizeof(DIR));
    if (!d) return NULL;

    int res = ext4_dir_open(&d->dir, f_path);
    
    if (res != EOK) {
        free(d);
        r->_errno = res;
        return NULL;
    }
    r->_errno = 0; //OK
    d->first = 1;
    return d;
}

struct dirent *_readdir_r(struct _reent *r, DIR *d) {
    
    r->_errno = 0;
    struct dirent *dir_e = &d->dir_ent;   //POSIX enty in DIR
    dir_e->d_en = ext4_dir_entry_next(&d->dir); //FS entry in POSIX entry of DIR
    if(dir_e->d_en == NULL)
        return NULL;
    
    
    strncpy(dir_e->d_name, (const char *)dir_e->d_en->name , sizeof(dir_e->d_name));
    dir_e->d_ino = dir_e->d_en->inode;
    
    return dir_e;
}

int _closedir_r(struct _reent *r, DIR *d) {
    r->_errno = 0;
    if(d == NULL)
    {
        r->_errno = EINVAL;    
        return EINVAL;
    }
    r->_errno = ext4_dir_close(&d->dir);
    
    free(d);
    
    return r->_errno;
}
int _mkdir_r(struct _reent *r, const char *pathname, int mode) {
     //mode not used for now
    (void)mode; // suppress unused param warning
    char f_path[256];
    format_path((char*)pathname, f_path);
    if(chek_path_dir(f_path) != EOK)
    {
        r->_errno = EINVAL;
        return r->_errno;
    }
    

    // Create directory
    r->_errno = ext4_dir_mk(f_path);
    return r->_errno;
}



// Remove directory syscall replacement for newlib with lwext4
int _rmdir_r(struct _reent *r, const char *path) {
    char f_path[256];
    format_path((char*)path, f_path);
    
    if(chek_path_dir(f_path) != EOK)
    {
        r->_errno = EINVAL;
        return -1;
    }


    r->_errno = ext4_dir_rm(f_path);
    return r->_errno;
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
        case SYSCALL_MKDIR:
            ret = _mkdir_r(r, (const char*)arg1, arg2);
            break;
        case SYSCALL_RMDIR:
            ret = _rmdir_r(r, (const char*)arg1);
            break;
        case SYSCALL_UNLINK:
            ret = _unlink_r(r, (const char*)arg1);
            break;
        case SYSCALL_GETPID:
            r->_errno = 0;
            ret = cur_pid;
            break;
        case SYSCALL_KILLPID:
            ret = proc_kill_r(r, arg1);
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

