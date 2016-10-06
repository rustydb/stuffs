#!/usr/bin/perl

# Flushing to STDOUT after each write
$| = 1;

use warnings;
use strict;
use IO::Socket;

# Server side information
my $listen_port  = 7070;
my $protocol     = 'tcp';

# Finds IP address of host machine
# Connects to example site on HTTP
my $ip_finder = IO::Socket::INET->new (
    PeerAddr   => "www.google.com",
    PeerPort   => 80,
    Proto      => $protocol
) or die "The IP can not be resolved: $!\n";

# The found IP address of Host
my $ip_address = $ip_finder->sockhost;

# Creating TCP socket for server
my $server = IO::Socket::INET->new (
    LocalPort   => $listen_port,
    Proto       => $protocol,
    Listen      => 5,
    Reuse       => 1
) or die "Socket could not be created, failed with error: $!\n";

print "Socket created using $protocol: $ip_address\n";
print "Waiting for client connection on port $listen_port\n";

# Accept connection
my $client_socket = $server->accept();

# Retrieve client information
my $client_address = $client_socket->peerhost();
my $client_port    = $client_socket->peerport();
print "Client accepted: $client_address, $client_port\n";

# Open file for receiving
open(FILE, ">output.TCP")
    or die "File can not be opened: $!";
# Receiving..
while(<$client_socket>) {
    print FILE $_;
}
close FILE;

# End server
print "Closing socket...\n";
$server->close();
