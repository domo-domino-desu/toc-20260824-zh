# Makefile for computation/src/automata/asy/fsm_exercises
# 2020-Jun-15 Jim Hefferon GPL 3
#  Copied from the Turing machine scripts
# 2023-Jan-22 JH Change from .asy to .pdf for the targets.

# Directory where finite-state-machine.rkt lives
FSM_DIR=../../../scheme/automata

# Directory where the Finite State machines are
MACHINE_DIR=${FSM_DIR}/machines

# Directory where fsm_to_asy.py lives
SCRIPT_DIR=../../../../bin/fsm

# create-pdfs  Macro to create pdf's from asy
#  It puts them in the pdfs subdir. It stores in the tmp subdir the output
#  of the FSM simulator.
# #1=machine filename, without extension
# #2=input (just for echo)
# #3=file family name (must be unique across all asy files in this file)
# #4=initial tape, inside quotes
MAX_STEPS_DEFAULT=100
define create-pdfs
  @echo "Using ${1}.fsm on ${2} to get file family ${3}"
  mkdir -p tmp  # create a tmp subdir if it does not already exist
  mkdir -p pdfs  # create a pdfs subdir
  ${FSM_DIR}/finite-state-machine.rkt -f ${MACHINE_DIR}/${1}.fsm -i ${4} > tmp/${3}.out
  ${SCRIPT_DIR}/fsm_to_asy.py --blanks -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef

# create-pdfs-leavebs
# Like the prior macro but the --blanks option is not used in fsm_to_asy.py
# so the tapes will have B's in them.
define create-pdfs-leavebs
  @echo "Using ${1}.fsm on ${2} to get file family ${3}"
  mkdir -p tmp  # create a tmp subdir if it does not already exist
  mkdir -p pdfs  # create a pdfs subdir
  ${FSM_DIR}/finite-state-machine.rkt -f ${MACHINE_DIR}/${1}.fsm -i ${4} > tmp/${3}.out
  ${SCRIPT_DIR}/fsm_to_asy.py -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef



all: textbody  seconeexercises


### ========= These are for the text body ===================

textbody: pdfs/modfour000.pdf

pdfs/modfour000.pdf: ${MACHINE_DIR}/modfour.fsm
	$(call create-pdfs-leavebs,modfour,"10110",modfour,"10110")



### ========= These are for section one exercises ===================

seconeexercises: pdfs/endsinai000.pdf \
	pdfs/endsinaii000.pdf pdfs/endsinaiii000.pdf

pdfs/endsinai000.pdf: ${MACHINE_DIR}/endsina.fsm
	$(call create-pdfs,endsina,"abba",endsinai,"abba")

pdfs/endsinaii000.pdf: ${MACHINE_DIR}/endsina.fsm
	$(call create-pdfs,endsina,"bab",endsinaii,"bab")

pdfs/endsinaiii000.pdf: ${MACHINE_DIR}/endsina.fsm
	$(call create-pdfs,endsina,"bbaabbaa",endsinaiii,"bbaabbaa")



