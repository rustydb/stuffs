#!/usr/bin/perl

use strict;
use warnings;

my @list = qw/ 1 3 5 7 9 /;
my $list_total = &total(@list);
print "The total of \@list is $list_total\n";
my $user_total = &total(<STDIN>);
print "The \$user_total is $user_total\n";
my $big_sum = &total(1..1000);
print "The sum from 1-1000 is $big_sum\n";

sub total {
    my $sum;
    foreach (@_) {
        $sum += $_;
    }
    $sum;
}