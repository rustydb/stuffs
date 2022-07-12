#!/usr/bin/perl

use strict;
use warnings;
use Benchmark qw(:all);

my ($chap, $make);
my ($t0, $t1, $td);

# Allow for smaller compiling
foreach my $a(@ARGV) {
    if($a eq "-s") {
        print "Enter chapter number that you want compiled\n";
        do {
            chomp($chap = <STDIN>);
            if(-d "test_chapter" . $chap) {
                $make = "make chapter" . $chap;
            } else {
                print "Chapter specified does not exist, enter in another\n"
            }
        } until (defined($make));
    } else {
        $make = "make";
    }
}

# Get local time for report
my @time        = localtime(time);
my $reporttime  = $time[2] . ":" . $time[1] . ":" . $time[0];

# Intro the wonderful user
print   "Times will be displayed in STDOUT and in \"times.txt\"\n",
        "\nRunning \"make clean\"...\n\n";
`make clean`;

# Open file for formatted times and print ready statement
open FILE, ">>", "times.txt" or die $!;
print "Ready, set Makefile to Cray compiler and press enter\n";
<STDIN>;

# Test with CCE
$t0 = Benchmark->new;
`$make >& cce.out`;
$t1 = Benchmark->new;
$td = timediff($t1, $t0);
printf FILE "$reporttime:\nCray: %3s", timestr($td) . "\n";
print "\aCray Compiler Time: ", timestr($td), "\n\nRunning \"make clean\"\n\n";
`make clean`;

# Test with GNU (assuming the makefile was changed by the user)
print "Ready, set Makefile to GNU compiler and press enter\n";
<STDIN>;
$t0 = Benchmark->new;
`$make >& gnu.out`;
$t1 = Benchmark->new;
$td = timediff($t1, $t0);
printf FILE "GNU: %4s", timestr($td) . "\n\n";
print "\aGNU Compiler Time: ". timestr($td), "\n\nRunning \"make clean\"\n\n";
`make clean`;

# Close file and finish program
print "Finished, cleaning up with \"make clean\"\n\n";
close FILE;

