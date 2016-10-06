#!/usr/bin/perl

use strict;
use warnings;

my @names = qw/ Mikaela Alex Kody Russell /;
print "Please input 4 numbers (1-4) followed by
the Return key after each value. Hit CTRL^D when finished: \n"; 
chomp(my @input = <STDIN>);
foreach my $input (@input) {
    print @names[$input - 1] . "\n";
}
