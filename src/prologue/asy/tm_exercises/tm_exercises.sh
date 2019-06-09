#!/bin/bash
# tm_exercises.sh
#  Create the .asy files for the exercises on Turing machines, and run
# Asymptote on those files.
# 2019-Jun-05 Jim Hefferon GPL3  For Computation text.

# Directory where turing-machine.rkt lives
TM_DIR="../../../scheme/prologue"
# Directory where tm_to_asy lives
SCRIPT_DIR="../../../../bin/turing_machine"

### ========= These are for the text body ===================

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




### ========= These are for the Topic exercises ===================


# pred.tm on 5
FN="pred_five"
echo "tm_exercises: doing pred.tm on 5 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/pred.tm -c "1" -r "1111" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}

# pred.tm on an empty tape
FN="pred_empty"
echo "tm_exercises: doing pred.tm on an empty tape to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/pred.tm -c "B" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# addtwo.tm on 1 and 2 
FN="addonetwo"
echo "tm_exercises: doing addtwo.tm on 1 and 2 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/addtwo.tm -c "1" -r " 11" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# addtwo.tm on 0 and 2 
FN="addzerotwo"
echo "tm_exercises: doing addtwo.tm on 0 and 2 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/addtwo.tm -c " " -r "11" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# addtwo.tm on 0 and 0 
FN="addzerozero"
echo "tm_exercises: doing addtwo.tm on 0 and 0 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/addtwo.tm -c " " > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# addthree.tm on 4 
FN="addthree_four"
echo "tm_exercises: doing addthree.tm on 4 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/addthree.tm -c "1" -r "111" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# addthree.tm on 0 
FN="addthree_zero"
echo "tm_exercises: doing addthree.tm on 0 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/addthree.tm -c " " > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}




### ========= These are for the first section exercises ===================


# pred.tm on 2
FN="pred_two"
echo "tm_exercises: doing pred.tm on 2 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/pred.tm -c "1" -r "1" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# addtwo.tm on 2 and 2 
FN="addtwotwo"
echo "tm_exercises: doing addtwo.tm on 1 and 2 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/addtwo.tm -c "1" -r "1 11" > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# infloop.tm on blank tape, for ten steps
FN="infloop"
echo "tm_exercises: doing infloop.tm on blank tape to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/infloop.tm -c " " -s 10 > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# mystery.tm on 11, for ten steps
FN="mystery11"
echo "tm_exercises: doing mystery.tm on 11 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/mystery.tm -c "1" -r "1" -s 10 > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# mystery.tm on 1011, for ten steps
FN="mystery1011"
echo "tm_exercises: doing mystery.tm on 1011 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/mystery.tm -c "1" -r "011" -s 10 > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# mystery.tm on 110, for ten steps
FN="mystery110"
echo "tm_exercises: doing mystery.tm on 110 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/mystery.tm -c "1" -r "10" -s 10 > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# mystery.tm on 1101, for ten steps
FN="mystery1101"
echo "tm_exercises: doing mystery.tm on 1101 to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/mystery.tm -c "1" -r "101" -s 10 > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}


# mystery.tm on empty string, for ten steps
FN="mysteryempty"
echo "tm_exercises: doing mystery.tm on empty tape to get file family ${FN}"
${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/mystery.tm -c " " -s 10 > tmp/${FN}.out
${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${FN}.out -o${FN}
asy ${FN}
