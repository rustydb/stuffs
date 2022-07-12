#include "main.h"

// Places an item into our queue
void enqueue(queue *q, int fd, char* ip, int port) { 
    node* ptr; 
    ptr = malloc(sizeof(node)); 
    if(ptr != NULL) {
        // printf("Making node with: %i %s %i\n", fd, ip, port);
        ptr->fd     = fd; 
        ptr->ip     = ip; 
        ptr->port   = port; 
        ptr->next   = NULL; 
        if(is_empty(q)) {
            q->front = ptr;
        } else {
            q->rear->next = ptr; 
        }
        q->rear = ptr; 
    } else { 
        printf("%i is not inserted. No memory available.\n", fd); 
    }
} 

// Pops an item from the queue, if empty return null
node* dequeue(queue *q) { 
    if(is_empty(q)) {
        return 0;
    }
    node* ptr;
    ptr         = q->front; 
    q->front    = q->front->next;
    if (q->front == NULL) { 
        q->rear = NULL;
    }
    return ptr;
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
        if(ptr == q->rear) {
            printf(" [%s,%i] ", ptr->ip, ptr->port);
            break;
        }
        printf(" [%s,%i], ", ptr->ip, ptr->port);
        ptr = ptr->next;
    }
    printf("}\n");
    return;
}