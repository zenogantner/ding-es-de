BEGIN {FS=" :: ";}
/^[#]/ {
# first 2 lines are considered BD-description by dictfmt
	if(FNR<=2) print $0;
# keep the rest lines beginning with # as they are
	if(FNR>2) print $1"\n "$0;
	next;
	}
/^[^#]/ {
indx=$0;
#rm {...}, [...] (...)
gsub(/\{[^}]*}/, "", indx);
gsub(/\([^)(]*)/, "", indx);
gsub(/\([^)(]*)/, "", indx);
gsub(/\[[^][]*]/, "", indx);
# convert ,;| -> ::
gsub(/[;,\|]/, "::", indx);
# rm multiple ::
gsub(/[\:][\:]+/, "::", indx);
# rm extraspace after and before ::
gsub(/[ ]*[\:][\:][ ]*/, "::", indx)
print indx;
print " "$1"\n\t"$2;
}
