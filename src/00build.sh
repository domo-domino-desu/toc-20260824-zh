#!/bin/bash
# LaTeX the Computation book and answers

usage()
{
cat << EOF
usage: $0 options

Generate book.pdf for Hefferon's _Theory of Computation_.

OPTIONS:
   -h      Show this message
   -r      Regenerating; don't run Asymptote, etc. (used for development)
   -n      No answer file is generated (for development)
   -v      Verbose
EOF
}

REGENERATING=
NOANSWERFILE=
VERBOSE=
while getopts “hrnv” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         n)
             NOANSWERFILE=1
             ;;
         r)
             REGENERATING=1
             ;;
         v)
             VERBOSE=1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

# Generate the Asymptote figures, and other external files
# If you get the error that you cannot import node then you have to
# set ASYMPTOTE_DIR; see the INSTALL file.
if [[ -z $REGENERATING ]] 
then
    # For the cover
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for cover"
     fi
    cd cover/asy
      asy cover
    cd ../..
    # For the prologue chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for prologue"
     fi
    cd prologue/asy
      cd circlediagram
      asy circlediagram
      asy infloop
      cd ..
      cd gates
      asy gates
      cd ..
      cd life
      bash ./run_life.sh
      asy lifegraphics
      cd ..
      cd tape
      asy tapeadd
      cd ..
    cd ../..
    # background chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for background"
     fi
    cd background/asy
      cd arctan
      asy arctan
      cd ..
      cd aristotle
      asy aristotle
      cd ..
      cd busybeaver
      asy busybeaver
      cd ..
      cd correspondences
      asy correspondences
      cd ..
      cd flowcharts
      asy flowcharts
      cd ..
      cd galileo
      asy galileo
      cd ..
      cd hp
      asy hp
      cd ..
      cd indexsets
      asy indexsets
      cd ..
      cd hp
      asy hp
      cd ..
      cd maps
      asy maps
      cd ..
      cd memory
      asy memory
      cd ..
    cd ../..
    # languages chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for languages"
     fi
    cd languages/asy
      cd graphs
      asy graphs
      cd ..
      cd parsetree
      asy parsetree
      cd ..
    cd ../..
    # automata chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for automata"
     fi
    cd automata/asy
      cd fsa
      asy fsa
      cd ..
      cd machine
      asy machine
      cd ..
      cd min
      asy min
      cd ..
      cd nfsm
      asy nfsm
      cd ..
      cd pda
      asy pda
      cd ..
      cd regex
      asy regex
      cd ..
    cd ../..
    # complexity chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for complexity"
     fi
    cd complexity/asy
      cd bigo
      asy bigo
      cd ..
      cd complexity
      asy complexity
      cd ..
      cd pnp
      asy pnp
      cd ..
      cd problems
      asy problems
      cd ..
      cd xygraphs
      asy xygraphs
      cd ..
    cd ../..
fi

# Generate the book; run it twice to settle future references
pdflatex book
# makeindex -s book.isty -p odd book.idx
biber book
pdflatex book

Generate answer file
if [[ -z $NOANSWERFILE ]] 
then
    pdflatex answers
    pdflatex answers
fi

