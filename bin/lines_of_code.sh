#! /bin/bash
# Count lines of code in various files
find . -iname "*.tex" -or -iname "*.asy" -or -iname "*.sty" -iname "*.cls" -iname "*.rkt" -iname "*.sh" | xargs wc -l
