#! /bin/bash
# Count lines of code in various files
cd ../src
rm answerbody.tex # contains a lot of LOC that is redundant on chapter sources
find . -iname "*.tex" -or -iname "*.asy" -or -iname "*.sty" -iname "*.cls" -iname "*.rkt" -iname "*.sh" -iname "Makefile" | xargs wc -l
