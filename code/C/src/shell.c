#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <malloc.h>
#include <sys_amix.h>
#include <ext4.h>
#include <ext4_fs.h>
#include <stdint.h>
#include <xmodem.h>
#include <elf_loader.h>
#include <kernel.h>
#include <history.h>
#include <stdbool.h>
#include <shell.h>
#define PRG_MIN_ADD 0x180000
#define DEFAULT_PROMPT "$ "


//Loop stuff
int i = 0;
char line[81];
char print_buf[81];
int history_cur = 0;




#define MAX_LINE 1024
#define MAX_TOKENS 100

typedef enum {
    TOKEN_WORD,
    TOKEN_PIPE,
    TOKEN_REDIRECT_IN,
    TOKEN_REDIRECT_OUT,
    TOKEN_REDIRECT_APPEND,
    TOKEN_SEMICOLON,
    TOKEN_AMPERSAND,
    TOKEN_EOF
} token_type_t;

typedef struct {
    token_type_t type;
    char *value;
} token_t;

typedef struct {
    char **argv;
    int argc;
    char *input_file;
    char *output_file;
    int append_mode;
    int background;
} command_t;


int call_command(command_t *cmd)
{
    char* path = cmd->argv[0];
    
    
    if(strchr(path, '/')) //Full or relative path
    {
        return run_file(path, cmd->argv, cmd->argc);
    }else{ //From /bin
        char* fullPath = malloc(256);
        memset(fullPath, 0, strlen(_BIN_PATH)+strlen(path)+2);

        strcat(fullPath, _BIN_PATH);
        strcat(fullPath, "/");
        strcat(fullPath, path);
        //printf("DEBUG shell call bin file %s\n", fullPath);
        int ret = run_file(fullPath, cmd->argv, cmd->argc);
        free(fullPath);
        return ret;
    }   
    return 0;
}





void free_tokens(token_t *tokens, int n) {
    for (int i = 0; i < n; i++) free(tokens[i].value);
}

void free_command(command_t *cmd) {
    for (int i = 0; i < cmd->argc; ++i) free(cmd->argv[i]);
    free(cmd->argv);
    if (cmd->input_file) free(cmd->input_file);
    if (cmd->output_file) free(cmd->output_file);
    free(cmd);
}

// Tokenizer that handles quotes and special characters
int tokenize_line(char *line, token_t *tokens, int max_tokens) {
    int token_count = 0;
    char *p = line;
    while (*p && token_count < max_tokens - 1) {
        // Skip whitespace
        while (isspace((unsigned char)*p)) p++;
        if (!*p) break;

        // Handle special single/double-character tokens
        if (*p == '|') {
            tokens[token_count++] = (token_t){TOKEN_PIPE, strdup("|")};
            p++; continue;
        }
        if (*p == '<') {
            tokens[token_count++] = (token_t){TOKEN_REDIRECT_IN, strdup("<")};
            p++; continue;
        }
        if (*p == '>') {
            if (*(p+1) == '>') {
                tokens[token_count++] = (token_t){TOKEN_REDIRECT_APPEND, strdup(">>")}; p += 2;
            } else {
                tokens[token_count++] = (token_t){TOKEN_REDIRECT_OUT, strdup(">")}; p++;
            }
            continue;
        }
        if (*p == ';') {
            tokens[token_count++] = (token_t){TOKEN_SEMICOLON, strdup(";")};
            p++; continue;
        }
        if (*p == '&') {
            tokens[token_count++] = (token_t){TOKEN_AMPERSAND, strdup("&")};
            p++; continue;
        }

        // Quoted string
        if (*p == '\'' || *p == '"') {
            char quote = *p++;
            char *start = p;
            while (*p && *p != quote) {
                if (*p == '\\' && *(p+1)) p++; // skip escaped chars
                p++;
            }
            size_t len = p - start;
            char *substr = malloc(len + 1);
            strncpy(substr, start, len);
            substr[len] = 0;
            tokens[token_count++] = (token_t){TOKEN_WORD, substr};
            if (*p == quote) p++;
        } else {
            // Regular word: terminates on whitespace or special op
            char *start = p;
            while (*p && !isspace((unsigned char)*p) && !strchr("|<>;&", *p)) p++;
            size_t len = p - start;
            char *substr = malloc(len + 1);
            strncpy(substr, start, len);
            substr[len] = 0;
            tokens[token_count++] = (token_t){TOKEN_WORD, substr};
        }
    }
    tokens[token_count].type = TOKEN_EOF;
    tokens[token_count].value = NULL;
    return token_count;
}

command_t *parse_command(token_t *tokens, int *index) {
    command_t *cmd = calloc(1, sizeof(command_t));
    cmd->argv = malloc(MAX_TOKENS * sizeof(char*));
    cmd->argc = 0;

    while (tokens[*index].type != TOKEN_EOF &&
           tokens[*index].type != TOKEN_PIPE && 
           tokens[*index].type != TOKEN_SEMICOLON) {
        switch (tokens[*index].type) {
        case TOKEN_WORD:
            cmd->argv[cmd->argc++] = strdup(tokens[*index].value);
            break;
        case TOKEN_REDIRECT_IN:
            (*index)++;
            if (tokens[*index].type == TOKEN_WORD)
                cmd->input_file = strdup(tokens[*index].value);
            break;
        case TOKEN_REDIRECT_OUT:
            (*index)++;
            if (tokens[*index].type == TOKEN_WORD) {
                cmd->output_file = strdup(tokens[*index].value);
                cmd->append_mode = 0;
            }
            break;
        case TOKEN_REDIRECT_APPEND:
            (*index)++;
            if (tokens[*index].type == TOKEN_WORD) {
                cmd->output_file = strdup(tokens[*index].value);
                cmd->append_mode = 1;
            }
            break;
        case TOKEN_AMPERSAND:
            cmd->background = 1;
            break;
        default: break;
        }
        (*index)++;
    }
    cmd->argv[cmd->argc] = NULL;
    return cmd;
}

void print_command(command_t *cmd) {
    printf("Command: ");
    for (int i = 0; i < cmd->argc; i++)
        printf("\"%s\" ", cmd->argv[i]);
    if (cmd->input_file)
        printf("< \"%s\" ", cmd->input_file);
    if (cmd->output_file)
        printf("%s \"%s\" ", cmd->append_mode ? ">>" : ">", cmd->output_file);
    if (cmd->background)
        printf("& ");
    printf("\n");
}

void shell_demo(char* line)
{
    
        token_t tokens[MAX_TOKENS];

        int ntokens = tokenize_line(line, tokens, MAX_TOKENS);

        int idx = 0;
        while (tokens[idx].type != TOKEN_EOF) {
            command_t *cmd = parse_command(tokens, &idx);
            print_command(cmd);
            free_command(cmd);

            if (tokens[idx].type == TOKEN_PIPE || tokens[idx].type == TOKEN_SEMICOLON)
                idx++;
        }
        free_tokens(tokens, ntokens);
    
}
extern struct ext4_fs fs;

void parse_line(char* line)
{
    char *orgLine = malloc(strlen(line)+1);
    strcpy(orgLine, line);
    char * linePtr = strtok(line, " ");
    if(strcmp(linePtr,"clear") == 0) //no diff
    {
        //printf("We are testing!!\n");
        sys_scroll(32);
        syscall_trap0(0x0CL,0x00L,0x00); //set cursor to 0,0
        //fs
    }else if(strcmp(linePtr,"getfree") == 0)
    {
        
        uint32_t free_blocks = fs.sb.free_blocks_count_lo; //shourly cant be more than > 4G * 1024 = 4T
        uint32_t block_size = fs.sb.log_block_size;
        uint32_t free_space_bytes = (uint32_t)free_blocks * block_size;
        printf("Space left on disk: %lu bytes\n", free_space_bytes);
        
    }else if(strcmp(linePtr,"xmodem") == 0)
    {
        char * arg;
        do{
        arg = strtok(NULL," ");
        if(arg == NULL)
        {
            printf("\nUsage: xmodem <file_name(s)>\n");
            return;
        }
        xmodem_receive(arg);
        }while(arg != NULL);
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
        
    }else if(strcmp(linePtr,"umnt") == 0)
    {
        char *arg = strtok(NULL, " ");
        if(arg == NULL || arg[strlen(arg)-1] != '/')
        {
            printf("\nUsage: umnt <path/>\n");
            return;
        }
        
        int res = ext4_umount(arg);
        printf("\n");
        if(res)
        {
            printf("Error unmounting drive %d\n",res);
        }
        return;
    }else if(strcmp(linePtr,"mnt") == 0)
    {
        char *arg1 = strtok(NULL, " ");
        if(arg1 == NULL)
        {
            printf("\nUsage: umnt <dev> <mount/point>\n");
            return;
        }

        char *arg2 = strtok(NULL, " ");
        if(arg2 == NULL)
        {
            printf("\nUsage: umnt <dev> <mount/point>\n");
            return;
        }
        
        int res = ext4_mount(arg1,arg2,0);
        printf("\n");
        if(res)
        {
            printf("Error unmounting drive %d\n",res);
        }
        return;
    }else
    {
        printf("\n");
        //char prgPath[256];
        //strcpy(prgPath,_BIN_PATH);
        //strcat(prgPath,linePtr);
        if(strchr(linePtr, '/')) //Is relative?
        {
            //run_file(linePtr);
            
        }else{
            //run_file(prgPath);
        }


        token_t tokens[MAX_TOKENS];

        int ntokens = tokenize_line(orgLine, tokens, MAX_TOKENS);
        int idx = 0;
        while (tokens[idx].type != TOKEN_EOF) {
            command_t *cmd = parse_command(tokens, &idx);
            call_command(cmd);
            free_command(cmd);

            if (tokens[idx].type == TOKEN_PIPE || tokens[idx].type == TOKEN_SEMICOLON)
                idx++;
        }
        free_tokens(tokens, ntokens);
        fflush(stdout);
        //printf("\n");
    
    }
    free(orgLine);
}






void shell_loop()
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
            //shell_demo(line);
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
        }else if (ch == 0x08 && i > 0) //BS
        {
            line[i-1] = 0;
            i--;
        }else
        {
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
extern uint32_t cur_pid;
void shell_start()
{
    printf("Shell starting ...\nPID %lu\n",cur_pid);
    printf("%s",DEFAULT_PROMPT);
    fflush(stdout);
    memset(print_buf,' ',80);
    print_buf[79] = 0;
    while(1)
    {
        shell_loop();
    }
}