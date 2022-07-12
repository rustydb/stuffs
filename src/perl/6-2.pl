#!/usr/bin/perl
# Chapter 6-2
# Prints inputted strings with a 20 column width right justified

use strict;
use warnings;

print "1234567890123456789012345678901234567890\n";
foreach my $line (@ARGV) {
	printf "%20s\n", $line;
}