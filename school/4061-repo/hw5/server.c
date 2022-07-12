/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#include "main.h"
queue *sq; // shared queue
pthread_mutex_t lock    = PTHREAD_MUTEX_INITIALIZER;

// Ran by threads, looks through shared queue and runs decrypt
// on each item. Returns a dummy pointer for C purposes
void *threader(void *args) {
    // Aqurires tid and starts it at 1 rather 0.
    int tid = *((int *)args) + 1;
    int yes;
    char line[BUFF];
    node* client;
    void* dummy = NULL;
    // While shared queue is not empty, lock and dequeue the clients
    while(1) {
        if(pthread_mutex_lock(&lock) != 0) {
            perror("WARN: Could not lock, data in use by another thread\n");
        }
        while(is_empty(sq)) {
            if(pthread_mutex_unlock(&lock) != 0) {
                perror("WARN: Could not lock, data in use by another thread\n");
            }
            pthread_yield(NULL);
            if(pthread_mutex_lock(&lock) != 0) {
                perror("WARN: Could not lock, data in use by another thread\n");
            }
        }
        // Pop client
        client = dequeue(sq);
        if(pthread_mutex_unlock(&lock) != 0) {
            perror("WARN: Could not lock, data in use by another thread\n");
        }
        int clfd = client->fd;
        printf("Thread %d is handling client (%s,%i)\n", tid, client->ip, client->port);
        // Send handshake to client
        writer(clfd, msg_hs, "");
        yes = 1;
        while(yes) {
            int msg_x, charlen;
        // Receive response from client
            reader(clfd, &msg_x, &charlen, line);
            if(msg_x == msg_hsr) {
                break;
            } else {
                yes = 0;
            }
        }
        while(yes) {
            int msg_x, charlen;
            reader(clfd, &msg_x, &charlen, line);
            switch(msg_x) {
                case msg_dr:
                    decrypt(line);
                    writer(clfd, msg_rm, line);
                    break;
                case msg_eor:
                    yes = 0;
                    break;
                case msg_err:
                    printf("ERROR: Thread: %i received error %s\n", tid, line);
                    yes = 0;
                    break;
                default:
                    printf("ERROR: Invalid request %i\n", msg_err);
                    writer(clfd, msg_err, "ERROR: Invalid request");
                    yes = 0;
                    break;
            }
        }
        printf("Thread %d finished handling client (%s,%i)\n", tid, client->ip, client->port);
        close(clfd);
        free(client);
    }
    return dummy;
}

// Decrypts given line by adding 2 to the ASCII value
void decrypt(char* line) {
    int i;
    for(i = 0; line[i]; ++i) {
        if(line[i] >= 'A' && line[i] <= 'Z') {
            line[i] = (line[i] - 'A' + 2) % 26 + 'A';
        }
        if(line[i] >= 'a' && line[i] <= 'z') {
            line[i] = (line[i] - 'a' + 2) % 26 + 'a';
        }
    }
}

int main(int argc, char* argv[]) {
    if((argc < 2) || (argc > 3)) {
        printf("ERROR: Please provide the server 1-2 arguments\n"
                "./decryption_server [port] [number of threads]\n"
                "number of threads defaults to 5 if unspecified\n");
        exit(EXIT_FAILURE);
    }
    // Check for specified threads, else set to 5
    int num_threads;
    if(argv[2] != NULL) {
        if((num_threads = atoi(argv[2])) < 1) {
            printf("ERROR: Must specify 1 or more threads, otherwise"
                   "leave blank for default of 5\n");
            exit(EXIT_FAILURE);
        }
    } else {
        num_threads = 5;
    }
    // Create socket as TCP in IPv4
    sock_info_t s_info;
    // int list_sock = 0, client = 0;
    s_info.sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if(s_info.sockfd < 0) {
        perror("ERROR: Could not open socket");
    }
    // Set port to be reusable
    int true = 1;
    setsockopt(s_info.sockfd, SOL_SOCKET, SO_REUSEADDR, &true, sizeof(int));
    // Set addr to IPv4, localhost, and port of choosing and
    // bind the socket
    memset((char*) &serv_addr, '\0', sizeof(serv_addr));
    serv_addr.sin_family        = AF_INET;
    serv_addr.sin_addr.s_addr   = htonl(INADDR_ANY);
    serv_addr.sin_port          = htons(atoi(argv[1]));
    if(bind(s_info.sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
        perror("ERROR: Socket could not be bound");
    }
    // Allocate queue
    sq = (queue *)malloc(sizeof(queue*));
    // Initialize Threadsls
    int thread_err;
    pthread_t tid[num_threads];
    int ints[num_threads];
    int i;
    for (i = 0; i < num_threads; ++i) {
        ints[i] = i;
        if((thread_err = pthread_create(&tid[i], NULL, threader, ints + i)) != 0) {
            perror("ERROR: Could not create thread: ");
            exit(EXIT_FAILURE);
        }
    }
    // Start listening
    listen(s_info.sockfd, BUFF);
    printf("*************************\n");
    while(1) {
        printf("Awaiting connection...\n");
        addr_size = sizeof client_addr;
        s_info.newsockfd = accept(s_info.sockfd, (struct sockaddr*)&client_addr, &addr_size);
        if(s_info.newsockfd < 0) {
            perror("ERROR: Could not accept client");
        }
        printf("Client accepted\n");
        printf("Cliend fd: %i\n", s_info.newsockfd);
        // Fetch IP of client
        struct sockaddr_in* pV4addr = (struct sockaddr_in*)&client_addr;
        int cl_ip_addr  = pV4addr->sin_addr.s_addr;
        int port        = pV4addr->sin_port;
        char ip[BUFF];
        inet_ntop(AF_INET, &cl_ip_addr, ip, BUFF);
        // Enqueue client
        if(pthread_mutex_lock(&lock) != 0) {
            perror("WARN: Could not lock, data in use by another thread\n");
        }
        enqueue(sq, s_info.newsockfd, ip, port);
        // print(sq);
        if(pthread_mutex_unlock(&lock) != 0) {
            perror("WARN: Could not lock, data in use by another thread\n");
        }
        // DEBUG
        // node* tst = dequeue(sq);
        // printf("I dequeued a node with IP: %s and Port: %i\n", tst->ip, tst->port);
        // END DEBUG
        // Wait for threads
        // for (i = 0; i < num_threads; ++i) {
        //     pthread_join(tid[i], NULL);
        // }
    }
    return 0;
}
