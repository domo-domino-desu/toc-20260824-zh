# Makefile for computation/src/prologue/asy/tm_exercises
# 2019-Jun-10 Jim Hefferon GPL 3

# Directory where turing-machine.rkt lives
TM_DIR=../../../scheme/prologue

# Directory where the Turing machines are
MACHINE_DIR=${TM_DIR}/machines

# Directory where tm_to_asy lives
SCRIPT_DIR=../../../../bin/turing_machine

# create-pdfs  Macro to create pdf's from asy
#  It puts them in the pdfs subdir. It stores in the tmp subdir the output
#  of the TM simulator.
# #1=machine filename, without extension
# #2=input (just for echo)
# #3=file family name (must be unique across all asy files in this file)
# #4=initial tape current character, inside quotes
# #5=initial tape right string, inside quotes
define create-pdfs
  @echo "Using ${1}.tm on ${2} to get file family ${3}"
  ${TM_DIR}/turing-machine.rkt -f ${MACHINE_DIR}/${1}.tm -c ${4} -r ${5} > tmp/${3}.out
  ${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef

# create-pdfs-leavebs
# Like the prior macro but the --blanks option is not used in tm_to_asy.py
# so the tapes will have B's in them.
define create-pdfs-leavebs
  @echo "Using ${1}.tm on ${2} to get file family ${3}"
  ${TM_DIR}/turing-machine.rkt -f ${MACHINE_DIR}/doubler.tm -c ${4} -r ${5} > tmp/${3}.out
  ${SCRIPT_DIR}/tm_to_asy.py -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef



all: textbody seconeexercises



### ========= These are for the text body ===================

textbody: pdfs/pred.asy pdfs/add.asy

pdfs/pred.asy: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,3,pred,"1","11")

pdfs/add.asy: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,2 and 3,add,"1","1 111")




### ========= These are for exercises for first section ===================

seconeexercises: pdfs/doubler.asy

pdfs/doubler.asy: ${MACHINE_DIR}/doubler.tm
	$(call create-pdfs-leabebs,doubler,2,doubler,"1","1")

