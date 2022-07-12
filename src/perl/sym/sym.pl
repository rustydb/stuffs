#! /usr/bin/perl

use strict;
use warnings;
use Carp;
use feature qw/ say /;

if (-e 'test_sym') {
    my $unlink_success = unlink 'test_sym';
    unless ($unlink_success) {
        croak "Unable to remove test_sym link before creating new symlink";
    } else {
        say "Removed old link";
    }
}
my $symlink_exists = symlink('test', 'test_sym');
unless ($symlink_exists) {
    croak "Could not make test_sym link: $!";
} else {
    say "test_sym link was created";
}

#unless (-l 'test_sym') {
    #my $symlink_exists = symlink('test', 'test_sym');
#} else {
    #print "Sym exists\n";
#}
