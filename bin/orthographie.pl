#!/usr/bin/perl -w

# Skript zum extrahieren von Wörtern in nur einer Sprache - v.a.
# für die Rechtschreibprüfung.
#
# z.B. Aufruf: ./orthographie de *.txt|aspell -l --lang=de
#
#  (dies ergibt eine Liste von Wörtern, die nach Meinung von aspell falsch
#   geschrieben sind)

# Korrekturen und Verbesserungsvorschläge an es-de@zenogantner.de

# (c) 2003, 2006 by Zeno Gantner
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

$lang = shift @ARGV;

LOOP:
while (<>) {
	next LOOP if /^#/;  # ignoriere Kommentarzeilen
	next LOOP if /^$/;  # ignoriere Leerzeilen
	    
	s/ \{(pl|s|m|f|n|adj|adv|v|prep)\}//g; # Plural-Kennzeichnung usw. herausfiltern
	# TODO: ordentliches Hash machen mit all diesen dingen -- bzw. in Modul auslagern
	s/ \[(Esp\.|Méx\.|Ecuad\.|Uru\.|Par\.|Am\.|Am\. Mer\.|Arg\.|CR|Ven\.)\]//g;
	# TODO: Sonderbehandlung für modern, slang, alte Rechtschreibung usw.
	s/ \[(vulg\.|ugs\.|coloq\.|fig\.|modern|pey\.)\]//g;

	if ( m/(.*) :: (.*)/ ){
	# Was machen bei mehr als einem Tab in einer Zeile? Warnung?

	    $es = $1;
	    $de = $2;

	  
	    if ($lang eq "es") { print "$es\n"; }
	    if ($lang eq "de") { print "$de\n"; }
	} else {
	    warn "Konnte Zeile nicht parsen: $_";
	}
}

