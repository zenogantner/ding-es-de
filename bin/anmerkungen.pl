#!/usr/bin/perl -w

# Dieses Programm gibt die in den Vokabeldateien aufgeführten Anmerkungen in
# in geschweiften Klammern { ... } alphabetisch aus, sowie die Häufigkeit
# ihres Auftretens.

# Aufruf: z.B. bin/anmerkungen.pl de data/*.txt

# Korrekturen und Verbesserungsvorschläge an es-de@zenogantner.de

# (c) 2004, 2005, 2006 by Zeno Gantner
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

use strict;

my $trennzeichen = ' :: ';

my $lang = shift @ARGV;
my %geschweift;
my %eckig;

LOOP:
while (<>) {
    next LOOP if /^#/;  # ignoriere Kommentarzeilen
    next LOOP if /^$/;  # ignoriere Leerzeilen

    my $eintrag;	    
    if ( m/(.*)$trennzeichen(.*)/ ){

	my $es = $1;
	my $de = $2;
	
	if ($lang eq "es") { $eintrag = $es; }
	if ($lang eq "de") { $eintrag = $de; }
    } else {
	warn "Fehler: $_";
    }
    
    while ($eintrag =~ /\{([^}]+)\}/g) {
        $geschweift{$1}++;
    }
    while ($eintrag =~ /\[([^\]]+)\]/g) {
        $eckig{$1}++;
    }
    
}

my @anmerkungen = keys %geschweift;
@anmerkungen = sort @anmerkungen;
print "{...}:\n";
foreach my $anmerkung1 (@anmerkungen) {
    print "\t$anmerkung1: \t$geschweift{$anmerkung1}\n";
}

@anmerkungen = keys %eckig;
@anmerkungen = sort @anmerkungen;
print "[...]:\n";
foreach my $anmerkung2 (@anmerkungen) {
    print "\t$anmerkung2: \t$eckig{$anmerkung2}\n";
}
