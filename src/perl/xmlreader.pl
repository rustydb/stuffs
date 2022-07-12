#!/usr/bin/perl

use strict;
use warnings;
use XML::Simple;

my $file = shift or die <<USAGE;

Usage: $0 <xmlfile> [label] [0|1]
Where;
    <xmlfile> is the path/name of the .xml file to parse.
    [label] is the base of the references as output (default:'\$xml->').
    [0|1] indicate whether to append the contents of the tags. (default:0 (no)).

    Parses an XML file using XML::Simple and (if the doc is well-formed) outputs the perl references to access the elements of the structure,
    optionally appending the contents of the tags.
USAGE

my $xml = XMLin( $file, parseropts => [ ErrorContext => 1, ], forcearray => 0, );

sub walk {
    my ($label,  $valuesFlag) = (shift||"xml->", shift||0);
    my ($output, $tab) = ( "", ".   ");
    foreach my $thing (shift) {
        if ( ref($thing) eq "HASH" ) {
            $output .= ( !ref ${$thing}{$_}  )
                      ? "$label\{$_\}" .
                        ( $valuesFlag
                        ? " := ${$thing}{$_}\n"
                        : "\n" )
                       : walk( $label . "{$_}", $valuesFlag, ${$thing}{$_} )
                foreach  ( keys %$thing );
        }
        if ( ref($thing) eq "ARRAY" ) {
            $output .= ( !ref @{$thing}[$_]  )
                    ?  "$label\[$_\] " .
                        ( $valuesFlag
                        ? " := @{$thing}[$_]\n"
                         : "\n" )
                    : walk( $label . "[$_]", $valuesFlag, @{$thing}[$_] )
                foreach  ( 0..  @{$thing} -1  );
        }
        $output .= " := $thing\n" if ( ref $thing eq "SCALAR" );
    }
    return $output;
}

(my $label= shift) =~ s/^(.+)+$/$1->/;
#print $label . "\n";
print walk $label, shift||0, $xml;
