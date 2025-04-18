#!/bin/bash
# LaTeX the Computation book and answers
LATEX=pdflatex

# Generate the book; run it twice to settle any future references
${LATEX} book
makeindex -s book.ist -p odd book.idx
biber book
${LATEX} book
# ${LATEX} answers
# biber answers
# ${LATEX} answers

