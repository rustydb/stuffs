#!/usr/bin/perl
# Description:
# Add a user to the local system. Sets up a temporary password, the shared mount, and emails them.
# ~rusty
use strict;
use warnings;
use Cwd qw/abs_path/;
# TODO: Add smbpassword set for Samba.

# Verify user before working code.
die "Must run as root\n" if $> != 0;

# Globals.
my ($NAME, $NEWUSER, $PASSWORD, $EMAIL, $answer);
my @random = ("A".."Z", "a".."z", 0..9);
my @args;

# Check args.
die "ERROR: Specify username, \"full name\", and email to be sent to.\n" if @ARGV < 3;
$NEWUSER = $ARGV[0];
$NAME    = $ARGV[1];
$EMAIL   = $ARGV[2];

# Get path.
my $path = abs_path();
die "Path was not in /var/4l/scripts but: $path\n" if ("$path" ne '/var/4l/scripts');

# State upcoming processes.
print "New user name will be $NEWUSER, correct? [Y/n]: ";
if (chomp($answer = <STDIN>) eq "n") {
    print "Canceling\n";
    exit(1);
}
print "New user Full Name will be $NAME, correct? [Y/n]: ";
if (chomp($answer = <STDIN>) eq "n") {
    print "Canceling\n";
    exit(1);
}
print "New user email will be sent to $EMAIL, correct? [Y/n]: ";
if (chomp($answer = <STDIN>) eq "n") {
    print "Canceling\n";
    exit(1);
}

# Generate password.
$PASSWORD .= $random[rand @random] for 1..8;

# Make the user.
@args = ("useradd", "-m", "-d", "/home/$NEWUSER", "-s",  "/bin/bash", "-g", "users", "-c", "$NAME", "$NEWUSER");
if (system(@args) != 0) {
    die "system @args failed $?";
}

# Set their password.
`echo $NEWUSER:$PASSWORD | chpasswd`;

# Prep the welcome message for the email
open TEMP, "user_mail_template.txt"
    or die "Could not open user_mail_template.txt: $!";
open MSG, ">tmp.txt"
    or die "Could not open tmp.txt: $!";
while(<TEMP>) {
    s/\$NAME/$NAME/g;
    s/\$NEWUSER/$NEWUSER/g;
    s/\$PASSWORD/$PASSWORD/g;
    print MSG $_;
}
close MSG;
close TEMP;
undef @args;

# Send email, assuming ssmtp is configured.
`ssmtp $EMAIL < tmp.txt`;

# Expire password for next login.
@args = ("passwd", "-e", "$NEWUSER");
if (system(@args) != 0) {
    die "system @args failed $?";
}

# Add openswim to fstab.
# FIXME: Use better command to prevent duplicates.
open FILE, ">>/etc/fstab"
    or die "Could not open fstab: $!";
print FILE "# $NEWUSER\n/media/mufasa/openswim                   /home/$NEWUSER/openswim none    bind         0          0\n";
close FILE;

# Make the mountpoint.
mkdir "home/$NEWUSER/openswim";

# Clean up and finish
unlink "tmp.txt";
print "Done.\nRemember to run 'mount -a' as root in order to mount the shared drive!\n";
