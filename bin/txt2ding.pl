#!/usr/bin/perl -w

use strict;

# Dieses kurze Skript konvertiert Textdateien, in denen die Vokabeln
# durch Tabulatoren getrennt sind, in das von ding gelesene Format
# (Trennung durch zwei Doppelpunkte).
# Die Eingabe erfolgt über die Standard-Eingabe oder von Dateien, deren
# Namen als Parameter übergeben werden.
# Die konvertierten Einträge werden auf der Standardausgabe ausgegeben.
# Leerzeilen sowie Zeilen, die mit dem Zeichen # beginnen, werden ignoriert.

# Beispiel-Aufruf: txt2ding *.txt > es-de

# Korrekturen und Verbesserungsvorschläge an es-de@zenogantner.de

# (c) 2003, 2005, 2006 by Zeno Gantner
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

my $keep_comments = 0;
if (defined $ARGV[0]) {
    if ($ARGV[0] eq '--keep-comments') {
	$keep_comments = 1;
	shift @ARGV;
    }    
}

my $keep_empty_lines = 0;
if (defined $ARGV[0]) {
    if ($ARGV[0] eq '--keep-empty-lines') {
	$keep_empty_lines = 1;
	shift @ARGV;
    }    
}


LINE:
while (<>) {

	if (/^#/) {
		if ($keep_comments) {		
			print;
		}
		next LINE;
	}

	if (/^$/) {
		if ($keep_empty_lines) {
			print;
		}
		next LINE;
	}

	my $line = $_;
	$line =~ s/\s*\t\s*/ :: / or warn "Nichts ersetzt: $line\n";
	print $line;
}
