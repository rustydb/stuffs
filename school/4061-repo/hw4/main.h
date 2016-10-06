/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#ifndef _main_h
#define _main_h
#include <pthread.h>
#include <stdlib.h>     // exit, EXIT_FAILURE
#include <stdio.h>
#include <libgen.h>		// dirname, basename
#include <unistd.h>		// chdir
#include <string.h>
#include <time.h>       // is_DIR
#include <sys/stat.h>   // is_DIR
#include <fcntl.h>      // open, read, write, close
#define BUFF 500
#define DIRBUFF 245

typedef struct node { 
    char* data; 
    struct node* next; 
} node; 

typedef struct queue { 
    node* front; 
    node* rear; 
} queue; 

// Retrieve
int reader(char* fn); 
void *threader(void *args);
void decrypt(char* line);
int is_DIR(char *path);
int file_exist (char *filename);

// Queue
int is_empty();
void enqueue(queue *q, char* value);
char* dequeue(queue *q);
int is_empty(queue *q);
void print(queue *q);

#endif