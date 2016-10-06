/*  Authors:    Russell Bunch & Gavin Prentice
 *  Auth_IDs:   bunc0035 & prent024
 */
#include "main.h"

char* resolveHost(char* addr) {
	if(isdigit(*addr)) {
		return addr;
	}
	printf("Resolving hostname...\n");
	struct hostent* h;
	if((h = gethostbyname(addr)) == NULL) {
		herror("Error: gethostbyname");
	}
	char* hostname = inet_ntoa(*((struct in_addr *)h->h_addr));
	printf("IP Address: %s\n", hostname);
	return hostname;
}

int main(int argc, char* argv[]) {
	int sockfd = 0;
	char recvBuff[BUFF];
	char* addr;
	struct sockaddr_in server_addr;

	if(argc < 4) {
		perror("Usage: ./decryption_client <server address> <server port number> [file paths, ...]");
		exit(EXIT_FAILURE);
	}
	
	memset(recvBuff, '0', sizeof(recvBuff));
	if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
		perror("Error: Couldn't create socket");
		exit(EXIT_FAILURE);
	}
    // Resolve host
	addr = resolveHost(argv[1]);
    // Setup socket structure
	memset(&server_addr, '0', sizeof(server_addr));
	server_addr.sin_family = AF_INET;
	server_addr.sin_port   = htons(atoi(argv[2]));
	if((inet_pton(AF_INET, addr, &server_addr.sin_addr)) < 0) {
		perror("Error: inet_pton failed to translate second argument");
		exit(EXIT_FAILURE);
	}
    // Connect to server
	if((connect(sockfd, (const struct sockaddr*) &server_addr, sizeof(server_addr))) < 0) {
		perror("Error: couldn't establish the connection");
		exit(EXIT_FAILURE);
	}
    // Start talking

    char buff[BUFF];
    char *line = NULL;
    size_t leng = 0;
    ssize_t nbytes = 0;
    int id, len;
    FILE* fd;
    FILE* ofd;
    // Open output file for writing
    while(1) {
        reader(sockfd, &id, &len, buff);
        if(id == msg_hs) {
            break;
        } else {
            printf("ERROR: Did not receive handshake");
            exit(EXIT_FAILURE);
        }
    }
    writer(sockfd, msg_hsr, "");
    int i;
    for (i = 3; i < argc; ++i) {
        if((fd = fopen(argv[i], "r")) == NULL) {
            printf("ERROR: File could not be opened: %s\n", argv[i]);
            exit(EXIT_FAILURE);
        }
        buff[0] = '\0';
        strcpy(buff, argv[i]);
        strcat(buff, ".decrypted");
        if((ofd = fopen(buff, "w")) == NULL) {
            fprintf(stderr, "ERROR: Output File: %s could not be opened\n", buff);
            exit(EXIT_FAILURE);
        }
        buff[0] = '\0';
        while(nbytes != -1) {
            line = (char *)malloc(BUFF);
            if((nbytes = getline(&line, &leng, fd)) != -1) {
                writer(sockfd, msg_dr, line);
                reader(sockfd, &id, &len, line);
                switch(id) {
                    case msg_rm:
                        fprintf(ofd, "%s", line);
                        break;
                    case msg_err:
                        printf("ERROR: %s\n", line);
                        exit(EXIT_FAILURE);
                    default:
                        writer(sockfd, msg_err, "ERROR: Invalid message or request");
                        break;
                }
            }
        }
        fclose(fd);
        fclose(ofd);
    }
    writer(sockfd, msg_eor, "");
    close(sockfd);
	return 0;
}