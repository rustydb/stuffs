/*******************************
 * main.c
 *
 * Source code for main
 *
 ******************************/

#include "util.h"
#include "main.h"
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/wait.h>

/*********
 * Simple usage instructions
 *********/
void custmake_usage(char* progname) {
    fprintf(stderr, "Usage: %s [options] [target]\n", progname);
    fprintf(stderr, "-f FILE\t\tRead FILE as a custMakefile.\n");
    fprintf(stderr, "-h\t\tPrint this message and exit.\n");
    fprintf(stderr, "-n\t\tDon't actually execute commands, just print them.\n");
    exit(0);
}

/****************************** 
 * this is the function that, when given a proper filename, will
 * parse the custMakefile and read in the targets and commands
 ***************/

void parse_file(char* filename, char* target, bool execute) {
    // printf("target = %s\n\n", target);
    char* line = malloc(160*sizeof(char));
    char* token = malloc(160*sizeof(char));
    FILE* fp = file_open(filename);
    FILE* fpipe;
    bool firstTarg = strcmp(target, "all") == 0;
    bool closePipe = false;

    while((line = file_getline(line, fp)) != NULL) {
        token = strtok(line, ": \n");

        if(token != NULL && target != NULL) {
            if(strcmp(target, token) == 0) {            
     
                while((token = strtok(NULL, " \n")) != NULL) {
                    parse_file(filename, token, execute);
                    token = strtok(NULL, " \n");
                }
                
                while((line = file_getline(line,fp)) != NULL && strcmp(line, "end\n") != 0) {
                        if(execute) {
                            if((fpipe = (FILE*)popen(line, "w")) == NULL) {
                                printf("Pipe Error - Exit code 2\n");
                                exit(2);
                            }
                            if(firstTarg) {
                                closePipe = true;
                            }
                        } else {
                            printf("%s", line);
                        }
                }
            }
            
    // this loop will go through the given file, one line at a time
    // this is where you need to do the work of interpreting
    // each line of the file to be able to deal with it later
        }
    }
    if(fpipe != NULL && closePipe) {
        pclose(fpipe);
    }
    fclose(fp);
    free(token);
    free(line);
}

int main(int argc, char* argv[]) {
    // Declarations for getopt
    extern int optind;
    extern char* optarg;
    int ch;
    char* format = "f:hn";
    // Variables you'll want to use
    char* filename = "custMakefile";
    bool execute = true;
    // Use getopt code to take input appropriately (see section 3).
    while((ch = getopt(argc, argv, format)) != -1) {
        switch(ch) {
            case 'f':
                filename = strdup(optarg);
                break;
            case 'n':
                execute = false;
                break;
            case 'h':
                custmake_usage(argv[0]);
                break;
        }
    }
    argc -= optind;
    argv += optind;
    /* at this point, what is left in argv is the target that was
        specified on the command line. If getopt is still really confusing,
        try printing out what's in argv right here, then just run
      custmake with various command-line arguments. 
    */
    char* target;
    if((target = *argv) == NULL) {
        target = "all";
    }
    parse_file(filename, target, execute);

    /* after parsing the file, you'll want to execute the target
        that was specified on the command line, along with its dependencies, etc. 
    */
    return 0;
}
