/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#include <stdbool.h>
#include <stdlib.h>
#include "mm.h"

struct node {
    int start;
    int length;
    struct node *next;
};

struct node *head    = NULL;
struct node *current = NULL;

struct node* makeList(int size) {
    FILE *fp;
    if((fp = fopen("out.log", "a+")) == NULL) {
        perror("out.log could not be opened: ");
        exit(EXIT_FAILURE);
    }
    struct node *ptr = (struct node*)malloc(sizeof(struct node));
    if(ptr == NULL) {
        // printf("Node could not be created\n");
        fprintf(fp, "Request declined: request could not be completed...\n");
        if((fclose(fp)) != 0) {
            perror("out.log could not be closed: ");
            exit(EXIT_FAILURE);
        }
        return NULL;
    }
    mm_size     = size;
    ptr->start  = 0;
    ptr->length = 0;
    ptr->next   = NULL;
    head = current = ptr;
    if(ptr == NULL) {
        // printf("Node could not be created\n");
        fprintf(fp, "Request declined: request could not be completed...\n");
        if((fclose(fp)) != 0) {
            perror("out.log could not be closed: ");
            exit(EXIT_FAILURE);
        }
        return NULL;
    }
    if((fclose(fp)) != 0) {
        perror("out.log could not be closed: ");
        exit(EXIT_FAILURE);
    }
    return ptr;
}

struct node* add(int val) {
    FILE *fp;
    if((fp = fopen("out.log", "a+")) == NULL) {
        perror("out.log could not be opened: ");
        exit(EXIT_FAILURE);
    }
    if(head == NULL) {
        fprintf(fp, "Request declined: memory pool not yet initialized...\n");
        if((fclose(fp)) != 0) {
            perror("out.log could not be closed: ");
            exit(EXIT_FAILURE);
        }
        return NULL;
    }
    struct node *ptr = (struct node*)malloc(sizeof(struct node));
    ptr->start  = 0;
    ptr->length = val;
    ptr->next   = NULL;
    struct node *tmp = head;
    struct node *nxt = head->next;
    if(ptr == NULL) {
        // Node could not be created
        fprintf(fp, "Request declined: request could not be completed...\n");
        if((fclose(fp)) != 0) {
            perror("out.log could not be closed: ");
            exit(EXIT_FAILURE);
        }
        return NULL;
    }
    if(head->start + head->length == 0) {
        head = current = ptr;
        if((fclose(fp)) != 0) {
            perror("out.log could not be closed: ");
            exit(EXIT_FAILURE);
        }
        return ptr;
    }
    while(nxt != NULL) {
        int mm_gap = (nxt->start - (tmp->start + tmp->length));
        if(mm_gap >= val) {
            ptr->start  = tmp->start + tmp->length;
            ptr->length = val;
            ptr->next   = nxt;
            tmp->next   = ptr;
            if((fclose(fp)) != 0) {
                perror("out.log could not be closed: ");
                exit(EXIT_FAILURE);
            }
            return ptr;
        }
        tmp = nxt;
        nxt = nxt->next;
    }
    if(val > (mm_size - (current->start + current->length))) {
        fprintf(fp, "Request declined: memory pool has insufficient size availabile\n");
        if((fclose(fp)) != 0) {
            perror("out.log could not be closed: ");
            exit(EXIT_FAILURE);
        }
        return NULL;
    }
    ptr->start    = current->start + current->length;
    current->next = ptr;
    current       = ptr;
    if((fclose(fp)) != 0) {
        perror("out.log could not be closed: ");
        exit(EXIT_FAILURE);
    }
    return ptr;
}

struct node* search(int start, int length, struct node **prev) {
    struct node *ptr = head;
    struct node *tmp = NULL;
    bool found  = false;
    while(ptr != NULL) {
        if(ptr->start == start) {
            found = true;
            break;
        } else {
            tmp = ptr;
            ptr = ptr->next;
        }
    }  
    if(found) {
        if(prev)
            *prev = tmp;
        return ptr;
    } else {
        FILE *fp;
        if((fp = fopen("out.log", "a+")) == NULL) {
            perror("out.log could not be opened: ");
            exit(EXIT_FAILURE);
        }
        fprintf(fp, "Free error: not the right pointer!\n");
        if((fclose(fp)) != 0) {
            perror("out.log could not be closed: ");
            exit(EXIT_FAILURE);
        }
        return NULL;
    }
}

int delete(struct node* n) {
    struct node *prev = NULL;
    struct node *del  = NULL;
    del = search(n->start, n->length, &prev);
    if(del == NULL) {
        return -1;
    } else {
        if(prev != NULL)
            prev->next = del->next;
        if(del == current) {
            current = prev;
        }
        else if(del == head) {
            head = del->next;
        }
    }
    free(del);
    del = NULL;
    return 0;
}

unsigned long count(void) {
    struct node* ptr = head;
    if(head->start + head->length == 0) {
        return 0;
    }
    unsigned long count = 0;
    while(ptr != NULL) {
        ++count;
        ptr = ptr->next;
    }
    return count;
}

int free_count(void) {
    FILE *fp;
    if((fp = fopen("out.log", "a+")) == NULL) {
        perror("out.log could not be opened: ");
        exit(EXIT_FAILURE);
    }
    if(head == NULL) {
        fprintf(fp, "Request declined: request could not be completed...");
        fclose(fp);
        return -1;
    }
    struct node* tmp = NULL;
    int fcount = 0;
    while(head != current) {
        if((head->length + head->start) != head->next->start) {
            ++fcount;
        }
        tmp = head;
        head = head->next;
        free(tmp);
    }

    if(current->length + current->start != mm_size) {
        ++fcount;
        fclose(fp);
    }
    return fcount;
}

void print(void) {
    struct node *ptr = head;
    printf("{");
    while(ptr != NULL) {
        if(ptr->next == NULL){
            printf(" [0x%i | %i] ", ptr->start, ptr->length);
            break;
        }
        printf(" [0x%i | %i], ", ptr->start, ptr->length);
        ptr = ptr->next;
    }
    printf("}\n");
    return;
}