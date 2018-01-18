#!/bin/bash
# LaTeX the Computation book and answers

usage()
{
cat << EOF
usage: $0 options

Generate book.pdf and answers.pdf.

OPTIONS:
   -h      Show this message
   -n      Do not generate an answer file (used to speed development)
   -r      Regenerating; don't run Asymptote, etc. (used for development)
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
# If it says you cannot import node then you have to set ASYMPTOTE_DIR;
# see the INSTALL file
if [[ -z $REGENERATING ]] 
then
    # For the prologue chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating asy files for prologue"
     fi
    cd prologue/asy
      cd circlediagram
      asy circlediagram
      asy infloop
      cd ../gates
      asy gates
      cd ../tape
      asy tapeadd
      cd ../life
      bash ./run_life.sh
      asy lifegraphics
      cd ..
    cd ../..
    # background chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating asy files for background"
     fi
    cd background/asy
      cd arctan
      asy arctan
      cd ../aristotle
      asy aristotle
      cd ../correspondences
      asy correspondences
      cd ../galileo
      asy galileo
      cd ../indexsets
      asy indexsets
      cd ../hp
      asy hp
      cd ..
    cd ../..
    # automata chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating asy files for automata"
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
      cd regex
      asy regex
      cd ..
    cd ../..
    # complexity chapter
    if [[ -z $VERBOSE ]]
    then
	echo "Generating asy files for complexity"
     fi
    cd complexity/asy
      cd bigo
      asy bigo
      cd ..
    cd ../..
fi

# Generate the book; run it twice to settle future references
pdflatex book
# makeindex -s book.isty -p odd book.idx
pdflatex book

# Generate the answer file
# if [[ -z $NOANSWERFILE ]] 
# then
#     pdflatex answers
#     pdflatex answers
# fi

