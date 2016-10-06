/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#ifndef _main_h
#define _main_h
#include <pthread.h>
#include <stdlib.h>         // exit, EXIT_FAILURE
#include <stdio.h>
#include <ctype.h>          // resolveHost, isdigit
#include <sys/socket.h>     // socket
#include <arpa/inet.h>      // AF_INET
#include <unistd.h>         // open, close, write, read
#include <netinet/in.h>     // sin
#include <netdb.h>          // gethostbyname
#include <string.h>
#define BUFF 500            // For lines in client
#define DIRBUFF 245         // For directory size
#define SOCKBUFF 1024       // For sockets
#define msg_hs  100   // Handshake
#define msg_hsr 101   // Handshake Response
#define msg_dr  102   // Decrypt Request
#define msg_rm  103   // Response Message
#define msg_eor 104   // End of request
#define msg_err 105   // Error message


// Structures for server/client
struct sockaddr_in serv_addr;
struct sockaddr_storage client_addr;
socklen_t addr_size;
typedef struct sock_info {
    int sockfd, newsockfd;
    struct sockaddr_in cli_addr;
} sock_info_t;

// Structures for the queue
typedef struct node { 
    int fd; 
    char* ip;
    int port;
    struct node* next; 
} node; 

typedef struct queue { 
    node* front; 
    node* rear; 
} queue; 

// Server/Client
void *threader(void *args);
void decrypt(char* line);
int is_DIR(char *path);
void reader(int fd, int* msg_x, int* charlen, char* buf);
void writer(int fd, int msg_x, char* buf);

// Queue
int is_empty();
void enqueue(queue *q, int fd, char* ip, int port);
node* dequeue(queue *q);
int is_empty(queue *q);
void print(queue *q);

#endif