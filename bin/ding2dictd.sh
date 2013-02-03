#!/bin/bash
#
function compiledict { 
source=$1
target=$2
echo "compiling "$2".dict"
awk -f ./bin/ding2dictd.awk $source|dictfmt -f \
-s "es-de-ding" -u "http://savannah.nongnu.org/projects/ding-es-de" \
--utf8  --columns 0 --without-headword --headword-separator :: $target
#dictzip $target.dict
}
#
compiledict $1 $2
