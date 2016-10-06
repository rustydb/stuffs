#!/usr/bin/perl

use strict;
use warnings;

my @array;

if(!@array) {
    print "Array is undefined\n";
}

for (my $i = 0; $i < 10; $i++) {
    $array[$i] = $i;
}

if(@array) {
    print "Array contains values after the forloop\n";
}

undef @array;

if(@array) {
    print "Array contains values after the undef\n";
} else {
    print "Array should be blank\n";
}
