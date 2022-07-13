#!/usr/bin/perl

# Flushing to STDOUT after each write
$| = 1;

use warnings;
use strict;
use IO::Socket;

# Server side information
my $listen_port     = 7072;
my $protocol        = 'udp';
my $received_data   = "";

# Finds IP address of host machine
# Connects to example site on HTTP
my $ip_finder = IO::Socket::INET->new (
    PeerAddr   => "www.google.com",
    PeerPort   => 80,
    Proto      => 'udp'
) or die "The IP can not be resolved: $!\n";

# The found IP address of Host
my $ip_address = $ip_finder->sockhost;

# Creating UDP socket for server
my $server = IO::Socket::INET->new (
    LocalPort   => $listen_port,
    Proto       => $protocol,
    # Type        => SOCK_DGRAM
) or die "Socket could not be created, failed with error $!\n";

print "Socket created using UDP: $ip_address\n";
print "Waiting for client connection on port $listen_port\n";

open(FILE, ">output.UDP")
  or die "File can not be opened: $!";

while($received_data ne "End") {
    $server->recv($received_data, 1000);
    my $peer_address = $server->peerhost();
    my $peer_port    = $server->peerport();
    print "Message was received from: $peer_address, $peer_port\n";
    # if("$received_data" eq "End") {
    #     close FILE;
    #     $server->shutdown();
    # }
    print FILE "$received_data";
}
close FILE;

print "Closing socket...\n";
$server->shutdown();