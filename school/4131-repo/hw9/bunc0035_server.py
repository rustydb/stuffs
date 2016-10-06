#!/usr/bin/env python3

'''
Sekelton code used from Challou's moodle code

Code modified by Russell Bunch

'''
import socket
import re
import os
import stat
import errno

from threading import Thread
from argparse import ArgumentParser

# Our buffersize for messages
BUFSIZE = 4096
# Array of all the valid HTTP requests
HTTP_REQS = [
    "OPTIONS",
    "GET",
    "HEAD",
    "POST",
    "PUT",
    "DELETE",
    "TRACE",
    "CONNECT",
    "PATCH"
]

# Communicates with the client
def client_talk(client_sock, client_addr):
    try:
        # Receive initial message from client and grab the file name (assuming it's a get request)
        data     = client_sock.recv(BUFSIZE)
        print (data.decode('utf-8'))
        request  = data.split()[0]
        # Check if we have a valid request
        for i in range(0, 9):
            if request == HTTP_REQS[i]:
                filename = data.split()[1]
                # Check if file is readable by 'others'
                #if is_universable(filename):
                    # Attempt to open file, catch IOError if doesn't exist
                fh = open(filename[1:])
                f  = fh.read()
                # If we didn't catch an IO exception, send the 200 OK
                client_sock.send('HTTP/1.1 200 OK Content-Type: text/html\r\n\r\n')
                print ('HTTP/1.1 200 OK Content-Type: text/html\r\n\r\n')
                # Now send our requested file
                if request == "GET":
                    for i in range(0, len(f)):
                        client_sock.send(f[i])
                client_sock.shutdown(1)
                client_sock.close()
                print ('Connection closed: Server Side')
        # Client send bad request
        client_sock.send('HTTP/1.1 400 BAD REQUEST\r\n\r\n')
        print ('HTTP/1.1 400 BAD REQUEST\r\n\r\n')
        forbid = open('status_codes/400.html')
        f = forbid.read()
        if request == "GET":
            for i in range(0, len(f)):
                client_sock.send(f[i])
        client_sock.shutdown(1)
        client_sock.close()
    # Add exception for open() to catch bad params or nonexisting file
    except IOError as e:
        # Check for incorrect permissions, else assume file isn't found
        if e.errno == errno.EACCES:
            # Incorrect file permissions
            client_sock.send('HTTP/1.1 403 FORBIDDEN\r\n\r\n')
            print ('HTTP/1.1 403 FORBIDDEN\r\n\r\n')
            forbid = open('status_codes/403.html')
            f = forbid.read()
            if request == "GET":
                for i in range(0, len(f)):
                    client_sock.send(f[i])
            client_sock.shutdown(1)
            client_sock.close()
        #raise
        # Else the file not found
        client_sock.send('HTTP/1.1 404 Not Found\r\n\r\n')
        print ('HTTP/1.1 404 Not Found\r\n\r\n')
        notfound = open('status_codes/404.html')
        f = notfound.read()
        if request == "GET":
            for i in range(0, len(f)):
                client_sock.send(f[i])
        client_sock.shutdown(1)
        client_sock.close()

# Our server class
class EchoServer:
    # Run when initialized
    def __init__(self, host, port):
        print('listening on port {}'.format(port))
        self.host = host
        self.port = port
        # Run setup_socket to set our socket options and bind to the port
        self.setup_socket()
        # Begin accepting connections
        self.accept()

        self.sock.shutdown()
        self.sock.close()
    # Build our socket
    def setup_socket(self):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.sock.bind((self.host, self.port))
        self.sock.listen(128)
    # Wait for clients and make threads for each one as they connect
    def accept(self):
        while True:
            (client, address) = self.sock.accept()
            th = Thread(target=client_talk, args=(client, address))
            th.start()

# Parse arguments, right now the only argument allowed is to change the port
# Default values for host and port are localhost and 9001, respectivly
def parse_args():
    parser = ArgumentParser()
    parser.add_argument('--host', type=str, default='localhost',
                        help='specify a host to operate on (default: localhost)')
    parser.add_argument('-p', '--port', type=int, default=9001,
                        help='specify a port to operate on (default: 9001)')
    args = parser.parse_args()
    return (args.host, args.port)

# Run as main, parse the args, and start up our server
if __name__ == '__main__':
    (host, port) = parse_args()
    EchoServer(host, port)

