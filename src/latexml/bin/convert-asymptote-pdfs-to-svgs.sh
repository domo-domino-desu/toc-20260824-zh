# /bin/bash
# convert-asymptote-to-svgs.sh
# Convert the pdf output from Asymptote to svg for presenting on the web.  Run
# whenever the .pdf's change.
#
# LICENSE
#  Public Domain
#
# EXECUTION
# Run as here.  This saves the output for examination in the .out file. 
# jim@millstone:~/Documents/computing/src/latexml/bin$ ./convert-asymptote-pdfs-to-svgs.sh &> convert-asymptote-pdfs-to-svgs.out
# Note that the script can take five minutes.
#
# HISTORY
#  2022-Nov-13  Jim Hefferon Create.

THIS_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )  # path to this .sh file
# echo "THIS_SCRIPT_DIR is $THIS_SCRIPT_DIR"
LATEXML_DIR="$THIS_SCRIPT_DIR/.."  # path below which will go the .svg's
# echo "LATEXML_DIR is $LATEXML_DIR"


SRC_DIR=$THIS_SCRIPT_DIR/../..  # path to computing/src
# echo "SRC_DIR is $SRC_DIR"
# echo ""

# In most cases there is a chapter name, then an asy/ dir, then a bunch of
# subdirs, and in them is where the pdf's are. (No asy's under preface/)
for chapter_dir in "prologue" \
		       "background" \
		       "languages" \
		       "automata" \
		       "complexity"; do
    echo " "
    echo "================ chapter_dir is ${chapter_dir}"
    cd "${SRC_DIR}/${chapter_dir}"
    echo "  ... about to do asy loop, now in "
    pwd
    for d in $(find "asy" -maxdepth 1 -mindepth 1 -type d)
    do
	echo ""
	echo "---- at top of asy loop"
	# Skip exceptional directories
	echo "  d is ${d}"
	dest_dirbasename="${d##*/}" # delete up to last "/"
	echo "  dest_dirbasename is ${dest_dirbasename}"
	if [ "${dest_dirbasename}" = "fsm_exercises" ]
	then
	    echo "  !!! skipping the directory ${dest_dirbasename}"
	    continue
	fi
	#
	pdf_dir="${SRC_DIR}/${chapter_dir}/${d}"
	svg_dir="${LATEXML_DIR}/${chapter_dir}/${d}"
	abspath=$(readlink -e ${pdf_dir})  # easier to read for debugging
	echo "   pdf_dir is ${abspath}"
	abspath=$(readlink -e ${svg_dir})  # easier to read for debugging
	echo "   svg_dir is ${abspath}"
	# Change to the .pdf's directory
	cd "${pdf_dir}"
        # Make sure svg directory exists
	mkdir -p "${svg_dir}"
	echo "    ----> inside pdf directory: ";
	pwd
	for f in $(find . -type f -name "*.pdf")
	do
	    bname=${f##*/}
	    # echo "      basename is $bname"
	    cmd_string="dvisvgm --verbosity=1 --pdf $f --stdout > ${svg_dir}/${bname%.pdf}.svg"
	    echo "+++++ running: $cmd_string"
	    eval " $cmd_string"
	done
    done
    cd $THIS_SCRIPT_DIR
done


# ===========================================
# There are a couple of exceptional cases.


# Appendix: appendix/asy does not have subdirs
chapter_dir="appendix"
echo " "
echo "================ chapter_dir is ${chapter_dir}"
pdf_dir="${SRC_DIR}/${chapter_dir}/asy"
svg_dir="${LATEXML_DIR}/${chapter_dir}/asy"
mkdir -p "${svg_dir}"  # readlink needs the dir to exist
abspath=$(readlink -e ${pdf_dir})  # easier to read for debugging
echo "   for appendix, pdf_dir is ${abspath}"
abspath=$(readlink -e ${svg_dir})  # easier to read for debugging
echo "   for appendix, svg_dir is ${abspath}"
# Change to the .pdf's directory
cd "${pdf_dir}"
echo "    ----> inside pdf directory: ";
pwd
for f in $(find . -type f -name "*.pdf")
do
    bname=${f##*/}
    # echo "      basename is $bname"
    cmd_string="dvisvgm --verbosity=1 --pdf $f --stdout > ${svg_dir}/${bname%.pdf}.svg"
    echo "+++++ running: $cmd_string"
    eval " $cmd_string"
done
cd $THIS_SCRIPT_DIR


# automata/asy/fsm_exercises is not where the pdf files are
chapter_dir="automata"
echo " "
echo "================ chapter_dir is ${chapter_dir}"
pdf_dir="${SRC_DIR}/${chapter_dir}/asy/fsm_exercises/pdfs"
svg_dir="${LATEXML_DIR}/${chapter_dir}/asy/fsm_exercises/pdfs"
mkdir -p "${svg_dir}"  # readlink needs the dir to exist
abspath=$(readlink -e ${pdf_dir})  # easier to read for debugging
echo "   for appendix, pdf_dir is ${abspath}"
abspath=$(readlink -e ${svg_dir})  # easier to read for debugging
echo "   for appendix, svg_dir is ${abspath}"
# Change to the .pdf's directory
cd "${pdf_dir}"
echo "    ----> inside pdf directory: ";
pwd
for f in $(find . -type f -name "*.pdf")
do
    bname=${f##*/}
    # echo "      basename is $bname"
    cmd_string="dvisvgm --verbosity=1 --pdf $f --stdout > ${svg_dir}/${bname%.pdf}.svg"
    echo "+++++ running: $cmd_string"
    eval " $cmd_string"
done
cd $THIS_SCRIPT_DIR
