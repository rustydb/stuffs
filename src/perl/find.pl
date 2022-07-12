#! /usr/bin/perl

use strict;
use warnings;
use File::Find;

my $test_dest = '/tmp/test';
my $test_src = '/Users/rbunch/Pictures';

sub wanted {
    link $File::Find::name, "$test_dest/$_"
        or print "$!\n";
}

find(\&wanted, $test_src);
