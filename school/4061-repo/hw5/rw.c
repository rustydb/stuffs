#include "main.h"
void reader(int fd, int* msg_x, int* charlen, char* buf) {
    read(fd, msg_x, sizeof(*msg_x));
    read(fd, charlen, sizeof(*charlen));
    read(fd, buf, *charlen);
    buf[*charlen] = '\0';
}
void writer(int fd, int msg_x, char* buf) {
    write(fd, &msg_x, sizeof(msg_x));
    int charlen = strlen(buf);
    write(fd, &charlen, sizeof(charlen));
    write(fd, buf, charlen);
}