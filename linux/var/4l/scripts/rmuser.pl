#!/usr/bin/perl
# Description:
# Remove a user made by adduser.pl.
# ~rusty
use strict;
use warnings;
use Cwd qw/abs_path/;
# TODO: Add smbpassword delete for Samba if added to adduser.pl.

# Verify user before working code.
die "Must run as root\n" if $> != 0;

# Globals.
die "ERROR: Specify username\n" if @ARGV < 1;
my $user = $ARGV[0];
my $answer;
my (@args, @lines);

# Get path.
my $path = abs_path();
die "Path was not in /var/4l/scripts but: $path\n" if ("$path" ne '/var/4l/scripts');

# Confirm deletion.
print "You want to delete user $user? [Y/n]: ";
if (chomp($answer = <STDIN>) eq "n") {
    print "Canceling\n";
    exit(1);
}

# Unmount shared drive.
@args = ("umount", "/home/$user/openswim");
if (system(@args) != 0) {
    die "system @args failed $?";
}

# Remove user and home directory.
undef @args;
@args = ("userdel", "-r", "$user");
if (system(@args) != 0) {
    die "system @args failed $?";
}

# Edit fstab.
&editfstab($user);
print "Done\n";

# Removes the user from the fstab.
sub editfstab {
    my $removed_user = shift;
    open FILE, "/etc/fstab"
        or die "Could not open fstab: $!";
    @lines = <FILE>;
    close FILE;
    rename "/etc/fstab", "/etc/fstab.old"
        or die "Could not rename old fstab";
    open FILE, ">/etc/fstab"
        or die "Could not create new fstab";
    foreach my $line (@lines) {
        print FILE $line unless ($line =~ /$removed_user/);
    }
    close FILE;
}
