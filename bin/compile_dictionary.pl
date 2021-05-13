#!/usr/bin/perl -w

use strict;

# Lese ding-Files ein und ordne alles alphabetisch.
# Exakt identische Einträge werden als Fehler gemeldet oder ignoriert.
# Themen-Tags werden entfernt.

# Beispiel-Aufruf: compile_dictionary.pl data/*.txt > es-de

# Parameter:
#  --mark-double-entries     markiere Doppeleinträge (ansonsten werden sie
#                            ignoriert)

# Korrekturen und Verbesserungsvorschläge an zeno.gantner@gmail.com

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

my $mark_double_entries = 0;
if (defined $ARGV[0]) {
    if ($ARGV[0] eq '--mark-double-entries') {
	$mark_double_entries = 1;
	shift @ARGV;
    }    
}

my @dict;

LOOP:
while (<>) {
	next LOOP if /^#/;
	next LOOP if /^$/;
	my $line = $_;
	$line =~ /^(.+) :: ([^\\]+)( (\\.*))?$/ or warn "Konnte Zeile nicht parsen: $line\n";

	my $es = $1;
	my $de = $2;
	chomp $de;
	my $tags = $3;
	# do something with it

	my $entry = $es." :: ".$de."\n";

	push @dict, $entry;
}


my @ordered = sort @dict;
my @filtered;
my $old_entry = '';
foreach my $entry (@ordered) {
    unless ($entry eq $old_entry) {
        push @filtered, $entry;
    } else {
    	push @filtered, "# DOUBLE ENTRY: $entry" if $mark_double_entries;
    }
    $old_entry = $entry;
}

foreach my $entry (@filtered) {
    print $entry;
}
