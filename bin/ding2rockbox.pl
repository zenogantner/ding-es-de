#!/usr/bin/perl -w

use strict;

# Convert from ding format to the Rockbox dictionary format.
# After running the program, the results must be sorted alphabetically.
#
# example: ./ding2rockbox.pl --lowercase es-de | sort -d > es-de.rdf
#

# Please send bugfixes and suggestions to es-de@zenogantner.de

# (c) 2006 by Zeno Gantner
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

use locale;

my $lowercase = 0;
if ($ARGV[0] eq '--lowercase') {
    shift @ARGV;
    $lowercase = 1;
}

LOOP:
while (<>) {
	next LOOP if /^#/;
	next LOOP if /^$/;

	my $line = $_;
	my @lines;
	if ($line =~ /\|/) { # if there are sub-entries, split them up
	    $line =~ /(.+) :: (.+)/ or warn "Problem parsing line: $line\n";
	    my @lang1 = split(/ \| /, $1);
	    my @lang2 = split(/ \| /, $2);
	    if ($#lang1 == $#lang2) {
		for (my $i = 0; $i < @lang1; $i++) {
		    push(@lines, "$lang1[$i] :: $lang2[$i]\n");
		}
	    } else {
		warn "Problem parsing line, expected the same number";
		warn "of sub-entries on both sides: $line\n";
	    } # else
	} else {    # otherwise just put the line in the list
	    push(@lines, $_);
	} # else
	foreach $line (@lines) {
	    $line =~ s/ :: /\t/ or warn "Problem parsing line: $line\n";
	    if ($lowercase) {
		$line = lc $line;
	        # TODO: handle Unicode (UTF-8) characters
	    } # if
	    print $line;
	} # foreach
} # while
