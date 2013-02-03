#!/usr/bin/perl -w

use strict;

# Pr�fe Eintr�ge auf typische Fehler
#  - fehlende Genus-Markierungen
#  - Semikolon ohne Leerzeichen dahinter
#  - Semikolon mit Leerzeichen davor
#  - mehrfache Leerzeichen
#  - Leerzeichen vor dem Zeilenende
#  - typgraphisch fehlerhaft gesetzte Klammerzus�tze
#  - falsche {...}-Marker (also nicht n, m, f, pl, s, adj, adv, v)
#  - unpassende Marker bzw. Fehler bei Markern
# TODO:
#  - fehlende Leerzeichen bei Anmerkunen
#  - nicht geschlossene Klammern
#  - runde Klammern vor Anmerkung
#  - mehrfacher Subeintrag (z.B. a; b :: c; d; c)
#  - Adjektiv links, Nomen rechts und umgekehrt
#  - gro�geschriebene W�rter ohne Genus-Marker
#  - Leerzeichen vor Semikolon
#  - fehlende Marker f�r Verben (nachdem sie eingef�hrt wurden)
#  - Wortarten in Liste speichern (die Liste in Datei eintrag.pl auslagern ...)

# Beispiel-Aufruf: check_entries.pl *.txt

# Korrekturen und Verbesserungsvorschl�ge an es-de@zenogantner.de

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

my @domains = ('Anatomie', 'Anrede', 'Architektur', 'Astrologie', 'Astronomie',
	       'Ballsport',
               'Basketball', 'Billard', 'Biologie', 'Botanik', 'Chemie',
	       'Computer',
	       'Eisenbahn', 'Elektronik',
	       'Element', 'Essen', 'Film', 'Fu�ball', 'Gastronomie', 'Geld',
               'Golf', 'Grammatik', 'Informatik', 'Kampfkunst', 'Kartenspiel',
               'Kleidung', 'Klima', 'Kunst', 'K�che', 'Linguistik', 'Literatur',
	       'Mannschaftssport',
	       'math.', 'med.', 'Medizin', 'Milit�r', 'Musik', 'Mythologie',
	       'Optik', 'Person', 'Pflanze', 'Philosophie',
    	       'Physik', 'Politik', 'Post', 'Religion', 'Schach', 'Schuhe',
	       'Schwimmen',
	       'Sport',
	       'Stoff', 'Technik', 'Telekommunikation', 'Tennis', 'Theater',
	       'Typographie',
	       'Wetter', 'Zoologie', 'zool.');

my @markers_de = ('Schweiz', '�sterreich', 'S�ddeutschland', 'Norddeutschland',
                  'Ostdeutschland', 'Bayern', 'alte Rechtschreibung',
		  'abwertend', 'ugs.', 'fig.', 'vulg.',
                  'amtlich', 'inkorrekt', 'modern', 'veraltet');

my @markers_es = ('Esp.', 'Can.', 'Ext.', 'Mad.',
                  'Am.', 'Am. Mer.',
	          'Arg.', 'Bol.', 'Chile', 'Col.', 'Cuba', 'C. Rica',
                  'Ecuad.', 'El Salv.', 'Hond.', 'M�x.', 'Nic.', 'Par.',
                  'Per�', 'Ur.', 'Ven.',
	          'pey.', 'vulg.', 'coloq.', 'fig.');

my %domains;
foreach my $domain (@domains) {
    $domains{$domain} = 1;
}
my %markers_de;
foreach my $marker (@markers_de) {
    $markers_de{$marker} = 1;
}
my %markers_es;
foreach my $marker (@markers_es) {
    $markers_es{$marker} = 1;
}


LOOP:
while (<>) {
	next LOOP if /^#/;
	next LOOP if /^$/;
	my $line = $_;
#	$line =~ /^(.+\S+) :: (.+\S+)$/ or warn "Konnte Zeile nicht parsen: $line\n";
	$line =~ /^(.+) :: ([^\\]+)( (\\.*))?$/ or warn "Konnte Zeile nicht parsen: $line\n";

	my $es = $1;
	my $de = $2;

	my $es_count = &check_genus($es);
        my $de_count = &check_genus($de);
	if (($es_count == 0 && $de_count > 0) ||
	    ($es_count > 0 && $de_count == 0)) {
	    print "F�r eine Sprache fehlen Genus-Marker: $line";
	}
	
	if ($line =~ /;[^ ]| ;}/) {
	    print "Semikolon falsch gesetzt: $line";
	}

	if ($line =~ / {2,}/) {
	    print "Mehr als ein Leerzeichen: $line";
	}

	if ($line =~ / $/) {
	    print "Leerzeichen vor dem Zeilenende: $line";
	}
	
	if ($line =~ /[^ ](\{.+\}|\[.+\])/) {
	    print "Kein Leerzeichen vor {..}- oder [..]-Marker: $line";
	}

	if ($line =~ /(\{.+\}|\[.+\])[^\s;]/) {
	    print "Kein Leerzeichen oder Semikolon nach {..}- oder [..]-Marker: $line";
	}

	if ($line =~ /\{([^\}]+)\}/g) {
	    unless ($1 =~ /^(n|m|f|pl|s|adj|adv|v|prep|Demonstrativpronomen)$/) {
		print "Falscher {...}-Marker: $line";
	    }
	}

        while ($de =~ /\[([^\]]+)\]/g) {
	    unless ( (defined $markers_de{$1}) ||
	             (defined $domains{$1}) ) {
		if (defined $markers_es{$1}) {
		    print "Spanischer Marker im deutschen Teil: $de\n";
		} else {
		    print "Unbekannter Marker '$1': $de\n";
		}
	    }
        }

        while ($es =~ /\[([^\]]+)\]/g) {
	    unless (defined $markers_es{$1}) {
		if (defined $markers_de{$1}) {
		    print "Deutscher Marker im spanischen Teil: $es\n";
		} elsif (defined $domains{$1}) {
		    print "Domain-Marker im spanischen Teil: $es\n";
		} else {
		    print "Unbekannter Marker '$1': $es\n";
		}
	    }
        }

	
	
}

sub check_genus {
    my $string = shift;

    my $genus = '\{(m|f|n)\}';
    my $gender_count = 0;
    while ($string =~ /$genus/g) {
        $gender_count++;
    }
    my $entry_count = ($string =~ tr/;//) + 1;
    if ($gender_count > 0) {
        if ($gender_count < $entry_count) {
	    print "Eintrag hat zu wenige Genus-Marker: ";
	    print "$string\n";
	}
    }
    
    return $gender_count;
}
