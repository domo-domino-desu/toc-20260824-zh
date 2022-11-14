# /bin/bash
# convert-asymptote-to-svgs.sh
# Convert the pdf output from Asymptote to svg for presenting on the web.
#
# LICENSE
#  Public Domain
#
# HISTORY
#  2022-Nov-13  Jim Hefferon Create.

THIS_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "THIS_SCRIPT_DIR is $THIS_SCRIPT_DIR"
LATEXML_DIR="$THIS_SCRIPT_DIR/.."
echo "LATEXML_DIR is $LATEXML_DIR"


SRC_DIR=$THIS_SCRIPT_DIR/../..
echo "SRC_DIR is $SRC_DIR"

for chapter_dir in "preface" \
		       "prologue" \
		       "background" \
		       "languages" \
		       "automata" \
		       "complexity" \
		       "appendix"; do
    cd "${SRC_DIR}/${chapter_dir}"
    for d in $(find "asy" -maxdepth 1 -mindepth 1 -type d)
    do
	dest_dirname="${d##/}"
	echo "dest_dirname is ${dest_dirname}"
	dest_dirpath="${LATEXML_DIR}/${chapter_dir}/${d##/}"
	echo "dest_dirpath is ${dest_dirpath}"
	mkdir -p "$dest_dir"
	cd "$d"
	echo "  inside directory $d"
	for f in $(find . -type f -name "*.pdf")
	do
	    bname=${f##*/}
	    echo "      basename is $bname"
	    echo "dvisvgm -pdf $f -stdout > ${dest_dirpath}/${bname%.pdf}.svg"
	done
    done
    cd $THIS_SCRIPT_DIR
done
