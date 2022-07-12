#!/usr/bin/perl
# Chapter 6-3
# Prints inputted strings with any specified column width, right justified

use strict;
use warnings;

my $width = shift(@ARGV);
printf "1234567890123456789012345678901234567890\n";
foreach my $line (@ARGV) {
	printf "%${width}s\n", $line;
}