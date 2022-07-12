#!/usr/bin/perl

use strict;
use warnings;

while(<>) {
    if (/wilma|fred/i) {
        print "Matched: \n$_";
    }
}
