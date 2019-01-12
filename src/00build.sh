#!/bin/bash
# LaTeX the Computation book and answers

usage()
{
cat << EOF
usage: $0 options

Generate book.pdf for Jim Hefferon's _Theory of Computation_.

OPTIONS:
   -h      Show this message
   -r      Regenerating; don't run Asymptote, etc. (used for development)
   -n      No answer file is generated (for development)
   -v      Verbose
EOF
}

# The bug that gives the reason for this has been fixed;
#   see https://github.com/vectorgraphics/asymptote/issues/77
ASY=asy -nosafe   

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
      $ASY cover
    cd ../..
    # For the prologue chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for prologue"
     fi
    cd prologue/asy
      cd circlediagram
      $ASY circlediagram
      $ASY infloop
      cd ..
      cd gates
      $ASY gates
      cd ..
      cd life
      bash ./run_life.sh
      $ASY lifegraphics
      cd ..
      cd tape
      $ASY tapeadd
      cd ..
    cd ../..
    # background chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for background"
     fi
    cd background/asy
      cd arctan
      $ASY arctan
      cd ..
      cd aristotle
      $ASY aristotle
      cd ..
      cd busybeaver
      $ASY busybeaver
      cd ..
      cd correspondences
      $ASY correspondences
      cd ..
      cd flowcharts
      $ASY flowcharts
      cd ..
      cd galileo
      $ASY galileo
      cd ..
      cd hp
      $ASY hp
      cd ..
      cd indexsets
      $ASY indexsets
      cd ..
      cd hp
      $ASY hp
      cd ..
      cd maps
      $ASY maps
      cd ..
      cd memory
      $ASY memory
      cd ..
    cd ../..
    # languages chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for languages"
     fi
    cd languages/asy
      cd graphs
      $ASY graphs
      cd ..
      cd parsetree
      $ASY parsetree
      cd ..
    cd ../..
    # automata chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for automata"
     fi
    cd automata/asy
      cd fsa
      $ASY fsa
      cd ..
      cd machine
      $ASY machine
      cd ..
      cd min
      $ASY min
      cd ..
      cd nfsm
      $ASY nfsm
      cd ..
      cd pda
      $ASY pda
      cd ..
      cd regex
      $ASY regex
      cd ..
    cd ../..
    # complexity chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating graphics from asy files for complexity"
     fi
    cd complexity/asy
      cd bigo
      $ASY bigo
      cd ..
      cd complexity
      $ASY complexity
      cd ..
      cd pnp
      $ASY pnp
      cd ..
      cd problems
      $ASY problems
      cd ..
      cd xygraphs
      $ASY xygraphs
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

