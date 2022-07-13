/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#include "getstring.h" 
#include <stdio.h>
#include <stdlib.h>     // exit, EXIT_FAILURE
#include <dirent.h>     // DIR
#include <unistd.h>     // chdir
#include <time.h>       // is_DIR
#include <sys/stat.h>   // is_DIR
#include <errno.h>      // EINTR
#include <sys/wait.h>   // wait
#include <fcntl.h>      // open, read, write, close
#include <string.h>     // strcmp
#define DIRBUF 256      // Buffer for directory size
pid_t pid;

int main(int argc, char** argv) {
    if(argc < 3) {
        printf("Not enough arguments. Usage: \n");
        printf("getstring {dir_path} {search_criteria}\n");
        exit(EXIT_FAILURE);
    }
    if(argc > 3) {
        printf("Too many arugments provided. Usage: \n");
        printf("getstring {dir_path} {search_criteria}\n");
        exit(EXIT_FAILURE);
    }
    /* Open out.txt & log.txt, if there then truncate them to 0 bytes
     * and put args into variables. Then run through finder. When finished,
     * close out.txt & log.txt.
     */
    int out = open("out.txt", O_CREAT | O_TRUNC | O_RDWR, 0666);
    int log = open("log.txt", O_CREAT | O_TRUNC | O_RDWR, 0666);
    char* dir_path = argv[1];
    char* search_str = argv[2];
    finder(dir_path, search_str, out, log);
    close(out);
    close(log);
    return 0;
}

// Example 5.10 in book
// Returns 0 if false, nonzero if true
int is_DIR(char *path) {
    struct stat statbuf;
    if (stat(path, &statbuf) == -1) {
        return 0;
    } else {
    return S_ISDIR(statbuf.st_mode);
    }
}

/* Method for scanning contents of a directory and 
 * passing them to exec if necessary or recursing
 * if finding a subdirectory.
 */
void finder(char* dir, char* search, int out, int log) {
    DIR *dp;
    struct dirent *entry;
    if((dp = opendir(dir)) == NULL) {
        fprintf(stderr, "Specified directory cannot be opened: %s\n", dir);
        exit(EXIT_FAILURE);
    }
    // While loop points to each file in dir
    while((entry = readdir(dp)) != NULL) {
        // Special handling for . and .. files
        if(strcmp(entry->d_name, ".") && strcmp(entry->d_name, "..")) {
            char newdir[DIRBUF];
            strcpy(newdir, dir);
            // Get rid of any trailing / from input if exists
            // before adding the / for the next folder
            if(newdir[strlen(newdir) - 1] != '/') {
                strcat(newdir, "/");
            }
            // Add the name of the pointed file to the path
            strcat(newdir, entry->d_name);
            // Write current file to log, with newline
            if((write(log, newdir, strlen(newdir)) == -1) || 
                (write(log, "\n", 1) == -1)) {
                perror("Could not write to log.txt");
                exit(EXIT_FAILURE);
            }
            // Check if the current pointer is a dir
            if(is_DIR(newdir)) {
                // If it is a dir, recurse
                finder(newdir, search, out, log);
            } else {
                // Else begin grepping
                execute(newdir, search, out);
            }
            newdir[0] = '\0'; // clear the buffer
        }
    }
    // Close the current directory (original, or whichever was passed
    // through recursion)
    if(closedir(dp) < 0) {
        fprintf(stderr, "Could not close directory: %s\n", dir);
    }
    // Old debug for checking loop
    // printf("Came out of the while loop.\n");
}

/* Method for forking into each file in a directory
 * and running grep, dumping the results into an
 * out.txt
 */
void execute(char* filename, char* search, int out) {
    int bytesread;
    // char *bp;
    char* buf[DIRBUF];
    int fd = open(filename, O_RDONLY);
    if(fd < 0) {
        fprintf(stderr, "%s could not be opened\n", filename);
    }
    pid_t pid;
    int pipefd[2];
    if(pipe(pipefd) < 0) {
        perror("Error opening pipe, exited with error: ");
        exit(EXIT_FAILURE);
    }
    if((pid = fork()) < 0) {
        perror("Fork Error");
        exit(EXIT_FAILURE);
    } else if(pid == 0) {
        // Pipe in file to execlp
        if(dup2(pipefd[0], STDIN_FILENO) < 0) {
            perror("STDIN_FILENO could not be redirected");
        }
        // Pipe grep out to file
        if(dup2(out, STDOUT_FILENO) < 0) {
            perror("STDOUT_FILENO could not be redirected");
        }
        // Close write end of pipe
        if(close(pipefd[1]) < 0) {
            perror("Child could not close pipefd[1]");
        }
        /* Close read end of pipe - no longer needed, all piped to STDIN_FILENO
         * Doesn't seem to matter if we close this before or after execlp...
         * ... or at all ... but for consistancy it shall be shut.
         */
        if(close(pipefd[0]) < 0) {
            perror("Child could not close pipefd[0]");
        }
        // Exec grep with our search on STDIN_FILENO
        // Output goes to STDOUT_FILENO, aka out.
        execlp("grep", "grep", search, NULL);
        // execlp will only return if it errors
        perror("Could not exec grep in child");
    } else {
        // Pipe STDOUT_FILENO into child
        // dup2(pipefd[1], STDOUT_FILENO); // Already doing this in whileloop
        // Close read end of pipe, not reading only writing
        if(close(pipefd[0]) < 0) {
            perror("Parent could not close pipefd[0]");
        }
        if((bytesread = read(fd, buf, DIRBUF)) < 0) {
            fprintf(stderr, "%s could not be opened\n", filename);
        }
        // While file has bytes left, send into pipe
        while(bytesread > 0) {
            if(write(pipefd[1], buf, bytesread) < 0) {
                perror("Parent could not write to pipefd[1]");
                exit(EXIT_FAILURE);
            }
            bytesread = read(fd, buf, DIRBUF);
        }
        // Close write end of pipe, finished with pipe
        if(close(pipefd[1]) < 0) {
            perror("Could not close pipefd[1]");
            exit(EXIT_FAILURE);
        }
        // Done with file, given file
        if(close(fd) < 0) {
            perror("Could not close file");
        }
        if(wait(&pid) < 0) {
            perror("The parent could not wait for the child to die");
        }
    }
}
