#! /usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;

my ($man, $help) = 0;

GetOptions(
    'help|?'    => \$help,
    man         => \$man,
    start     => \&start,
    'delete=s'  => \&delete,
) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(
    -exitval => 0,
    -verbose => 2,
) if $man;

sub start {
    print "Started\n";
}

sub delete {
    my $to_delete = shift;
    print "Deleting $to_delete";
}
