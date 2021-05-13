Spanisch-Deutsche Vokabelsammlung für ding
------------------------------------------

Diese Sammlung ist unter Umständen noch nicht vollständig und alltagstauglich.
Es kann sein, dass Du sehr einfache und grundlegende Wörter nicht
findest. Sollte dies der Fall sein, so wäre ich über eine Benachrichtigung
an zeno.gantner@gmail.com sehr dankbar.

Auch wenn ich mich um die Korrektheit der Einträge bemühe, kann ich sie nicht
garantieren.


Die neueste Ausgaben des Pakets und der Vokabelliste gibt es hier:
http://github.com/zenogantner/ding-es-de



Struktur dieses Pakets
----------------------

Die Vokabeln sind nach Wortfeldern in verschiedene Dateien im Verzeichnis
data/ verteilt.

Vokabeln, die nicht unter einem bestimmten Wortfeld eingeordnet wurden,
stehen in den Dateien "Allgemein.txt", "Konjunktionen.txt", "Präpositionen.txt",
"Pronomen.txt" und "Verben-Allgemein.txt".

Weitere Informationen befinden sich im Verzeichnis `doc/`.


Installation
------------

1. Richte in [ding](https://www-user.tu-chemnitz.de/~fri/ding/) eine Suchmethode ein, indem Du im Menü "Einstellungen"
   das Element "Suchmethoden..." auswählst. Dann klicke auf "Neu"->"Dictionary".
   Es erscheint ein neues Fenster, wo die nötigen Einstellungen vornehmen
   kannst, z.B.:

```
     Name		es <-> de
     Such-Kommando	egrep
     Optionen		-h

     Wörterbuch		(die Datei es-de, die im selben Verzeichnis wie
                         dieses README sein sollte)

     Sprache 1:		Spanisch
     Trennzeichen:	::
     Sprache 2:		Deutsch

     ... und so weiter
```

   Dann auf "Übernehmen" klicken.

2. Durch den Aufruf von "Einstellungen"->"Einstellungen speichern" wird die neue Suchmethode dauerhaft gespeichert.

Optional:

3. Erneutes Generieren der Wörterbuchdatei aus den Quelldateien.

   Führe im Verzeichnis `ding-es-de/` (in dem auch diese Datei liegt)
   folgenden Befehl aus:

   `bin/compile_dictionary.pl data/*.txt > es-de`

   Dies erzeugt eine neue Datei mit dem Namen `es-de`, bzw. überschreibt sie, falls sie schon existiert.


Fehler, Beiträge, usw.
----------------------

Wenn Du einen Fehler (falsche Vokabel, Rechtschreibung, unklare Dokumentation usw.) findest, schicke mir bitte eine Nachricht an zeno.gantner@gmail.com, damit ich den Fehler berichtigen kann.

Außerdem freue ich mich immer über neue Worfelder bzw. zusätzliche Vokabeln für die existierenden.
Die Vokabeln dürfen allerdings nicht aus vorhandenen Sammlungen/Wörterbüchern herauskopiert werden, da unter Umständen die Urheberrechte der Autoren dieser Werke verletzt werden.
Du musst die Vokabeln, die Du mir zuschickst, selbst zusammengetragen haben.


Danke
-----

 - Matthias Buchmeier (ca. 4700 Einträge, die mit "a" bis "c" beginnen)
 - Elena García Aguado (Korrekturen)
 - all meinen Spanischlehrerinnen
 - Frank Richter (Autor von ding)
 - Simon Kmiecik (zusätzliche Vokabeln und Korrekturen)
 - Sebastian Bauer (Entwickler von MobileDing, siehe doc/MobileDing.txt)
 - Jan (Hinweise zum README)
 - Nikolai Löwen (zusätzliche Vokabeln und Korrekturen)
 - Andrei Mitrofanow (Hinweise auf fehlende Vokabeln)
 - Gero Gudschun (Korrekturen und Vokabeln)
 - Emmanuel Dammerer (Ausbau des Wortfeldes Himmel/Astronomie)
 - Klaus Meinke (Ausbau des Wortfeldes Mathematik, weitere Ergänzungen)
 - Björn Jacke, Santiago Rodríguez und Jesús Carretero (Autoren der Wortlisten, mit denen ding-es-de auf Rechtschreibfehler geprüft wird)
 - Kevin Atkinson (GNU Aspell)
 - Larry Wall (Perl)
 - Mike Haertel und Paul Eggert (GNU textutils)
 - Free Software Foundation (Hosting des Projekts auf savannah.nongnu.org)


Copyright-Hinweis
-----------------

(C) 2003, 2004, 2005, 2006, 2021 by Zeno Gantner and others

Die Skripte im Verzeichnis bin/ können unter den Bedingungen der GNU General
Public License, Version 2 oder später, wie von der Free Software Foundation
herausgegeben, verwendet, modifziert und/oder verbreitet werden.

Die restlichen Dateien können unter den Bedingungen von GNU FDL und/oder
GNU GPL, wie von der Free Software Foundation herausgegeben, sowie unter
den Bedingungen der "Creative Commons Attribution-ShareAlike License",
herausgegeben von CreativeCommons.org, verwendet, modifiziert und/oder
verbreitet werden.

Sie können eine oder mehrere der folgenden Lizenzen wählen:
 * GNU Free Documentation License, Version 1.2 oder später
 * GNU General Public License, Version 2 oder später
 * Creative Commons Attribution-ShareAlike License, Version 1.0 oder später

GNU FDL 1.2, GNU GPL 2, Creative Commons Attribution-ShareAlike License  1.0
sollten diesem Paket beiliegen, falls nicht, können Sie unter
http://www.gnu.org/ bzw. http://creativecommons.org den Text der Lizenzen
einsehen.

Dort finden Sie auch (rechtlich nicht bindende) Übersetzungen der Lizenzen.

