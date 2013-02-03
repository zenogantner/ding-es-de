#!/usr/bin/perl -w

use strict;
use locale;
use POSIX qw(locale_h);

my $DEBUG = 0;

my %de_articles = (
    'der' => '{m}',
    'die' => '{f}', 
    'das' => '{n}'
);

my %es_articles = (
    "el" => "{m}",
    "la" => "{f}", 
    "los" => "{m} {pl}",
    "las" => "{f} {pl}"
);

LOOP:
while (<>) {
	if (/^#/ or /^\t*$/) {
	    print;
	    next LOOP;
	}
	my $line = $_;
	$line =~ /^(\S+.+\S+)(\s*\t\s*)(\S+.+\S+)$/ or warn "Error while parsing '$line'\n";
	my $es = $1;
	my $whitespace = $2;
	my $de = $3;

	my $plural = 0;

	if ($DEBUG) {
	    print "es: $es\n";
	    print "  split:\n";
	}
        setlocale(LC_CTYPE, "es.ISO8859-1");
	my @entries = split /; /, $es;
	my $i = @entries;
        foreach my $entry (@entries) {
    	    print "    entry '$entry'" if $DEBUG;
	    my @articles = keys %es_articles;
	    foreach my $article (@articles) {
		my $marker = $es_articles{$article};
    		if ($entry =~ s/^$article\b\s*//) {
    	    	    print " detected article '$article'.\n" if $DEBUG;
		    # put the marker in front of the category:
		    if ($entry =~ s/(\{\w+\})/$marker/) {
			$entry = "$entry $1";
		    } else {
			$entry = "$entry $marker";
		    }
	    	    print "    changed to: '$entry'" if $DEBUG;
		    
		    # if plural form, remember it to put a warning in the German part:
		    if ($article =~ /s/) {
			$plural = 1;
		    }
		}
	    }
	    # change to new category format:
	    if ($entry =~ s/\{(\w{3,}|LA|[\w\s]{5,})\}/[$1]/g) { # {xxx} (more than three x) or LA or several country markers
		print "changed to '$entry'" if $DEBUG;
	    } else {
		print "do nothing." if $DEBUG;
	    }
	    print "\noutput: '" if $DEBUG;
	    print $entry;
	    if (--$i > 0) {
		print '; ';
	    }
	    print "'\n" if $DEBUG;
	}

	print $whitespace;
	print "\n" if $DEBUG;
	
	print "de: $de\n" if $DEBUG;
	print "  split:\n" if $DEBUG;

	my $multiple_words = 0;

        setlocale(LC_CTYPE, "de.ISO8859-1");	
	my @de_entries = split /; /, $de;
	my $j = @de_entries;
        foreach my $entry (@de_entries) {
    	    print "    entry '$entry'" if $DEBUG;
	    my @articles = keys %de_articles;
	    foreach my $article (@articles) {
		my $marker = $de_articles{$article};
    		if ($entry =~ s/^$article\b\s*//) {

		    # put the marker in front of the category:
		    if ($entry =~ s/(\{\w+\})/$marker/) {
			$entry = "$entry $1";
		    } else {
			$entry = "$entry $marker";
		    }

		    # see whether there are multiple words
		    my @words =  split /\b \b/, $entry;
		    my $word_count = @words;
		    if ($word_count > 1) {
			$multiple_words = 1;
		    }

		    if (($plural == 1) and ($article =~ /die/)) {
			$plural = 2;
		    }
		}
	    }
	    print "     check for {...}: " if $DEBUG;
	    # change to new category format:
	    if ($entry =~ s/\{(\w{3,})\}/[$1]/g) {
		print "changed to '$entry'" if $DEBUG;
	    } else {
		print "do nothing." if $DEBUG;
	    }
	    print "\noutput: '" if $DEBUG;
	    print $entry;
	    if (--$j > 0) {
		print '; ';
	    }
	    print "'\n" if $DEBUG;
	}

	print "\n";
	if ($plural > 1) {
	    print "## TODO: Check whether German form is plural.\n";
	}
	if ($multiple_words) {
	    print "## TODO: Check whether adjective endings in the German form have to be altered.\n";
	}
}
