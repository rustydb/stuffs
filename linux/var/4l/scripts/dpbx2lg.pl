#! /usr/bin/perl
# Description:
# Transcribe the names of images auto-stored in Dropbox to the LG naming convention. Useful for restoring photos
# onto an LG phone with regards to keeping their order.
# ~rusty
use strict;
use warnings;
use feature qw/ say /;
use File::Copy;

# Setup.
die ("Need path to Camera Uploads or another photo dir. using the same format!\n") if @ARGV < 1;
my $dpbx = "$ARGV[0]";
$dpbx =~ s/\/$//;
my $toLG = "$dpbx/toLG";
my $waiting = 5;
opendir(DH, $dpbx);
my @photos = readdir(DH);
closedir(DH);

# Wait for interupt.
$| = 1;
print "Input:$dpbx\nOutput: $toLG\nStarting in...";
while ($waiting > 0) {
    print $waiting == 1 ? "$waiting!\n" : "$waiting...";
    $waiting--;
    sleep(1);
}

# Main.
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
