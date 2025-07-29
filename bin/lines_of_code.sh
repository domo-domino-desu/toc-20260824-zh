#! /bin/bash
# Count lines of code in various files
cd ../src
find . -iname "*.tex" -or -iname "*.asy" -or -iname "*.sty" -iname "*.cls" -iname "*.rkt" -iname "*.sh" -iname "Makefile" | xargs wc -l
