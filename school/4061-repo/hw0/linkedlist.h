#include <stdbool.h>
#include <stdlib.h>

struct node {
    int value;
    struct node *next;
};

struct node *head = NULL;
struct node *current = NULL;

struct node* makeList(int size) {
    struct node *ptr = (struct node*)malloc(sizeof(struct node));
    if(ptr == NULL) {
        printf("Node could not be created\n");
        return NULL;
    }
    ptr->value = size;
    ptr->next = NULL;
    head = current = ptr;
    if(ptr == NULL) {
        printf("Node could not be created\n");
        return NULL;
    }
    return ptr;
}

struct node* add(int val, bool tail) {
    if(NULL == head) {
        return (makeList(val));
    }
    // if(tail)
    //     printf("\n Adding node to end of list with value [%d]\n",val);
    // else
    //     printf("\n Adding node to beginning of list with value [%d]\n",val);
    struct node *ptr = (struct node*)malloc(sizeof(struct node));
    if(NULL == ptr) {
        printf("Node could not be created \n");
        return NULL;
    }
    ptr->value = val;
    ptr->next = NULL;
    if(tail) {
        current->next = ptr;
        current = ptr;
    } else {
        ptr->next = head;
        head = ptr;
    }
    return ptr;
}

struct node* search(int val, struct node **prev) {
    struct node *ptr = head;
    struct node *tmp = NULL;
    bool found = false;
    // printf("Searching...\n");
    while(ptr != NULL) {
        if(ptr->value == val) {
            found = true;
            break;
        } else {
            tmp = ptr;
            ptr = ptr->next;
        }
    }
    if(found == true) {
        if(prev)
            *prev = tmp;
        return ptr;
    } else {
        return NULL;
    }
}

int delete(int val) {
    struct node *prev = NULL;
    struct node *del = NULL;
    del = search(val, &prev);
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

void print(void) {
    struct node *ptr = head;
    printf("[");
    while(ptr != NULL) {
        printf(" %i ", ptr->value);
        ptr = ptr->next;
    }
    printf("]\n");
    return;
}