#include "main.h"

// Places an item into our queue
void enqueue(queue *q, char* value) { 
    node* ptr; 
    ptr = malloc(sizeof(node)); 
    if(ptr != NULL) { 
        ptr->data = value; 
        ptr->next = NULL; 
        if(is_empty(q)) {
            q->front = ptr;
        } else {
            q->rear->next = ptr; 
        }
        q->rear = ptr; 
    } else { 
        printf("%s is not inserted. No memory available.\n", value); 
    }
} 

// Pops an item from the queue, if empty return null
char* dequeue(queue *q) { 
    if(is_empty(q)) {
        return NULL;
    }
    char* value; 
    node* ptr; 
    value       = q->front->data; 
    ptr         = q->front; 
    q->front    = q->front->next; 
    if (q->front == NULL) { 
        q->rear = NULL; 
        free (ptr);
    }
    return value;
}

// Checks if the queue is empty
int is_empty(queue *q) {
    return (q->front == NULL);
}

// Prints the queue for debugging
void print(queue *q) {
    node* ptr = q->front;
    printf("{");
    while(ptr != NULL) {
        if(ptr == q->rear){
            printf(" [%s] ", ptr->data);
            break;
        }
        printf(" [%s], ", ptr->data);
        ptr = ptr->next;
    }
    printf("}\n");
    return;
}