#!/bin/bash
# LaTeX the Computation book and answers

# Generate the book; run it twice to settle any future references
pdflatex book
makeindex -s book.ist -p odd book.idx
biber book
pdflatex book
pdflatex answers
pdflatex answers

