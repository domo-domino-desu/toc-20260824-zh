#!/bin/bash
# LaTeX the Computation book and answers
LATEX=pdflatex

# Generate the book; run it twice to settle any future references
${LATEX} book
makeindex -s book.ist -p odd book.idx
# Can't figure out how to have both creferences to numberedwithin "Lemma" and Index numbers, so doing the first, and have a script to compensate for the second
# ../bin/compilation/repage_index.py book.ind > book_ind.repaged 
# cp book_ind.repaged book.ind
# biber book
# ${LATEX} book
# ${LATEX} answers
# biber answers
# ${LATEX} answers

