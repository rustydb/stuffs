#!/usr/bin/perl
use strict;
use warnings;

chomp(my $user = `whoami`);
print "hi $user.\nEnter Target Folder: ";
chomp(my $target = <STDIN>);
my @targetCN = ("ls", "$target");
system(@targetCN) == 0
	or exit;
my $targetName = `basename $target`;
print "Printing contents of $targetName: \n";
print @targetCN;
print "\nNow I will make an array of those contents, but only if you want me to...\n[y/n]: ";
chomp(my $text = <STDIN>);
# if ($text eq "y" || $text eq "yes") {
# 	my @docAr;
# 	my $size = `ls -l | grep ^- | wc -l`
# 	for (my $i = 0; $i <= $size; ++$i) {
# 		@docAr[i] = whne
# 	}
# }


# get to print error if folder does not