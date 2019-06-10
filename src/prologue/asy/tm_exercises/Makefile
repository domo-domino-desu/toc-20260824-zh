# Makefile for computation/src/prologue/asy/tm_exercises
# 2019-Jun-10 Jim Hefferon GPL 3

# Directory where turing-machine.rkt lives
TM_DIR=../../../scheme/prologue

# Directory where the Turing machines are
MACHINE_DIR=${TM_DIR}/machines

# Directory where tm_to_asy lives
SCRIPT_DIR=../../../../bin/turing_machine

# #1=machine filename, without extension
# #2=input (just for echo)
# #3=file family name (must be unique across all asy files in this file)
# #4=initial tape current character, inside quotes
# #5=initial tape right string, inside quotes
define create-pdfs
  @echo "Using ${1}.tm on ${2} to get file family ${3}"
  ${TM_DIR}/turing-machine.rkt -f ${MACHINE_DIR}/doubler.tm -c ${4} -r ${5} > tmp/${3}.out
  ${SCRIPT_DIR}/tm_to_asy.py -f tmp/${3}.out -o${3}
  asy ${3}
endef



doubler.asy: ${MACHINE_DIR}/doubler.tm
	@echo "Hello"
	$(call create-pdfs,doubler,2,doubler,"1","1")

# FN="doubler"
# echo "tm_exercises: doing doubler.tm on 2 to get file family ${FN}"
# ${TM_DIR}/turing-machine.rkt -f ${TM_DIR}/machines/doubler.tm -c "1" -r "1" > tmp/${FN}.out
# ${SCRIPT_DIR}/tm_to_asy.py -f tmp/${FN}.out -o${FN}
# asy ${FN}
