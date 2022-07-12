/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#ifndef __MM_H
#define __MM_H

/* You are free to declare any data type here */

// mm_size allows all files to access memory pool size
extern int mm_size;

int mm_init(unsigned long size);
char *mm_alloc(unsigned long nbytes);
int mm_free(char *ptr);
void mm_end(unsigned long *free_num);
int mm_assign(char *ptr, char val);
unsigned long mm_check();

#endif