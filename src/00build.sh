#!/bin/bash
# LaTeX the Computation book and answers

# tex4ht messes with this stuff
rm prologue/prologue.aux
rm background/background.aux
rm languages/languages.aux
rm automata/automata.aux
rm complexity/complexity.aux
rm appendix/appendix.aux


# Generate the book; run it twice to settle future references
pdflatex book
makeindex -s book.ist -p odd book.idx
biber book
pdflatex book
pdflatex answers
pdflatex answers

