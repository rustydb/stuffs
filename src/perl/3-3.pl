#!/usr/bin/perl

use strict;
use warnings;

chomp(my @input = <STDIN>);
# print (sort @input);
@input = sort @input;
foreach my $item (@input) {
    print $item . "\n";
}