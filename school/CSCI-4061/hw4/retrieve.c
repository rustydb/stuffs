/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#include "main.h"
// Globals
FILE *fp;  // file pointer for argv[1]
FILE *lfp; // file pointer for log.txt
FILE *ofp; // file pointer for output files
queue *sq; // shared queue
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
char *outDIR; // output directory after cwd

// Reads filename given and inserts each line into our shared queue
int reader(char* fn) {
    char* line = NULL;
    size_t len = 0;
    ssize_t nbytes = 0;
    if((fp = fopen(fn, "r")) == NULL) {
        fprintf(stderr, "ERROR: File could not be opened: %s\n", fn);
        return -1;
    }
    // Remove new lines and push each client onto the queue
    while(nbytes != -1) {
        line = (char *)malloc(BUFF);
        if((nbytes = getline(&line, &len, fp)) != -1) {
            strtok(line, "\n");
            enqueue(sq, line);
        }
    }
    if(fclose(fp) < 0) {
        perror("ERROR: Could not close argv[1] filehandle\n");
        exit(EXIT_FAILURE);
    }
    return 0;
}

// Ran by threads, looks through shared queue and runs decrypt
// on each item. Returns a dummy pointer for C purposes
void *threader(void *args) {
    char *line;
    size_t len;
    ssize_t nbytes;
    char output[DIRBUFF];
    char *client_out;
    char *client;
    void *dummy = NULL;
    // While shared queue is not empty, lock and dequeue the clients
    while(!is_empty(sq)) {
        line = NULL;
        len = 0;
        nbytes = 0;
        if(pthread_mutex_lock(&lock) != 0) {
            perror("WARN: Could not lock, data in use by another thread\n");
        }
        // Get output directory
        strcpy(output, outDIR);
        strcat(output, "/");
        // Pop client
        client = dequeue(sq);
        // If client received is EOF we are finished and can return
        if(client == '\0') {
            if(pthread_mutex_unlock(&lock) != 0) {
                perror("WARN: Could not lock, data in use by another thread\n");
            }
            return dummy;
        }
        // Print client and thread ID to log.txt
        fprintf(lfp, "%s: %lu\n", client, (unsigned long)pthread_self());
        if((fp = fopen(client, "r")) == NULL) {
            fprintf(lfp, "ERROR: Client: %s could not be opened, may not exist\n", client);
            if(pthread_mutex_unlock(&lock) != 0) {
                perror("WARN: Could not lock, data in use by another thread\n");
            }
            // Reset output buffer
            output[0] = '\0';
            continue;
        }
        // Append .out onto client filename and filename to output directory
        client_out = basename(client);
        strcat(client_out, ".out");
        strcat(output, client_out);
        // Open output file for writing
        if((ofp = fopen(output, "w")) == NULL) {
            fprintf(stderr, "ERROR: Output File: %s could not be opened\n", output);
            exit(EXIT_FAILURE);
        }
        // Decrypt popped client
        while(nbytes != -1) {
            line = (char *)malloc(BUFF);
            if((nbytes = getline(&line, &len, fp)) != -1) {
                // Decode
                decrypt(line);
                // Print to .out file
                // printf("%s\n", argv[2]);
                fprintf(ofp, "%s\n", line);
            }
        }
        // Reset output buffer
        output[0] = '\0';
        if(fclose(ofp) < 0) {
            perror("ERROR: Could not close argv[1] filehandle\n");
            exit(EXIT_FAILURE);
        }
        if(fclose(fp) < 0) {
            perror("ERROR: Could not close argv[1] filehandle\n");
            exit(EXIT_FAILURE);
        }
        if(pthread_mutex_unlock(&lock) != 0) {
            perror("WARN: Could not lock, data in use by another thread\n");
        }
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

// Checks if given path is a directory
int is_DIR(char *path) {
    struct stat statbuf;
    if (stat(path, &statbuf) == -1) {
        return 0;
    } else {
        return S_ISDIR(statbuf.st_mode);
    }
}

// Checks if file exists
int file_exist (char *filename) {
  struct stat   buffer;   
  return (stat (filename, &buffer) == 0);
}

int main(int argc, char** argv) {
    // Checks if valid number of arugments is given
    if((argc < 3) || (argc > 4)) {
        printf("ERROR: Please provide atleast an input and output\n");
        exit(EXIT_FAILURE);
    }
    // Checks if output directory exists
    if(!is_DIR(argv[2])) {
        // printf("ERROR: Output directory: %s specified does not exist\n",
        //        argv[2]);
        // exit(EXIT_FAILURE);
        mkdir(argv[2], S_IRWXU);
    }
    outDIR = argv[2];
    // Check for specified threads, else set to 5
    int num_threads;
    if(argv[3] != NULL) {
        if((num_threads = atoi(argv[3])) < 1) {
            printf("ERROR: Must specify 1 or more threads, otherwise"
                   "leave blank\n");
            exit(EXIT_FAILURE);
        }
    } else {
        num_threads = 5;
    }
    // Initialize the queue with clients
    sq = (queue *)malloc(sizeof(queue*));
    if(reader(argv[1]) < 0) {
        exit(EXIT_FAILURE);
    }
    // Remove any trailing '/' if there, otherwise add '/'
    char output[DIRBUFF];
    strcpy(output, argv[2]);     
    if(output[strlen(output) - 1] != '/') {
        strcat(output, "/");
    }
    // Open log file, overwrite pre-existing
    strcat(output, "/log.txt");
    if((lfp = fopen(output, "w")) == NULL) {
        perror("ERROR: Could not write or overwrite log file\n");
        exit(EXIT_FAILURE);
    }
    // Initialize Threads
    int thread_err;
    pthread_t tid[num_threads];
    int i;
    for (i = 0; i < num_threads; ++i) {
        if((thread_err = pthread_create(&tid[i], NULL, threader, NULL)) != 0) {
            perror("ERROR: Could not create thread: ");
            exit(EXIT_FAILURE);
        }
    }
    // Wait for threads
    for (i = 0; i < num_threads; ++i) {
        pthread_join(tid[i], NULL);
    }
    if(fclose(lfp) < 0) {
        perror("ERROR: Could not close argv[1] filehandle\n");
        exit(EXIT_FAILURE);
    }
    free(sq);
    return 0;
}