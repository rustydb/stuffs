#! /usr/bin/perl

use strict;
use warnings;
use feature qw/ say /;
use File::Copy;

my $dpbx = "/media/mufasa/Dropbox/Camera Uploads";
my $toLG = "$dpbx/toLG";

opendir(DH, $dpbx);
my @photos = readdir(DH);
closedir(DH);

say "Starting...";
sleep(3);
foreach my $photo (@photos) {
    # skip . and ..
    next if ($photo =~ /^\./);
    next if ($photo =~ /-\d?\./);
    next if ($photo =~ /toLG/);
    say "Before: $dpbx/$photo";
    my $new_name = $photo;
    $new_name =~ s/-//g;  # Remove '-'
    $new_name =~ s/ /_/; # Make ' ' a '_'
    $new_name =~ s/\.(\d)/$1/g; # Remove '.'
    if ($new_name !~ /\d{8}_\d{6}\.(png|jpg|mp4)/) {
        say "Wrong: $new_name";
        exit 1;
    }
    copy("$dpbx/$photo", "$toLG/$new_name")
        or die "Copy failed: $!";
    say "After: $toLG/$new_name";
}

