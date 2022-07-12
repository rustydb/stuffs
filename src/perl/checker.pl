#!/usr/bin/perl

# TODO: pull xml from bugzilla... yay
# Place the bugzilla xml in checkers wd and just run
# checker as is. Will take a while to complete, since
# the xml's size depends on how many query results
# there are.

use strict;
use warnings;
use XML::Simple;
use Data::Dumper;

# Parse XML file
my $xml     = new XML::Simple;
my $xmld    = $xml->XMLin("show_bug.xml");
my @bugs;
foreach $b (@{$xmld->{bug}}) {
    push(@bugs, $b->{bug_id});
}

# Get local time for report
my @time        = localtime(time);
my $reporttime  = $time[2] . $time[3] . (1 + $time[4]) . (1900 + $time[5]);

# grep -s bugs into text file in reports
# Possible problem, may have reoccuring bug description showing in
# every report
open(my $fh, '>', "$reporttime.txt");
foreach my $var (@bugs) {
    chomp $var;
    my $cmd = "grep -s $var /cray/css/compiler/cost/testing/tar_files/*.list";
    if(`$cmd`) {
        my $output = `$cmd`;
        $output = "BUG $var :\n" . $output . "\n\n";
        print $fh $output;
    }
}
close $fh;

