#!/usr/bin/perl

use strict;
use warnings;
use Cwd qw/abs_path/;

my ($user, $answer);
my (@args, @lines);

die "ERROR: Specify username, \"full name\", and email to be sent to.\n" if @ARGV < 1;
die "Must run as root\n" if $> != 0;
my $path = abs_path();
die "Path was not in /var/scripts but: $path\n" if ("$path" ne '/var/scripts');
$user = $ARGV[0];
print "You want to delete user $user? [Y/n]: ";
if (chomp($answer = <STDIN>) eq "n") {
    print "Canceling\n";
    exit(1);
}
# unmount shared drive
@args = ("umount", "/home/$user/openswim");
if (system(@args) != 0) {
    die "system @args failed $?";
}

# Remove user and home directory
undef @args;
@args = ("userdel", "-r", "$user");
if (system(@args) != 0) {
    die "system @args failed $?";
}

# Edit fstab
&editfstab($user);
undef @args;

# fstab subroutine
sub editfstab {
    my $user = shift;
    open FILE, "/etc/fstab"
        or die "Could not open fstab: $!";
    @lines = <FILE>;
    close FILE;
    rename "/etc/fstab", "/etc/fstab.old"
        or die "Could not rename old fstab";
    open FILE, ">/etc/fstab"
        or die "Could not create new fstab";
    foreach my $line (@lines) {
        print FILE $line unless ($line =~ /$user/);
    }
    close FILE;
    print "Done\n";
}
