#!/usr/bin/perl

# Flushing to STDOUT after each write
$| = 1;

use warnings;
use strict;
use IO::Socket;

# Client side information
my $host        = 'apollo.cselabs.umn.edu';
my $port        = 7072;
my $protocol    = 'udp';

# Creating UDP socket for client
my $client = IO::Socket::INET->new (
    PeerAddr    => $host,
    PeerPort    => $port,
    Proto       => $protocol,
    # Type        => SOCK_DGRAM
) or die "Socket could not be created, failed with error: $!\n";

# Start connection
# $client->send("Wake");


# Send gibberish
for (my $i = 0; $i < 10; $i++) {
    open(FILE, "input.UDP");
    while(<FILE>) {
        $client->send($_);
    }
    close(FILE);
 }
$client->send("End");
# sleep(10);
$client->close();
