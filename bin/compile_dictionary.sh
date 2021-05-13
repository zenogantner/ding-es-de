#!/bin/bash

set -e

OUTPUT_FILE="es-de"

TMP_FILE=$(mktemp /tmp/ding-es-de.XXXXXX)
bin/compile_dictionary.pl data/*.txt > ${TMP_FILE}

VERSION="0.0i"
DATE=`date`
NUM_ENTRIES=`wc -l ${TMP_FILE}`

touch ${OUTPUT_FILE}
echo "# Spanish :: German word list" >> ${OUTPUT_FILE}
echo "# Version :: ${VERSION} ${DATE}" >> ${OUTPUT_FILE}
echo "# Copyright (c) :: Zeno Gantner <zeno.gantner\@gmail.com>, Matthias Buchmeier, and others 2003-2021" >> ${OUTPUT_FILE}
echo "# License :: GNU General Public License, Version 2 or later" >> ${OUTPUT_FILE}
echo "# License :: GNU Free Documentation License, Version 1.2 or later" >> ${OUTPUT_FILE}
echo "# License :: Creative Commons Attribution-ShareAlike License, Version 1.0" >> ${OUTPUT_FILE}
echo "# URL :: https://github.com/zenogantner/ding-es-de" >> ${OUTPUT_FILE}
echo "# ${NUM_ENTRIES}" >> ${OUTPUT_FILE}
sort ${TMP_FILE} >> ${OUTPUT_FILE}

rm ${TMP_FILE}
