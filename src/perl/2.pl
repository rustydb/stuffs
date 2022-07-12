#!/usr/bin/perl

use strict;
use warnings;
use Math::Trig;


#Circumfrence
print "Please enter a radius of a circle: ";
my $radius = <STDIN>;
if($radius < 0) {
	print "The circumfrence is: 0\n";
	exit;
}
my $circum = $radius * 2 * pi;
print "The circumfrence is: ". $circum ."\n";

#Product
print "Enter in A: ";
my $a = <STDIN>;
print "Enter in B: ";
my $b = <STDIN>;
print "The product of AxB is: " . $a*$b . "\n";

#Stringss
print "Enter a string: ";
my $string = <STDIN>;
print "Enter a multiplier: ";
my $multi = <STDIN>;
print $string x $multi;
