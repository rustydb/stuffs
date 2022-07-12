#!/usr/bin/env perl

use warnings;

my $undef = undef;
print $undef; # prints the empty string "" and raises a warning

# implicit undef :
my $undef2;
print $undef2; # prints "" and raises same warning

my $num = 4040.5;
print "$num\n"; # "4040.5"

my $string = "world";
print "$string\n"; # "world"

my $str1 = "4G";
my $str2 = "4H";

print $str1 .  $str2; # "4G4H"
print $str1 +  $str2; # "8" with two warnings
print $str1 eq $str2; # "" (empty, i.e. false)
print $str1 == $str2; # "1" with two warnings

# The classic error
print "yes" == "no"; # "1" with two warnings. Both values eval to 0

# Numerical operators: <. ?, <=, >=, ==, !=, <=>, +, *
# String operators: lt, gt, le, ge, eq, ne, cmp, ., x

my @array = (
    "print\n",
    "these\n",
    "strings\n",
    "out\n",
    "for\n",
    "me\n", # trailing a coma is okay
    );

print $array[0]; # "print"
print $array[1]; # "these"
print $array[2]; # "strings"
print $array[3]; # "out"
print $array[4]; # "for"
print $array[5]; # "me"
print $array[6]; # returns undef, prints "" and raises a warning

# negative indices go backwards
print $array[-1]; # "me"
print $array[-2]; # "for"
print $array[-3]; # "out"
print $array[-4]; # "strings"
print $array[-5]; # "these"
print $array[-6]; # "print"
print $array[-7]; # returns undef, prints "" and raises a warning
