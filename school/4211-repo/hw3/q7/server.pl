#!/usr/bin/perl

# Flushing to STDOUT after each write
$| = 1;

use warnings;
use strict;
use IO::Select;
use IO::Socket;

# Server side information
my $ipaddr      = &host;
my $port        = 9054;
my $protocol    = "tcp";
my ($client_address, $client_port);

# Server registration & cleanup 
 my $pid = fork;
 $SIG{INT}     = \&reaper;
 # $SIG{__DIE__} = \&reaper;
 if(!$pid) {
     while(1) {
         &register;
         sleep(10);
     }
 }

# Creating TCP socket for server
my $server = IO::Socket::INET->new (
    LocalPort   => $port,
    Proto       => $protocol,
    Listen      => 5,
    Reuse       => 1,
) or die "Socket could not be created, failed with error: $!\n";
print "Socket created using $protocol: $ipaddr\n";

# Adds the server socket as the first handle
my $sel = IO::Select->new($server);

#  Inifinite loop for connecting clients
print "Waiting for client connection on port $port\n";
while(1) {
    # Checks if a client is ready to connect
    # If so, adds client into an array
    if(my @can_read = $sel->can_read(1)) {
        foreach my $fh (@can_read) {
            my $cmd;
            if($fh == $server) {
                # Accept client and do things
                my $client = $server->accept;
                $sel->add($client);
                # Retrieve client information
                $client_address = $client->peerhost();
                $client_port    = $client->peerport();
                print "Client accepted: $client_address, $client_port\n";
            } else {
                my ($filename, $filesize);
                $cmd = <$fh>;
                if($cmd =~ /^filename/) {
                    chomp($filename = <$fh>);
                    print "Preparing to receive: $filename\n";
                    $cmd = <$fh>;
                }
                if($cmd =~ /^filesize/) {
                    chomp($filesize = <$fh>);
                    print "File size is: $filesize\n";
                    $cmd = <$fh>;
                }
                if($cmd =~ /^HIC/) {
                    open(FILE, ">out/$filename") or die "File can not be opened: $!";
                    # Receiving...
                    while(<$fh>) {
                        print FILE $_;
                    }
                    close FILE;
                    # print $server "200 Success\n";
                    if($filesize != -s "out/$filename") {
                        print "File received is corrupt\n";
                    }
                }
                print "End of connection\n";
                $sel->remove($fh);
                $fh->close;
            }
        }
    }
}

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
    $ip_finder->sockhost;
}

# Registers Server
sub register {
    my $reg = IO::Socket::INET->new (
        PeerAddr    =>  "apollo.cselabs.umn.edu",
        PeerPort    =>  9080,
        Proto       =>  $protocol,
        Timeout     =>  120,
    ) or die "Failed to make socket for directory registration: $!\n";
    unless($reg->connected) {
        die "Connection dropped: $!\n";
    }
    fprint($reg, "Register bunc0035 $ipaddr $port\r\n");
    my $response = <$reg>;
    print $response;
    $response;
}

# Prints to STDOUT and to provided fh
# Format: printf({fh} {string})
sub fprint {
    my ($fh, $msg) = @_;
    print $fh $msg;
    print $msg;
    return;
}

# Kills children
 sub reaper {
     my ($sig, $msg) = @_;
     # warn "Got sig $sig";
     kill INT => if(!$pid);
     wait if($pid);
     exit;
 }
