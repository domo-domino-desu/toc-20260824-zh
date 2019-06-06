#!/bin/bash
# tm_exercises.sh
#  Create the .asy files for the exercises on Turing machines, and run
# Asymptote on those files.
# 2019-Jun-05 Jim Hefferon GPL3  For Computation text.

# Directory where turing-machine.rkt lives
TM_DIR="../../../scheme/prologue"
# Directory where tm_to_asy lives
SCRIPT_DIR="../../../../bin/turing_machine"


# pred.tm on 3 (for text body)
FN="pred"
echo "tm_exercises: doing pred.tm on 3 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/pred.tm -c "1" -r "11" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}

# addtwo.tm on 2 and 3 (for text body)
FN="addtwo"
echo "tm_exercises: doing addtwo.tm on 2 and 3 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/addtwo.tm -c "1" -r "1 111" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}

# pred.tm on an empty tape
FN="pred_empty"
echo "tm_exercises: doing pred.tm on an empty tape to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/pred.tm -c "B" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}
