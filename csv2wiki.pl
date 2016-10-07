#!/usr/bin/perl

# csv2wiki.pl - By Andrew Van Lahr <drew@ammomfg.com>
#
# csv2wiki.pl is a simple perl script that converts the elements of a CSV 
# (comma-separated value) to a wiki table format. This makes it much easier to 
# cut and paste data into a wiki page without having to manually format and
# manualy re-enter the data. 
#
# This software is distrubuted as is with no warranties under the 
# GNU GPLv3 license.

use strict;

if (!@ARGV)
 {
  die "USAGE: csv2wiki.pl <input CSV> <output .wiki>\n";
 }

my $inputfile = $ARGV[0];
my $outputfile = $ARGV[1];

open (INPUT, "$inputfile") || die "CAN'T OPEN INPUT FILE: $inputfile\n";
open (OUTPUT, ">$outputfile") || die "CAN'T OPEN OUTPUT FILE: $outputfile\n";

my $output;
$output = "{| class=\"wikitable\"\n";
my $count;

while (my $line = <INPUT>)
 {
  if ($count < 1)
   {
    $output .= "|-\n! ";
    $line =~ s/,/\n\! /g;
    $output .= $line;
   }
  if ($count > 0)
   {
    $output .= "|-\n| ";
    $line =~ s/,/\n\| /g;
    $output .= $line;
   }                  
  $count++;
 }
 
$output .= "|}\n";

print OUTPUT $output;

close(INPUT);
close(OUTPUT);
