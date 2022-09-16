#! /bin/bash
# Count lines of code in various files
find . -iname "*.tex" -or -iname "*.asy" -or -iname "*.sty" -iname "*.cls" | xargs wc -l
