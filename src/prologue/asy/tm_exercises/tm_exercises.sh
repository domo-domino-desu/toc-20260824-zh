#!/bin/bash
# tm_exercises.sh
#  Create the .asy files for the exercises on Turing machines, and run
# Asymptote on those files.

# Directory where turing-machine.rkt lives
TM_DIR="../../../scheme/prologue"
# Directory where tm_to_asy lives
SCRIPT_DIR="../../../../bin/turing_machine"

# pred.tm on an empty tape
echo "doing: pred.tm on an empty tape"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/pred.tm -c "1" -r "1111" > tmp/pred.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/pred.out -opred
asy pred
