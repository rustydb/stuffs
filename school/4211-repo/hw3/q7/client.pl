#!/usr/bin/perl

# Flushing to STDOUT after each write
$| = 1;

use warnings;
use strict;
use IO::Socket::INET;
use Time::HiRes qw( gettimeofday tv_interval );

# Regular Expression to find server
my $re1 = '(bunc0035)';	# Alphanum
my $re2 = '.*?';	# Non-greedy match on filler
my $re3 = '((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))(?![\\d])';	# IPv4 IP Address
my $re4 = '.*?';	# Non-greedy match on filler
my $re5 = '(9054)';	# Integer Number
# Combine regexs
my $re  = $re1 . $re2 . $re3 . $re4 . $re5;

# Fetch server list and find self
my $serverlist = &dir_fetch;
my @myserver;
if ($serverlist =~ m/$re/is) {
    push(@myserver, $1);
    push(@myserver, $2);
    push(@myserver, $3);
}

# Globals
my ($start, $end); # Timers
my $ipaddr          = $myserver[1];
my $client_ipaddr   = &host;
my $port            = $myserver[2];
my $file            = "10MBfile.dat";
my $protocol        = "tcp";
my ($filename)      = ($file =~ /([^\\\/]+)[\\\/]*$/gs);

# Check if 10MBfile.dat exists
if(! -s $file) {
    die "10MBfile.dat is is missing..."
}
my $filesize        = -s $file;

# Connect and send five times
for (my $i = 1; $i <= 5; $i++) {
    # Creating TCP socket for client
    my $socket = IO::Socket::INET->new (
        PeerAddr    =>  $ipaddr,
        PeerPort    =>  $port,
        Proto       =>  $protocol,
        Reuse       =>  1,
    ) or die "Socket could not be created, failed with error: $!\n";

    print "TCP connection $i established!\n";
    # Notify and send filename
    print $socket "filename\n";
    print $socket "$filename\n";
    # Notify and send filesize
    print $socket "filesize\n";
    print $socket "$filesize\n";

    # Open and send specified file, begin timer
    $start = [gettimeofday]; # start timer
    print $socket "HIC\n";
    open FILE, "$file";
    while (<FILE>) {
        print $socket $_;
    }
    close FILE;
    $end = tv_interval($start); # end timer, find difference
    # Set record in DB
    db_set($end);
    # End connection
    $socket->close();
}

# Fetch records and print to file "records.txt"
&db_fetch;

##########
#  Subs  #
##########

# Resolve external IP
sub host {
    my $ip_finder = IO::Socket::INET->new (
        PeerAddr    => "www.google.com",
        PeerPort    => 80,
        Proto       => $protocol,
    ) or die "The IP can not be resolved: $!\n";
    # The found IP address of Host
    $client_ipaddr = $ip_finder->sockhost;
}

# Fetches server list from DIR
sub dir_fetch {
    my $reg = IO::Socket::INET->new (
        PeerAddr    =>  "apollo.cselabs.umn.edu",
        PeerPort    =>  9080,
        Proto       =>  $protocol,
    ) or die "Failed to make socket for directory registration: $!\n";
    unless($reg->connected) {
        die "Connection dropped: $!\n";
    }
    fprint($reg, "serverlist\r\n");
# Uncomment to create file "servers" in order to see serverlist
# Remember to then comment out lines 115 & 116. Code will not
# connect to the server and work, but the server list will be
# dumped to servers 
#    open(FILE, ">servers.txt");
#    while(<$reg>) {
#        print FILE $_;
#    }
#    close FILE;
    my $responses = <$reg>;
    $responses;
}

# Stores performance records in DB
sub db_set {
    my $reg = IO::Socket::INET->new (
        PeerAddr    =>  "apollo.cselabs.umn.edu",
        PeerPort    =>  9090,
        Proto       =>  $protocol,
    ) or die "Failed to make socket for database: $!\n";
    unless($reg->connected) {
        die "Connection dropped: $!\n";
    }
    fprint($reg, "setrecord bunc0035 $client_ipaddr $ipaddr $port $end\r\n");
    my $response = <$reg>;
    # Print for screen shot
    print $response;
    $response;
}

# Fetches records from DB
sub db_fetch {
    my $reg = IO::Socket::INET->new (
        PeerAddr    =>  "apollo.cselabs.umn.edu",
        PeerPort    =>  9090,
        Proto       =>  $protocol,
    ) or die "Failed to make socket for directory registration: $!\n";
    unless($reg->connected) {
        die "Connection dropped: $!\n";
    }
    fprint($reg, "getrecord\r\n");
    open(FILE, ">records.txt");
    while(<$reg>) {
        print FILE $_;
    }
    close FILE;
}

# Prints to STDOUT and to provided fh
# Format: printf({fh} {string})
sub fprint {
    my ($fh, $msg) = @_;
    print $fh $msg;
    print $msg;
    return;
}
