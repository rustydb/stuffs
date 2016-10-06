/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#include <stdio.h>
#include <stdlib.h>     // exit, EXIT_FAILURE
#include "mm.h"
#include "mm_linkedlist.h"
#define BUF 10000

int mm_size          = 0;
struct node* mm_pool = NULL;

/* Create a memory pool and initialize data structure */
int mm_init(unsigned long size) {
    // Creates the out.log file, main function is to wipe any current out.log
    FILE *fp;
    if((fp = fopen("out.log", "w")) == NULL) {
        perror("out.log could not be opened: ");
        exit(EXIT_FAILURE);
    }
    if((fclose(fp)) != 0) {
        perror("out.log could not be closed: ");
        exit(EXIT_FAILURE);
    }
    // Creates data structure for memory modeling
    // Return -1 if unable to create data structure
    mm_pool = makeList(size);
    if(mm_pool == NULL) {
        return -1;
    }
    return 0;
}

/* Allocate nbytes memory space from the pool using first fit algorithm, and return it to the requester */
char *mm_alloc(unsigned long nbytes) {
    FILE *fp;
    if((fp = fopen("out.log", "a+")) == NULL) {
        perror("out.log could not be opened: ");
        exit(EXIT_FAILURE);
    }
    if(mm_pool == NULL) {
        fprintf(fp, "Request declined: memory pool not yet initialized...\n");
        exit(EXIT_FAILURE);
    }
    if(nbytes == 0) {
        fprintf(fp, "Request declined: not enough memory available!\n");
        return NULL;
    }
    // Not needed, since an unsigned long can not be negative
    // if(nbytes < 0) {
    //     fprintf(fp, "Request declined: can not request negative memory...\n");
    //     return NULL;
    // }
    if(nbytes > mm_size) {
        fprintf(fp, "Request declined: request was larger than memory pool...\n");
        return NULL;
    }
    if((fclose(fp)) != 0) {
        perror("out.log could not be closed: ");
        exit(EXIT_FAILURE);
    }
    char* block = (char*)add(nbytes);
    print();
    return block;
}

/* Check if ptr is valid or not. Only free the valid pointer. Defragmentation. */
int mm_free(char *ptr) {
    struct node* n = (struct node*)ptr;
    return delete(n);
}

/* Count total free blocks. Clean up data structure. Free memory pool */
void mm_end(unsigned long *free_num) {
    *free_num = free_count();
    free(mm_pool);
}

/* Extra Credit Part */
/* Check buffer overflow. If ptr is valid, *ptr = val. */
// int mm_assign(char *ptr, char val) {

// }

/* Before calling mm_end, use this function to check memory leaks and return the number of leaking blocks */
unsigned long mm_check() {
    return count();
}

int main() {
    return 0;
}
