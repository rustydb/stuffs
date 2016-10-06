#!/usr/bin/perl

use strict;
use warnings;

my %dir = (
    "fred" => "flintstone", 
    "barney" => "rubble",
    "wilma" => "flintstone",
    );

print "Please enter a name: ";
chomp(my $name = <STDIN>);
if($dir{$name}) {
    print $dir{$name}."\n";
} else {
    print "Provided name is not in directory\n";
}