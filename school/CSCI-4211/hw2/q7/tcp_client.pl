#!/usr/bin/perl

# Flushing to STDOUT after each write
$| = 1;

use warnings;
use strict;
use IO::Socket;

# Client side information
# Works by setting $host to server address, needs to be on same domain
my $host        = 'apollo.cselabs.umn.edu';
my $port        = 7070;
my $protocol    = 'tcp';

# Creating TCP socket for client
my $client = IO::Socket::INET->new (
    PeerHost    =>  $host,
    PeerPort    =>  $port,
    Proto       =>  $protocol
) or die "Socket could not be created, failed with error: $!\n";

print "TCP connection established!\n";

# Open and send specified file
open FILE, "10MBfile.dat";
while (<FILE>) {
    print $client $_;
}
close FILE;

# End connection
$client->close();