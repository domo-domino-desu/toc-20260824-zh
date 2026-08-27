#!/bin/bash
# LaTeX the Theory of Computation book and answers
LATEX=lualatex

# Generate the book; run it twice to settle any future references
${LATEX} book
# Add the traditional joke index entry that points to itself
# Get the page by compiling, then finding how many pages are
# frontmatter, numbered with roman type, and subtract.
echo "\indexentry{recursion|hyperpage}{434}" >> book.idx
# Make the index
makeindex -s book.ist -p odd book.idx
# Make the bibliography
biber book
${LATEX} book
# Compile the answers
${LATEX} answers
biber answers
${LATEX} answers
