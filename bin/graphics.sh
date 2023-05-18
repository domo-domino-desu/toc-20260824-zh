#! /bin/bash
# Estimate graphic files
dirs=( ../src/asy
       ../src/cover
       ../src/prologue/asy
       ../src/prologue/pix
       ../src/background/asy
       ../src/background/pix
       ../src/languages/asy
       ../src/languages/pix
       ../src/automata/asy
       ../src/automata/pix
       ../src/complexity/asy
       ../src/complexity/pix
       ../src/appendix/asy
     )

find "${dirs[@]}" -iname "*.pdf" -or -iname "*.jpg" -or -iname "*.png" | wc -l
