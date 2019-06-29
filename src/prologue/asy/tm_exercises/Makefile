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
# #6=max number steps to run TM simulation
MAX_STEPS_DEFAULT=100
define create-pdfs
  @echo "Using ${1}.tm on ${2} to get file family ${3}"
  ${TM_DIR}/turing-machine.rkt -f ${MACHINE_DIR}/${1}.tm -c ${4} -r ${5} -s ${6} > tmp/${3}.out
  ${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef

# create-pdfs-leavebs
# Like the prior macro but the --blanks option is not used in tm_to_asy.py
# so the tapes will have B's in them.
define create-pdfs-leavebs
  @echo "Using ${1}.tm on ${2} to get file family ${3}"
  ${TM_DIR}/turing-machine.rkt -f ${MACHINE_DIR}/doubler.tm -c ${4} -r ${5}  -s ${6} > tmp/${3}.out
  ${SCRIPT_DIR}/tm_to_asy.py -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef



all: textbody topicexercises seconeexercises sectionfourexercises



### ========= These are for the text body ===================

textbody: pdfs/pred.asy pdfs/add.asy

pdfs/pred.asy: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,3,pred,"1","11",${MAX_STEPS_DEFAULT})

pdfs/add.asy: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,2 and 3,add,"1","1 111",${MAX_STEPS_DEFAULT})




### ========= These are for Topic exercises ===================

topicexercises: pdfs/pred_five.asy pdfs/pred_empty.asy pdfs/doubler.asy \
	pdfs/addonetwo.asy pdfs/addzerotwo.asy pdfs/addzerozero.asy  \
	pdfs/addthree_four.asy pdfs/addthree_zero.asy

pdfs/pred_five.asy: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,5,pred_five,"1","1111",${MAX_STEPS_DEFAULT})

pdfs/pred_empty.asy: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,empty tape,pred_empty," ","",${MAX_STEPS_DEFAULT})

pdfs/addonetwo.asy: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,1 and 2,addonetwo,"1"," 11",${MAX_STEPS_DEFAULT})

pdfs/addzerotwo.asy: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,0 and 2,addzerotwo," ","11",${MAX_STEPS_DEFAULT})

pdfs/addzerozero.asy: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,0 and 0,addzerozero," ","",${MAX_STEPS_DEFAULT})

pdfs/addthree_four.asy: ${MACHINE_DIR}/addthree.tm
	$(call create-pdfs,addthree,4,addthree_four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/addthree_zero.asy: ${MACHINE_DIR}/addthree.tm
	$(call create-pdfs,addthree,0,addthree_zero," ","",${MAX_STEPS_DEFAULT})





### ========= These are for section one exercises ===================

seconeexercises: pdfs/pred_two.asy pdfs/addtwotwo.asy pdfs/infloop.asy \
	pdfs/infloop.asy pdfs/mystery11.asy pdfs/mystery1011.asy \
        pdfs/mystery110.asy pdfs/mystery1101.asy pdfs/mysteryempty.asy \
        pdfs/blankones.asy pdfs/constantthree.asy pdfs/doubler.asy \
	pdfs/doublerbinary.asy pdfs/odd_three.asy pdfs/odd_four.asy \
	pdfs/successor.asy pdfs/leq.asy pdfs/bitwisenot.asy \
	pdfs/singlebitnot.asy pdfs/singlebitand.asy pdfs/singlebitor.asy \
	pdfs/append01.asy pdfs/addany.asy pdfs/palindromeabba.asy \
	pdfs/palindromeaba.asy pdfs/twobsabba.asy pdfs/twobsaba.asy

pdfs/pred_two.asy: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,2,pred_two,"1","1",${MAX_STEPS_DEFAULT})

pdfs/addtwotwo.asy: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,2 and 2,addtwotwo,"1","1 11",${MAX_STEPS_DEFAULT})

pdfs/infloop.asy: ${MACHINE_DIR}/infloop.tm
	$(call create-pdfs,infloop,blank tape,infloop," ","",10)

pdfs/mystery11.asy: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,11,mystery11,"1","1",10)

pdfs/mystery1011.asy: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,1011,mystery1011,"1","011",10)

pdfs/mystery110.asy: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,110,mystery110,"1","10",10)

pdfs/mystery1101.asy: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,1101,mystery1101,"1","101",10)

pdfs/mysteryempty.asy: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,empty tape,mysteryempty," ","",10)

pdfs/blankones.asy: ${MACHINE_DIR}/blankones.tm
	$(call create-pdfs,blankones,2,blankones,"1","1",${MAX_STEPS_DEFAULT})

pdfs/constantthree.asy: ${MACHINE_DIR}/constantthree.tm
	$(call create-pdfs,constantthree,2,constantthree,"1","1",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/doubler.asy: ${MACHINE_DIR}/doubler.tm
	$(call create-pdfs-leavebs,doubler,2,doubler,"1","1",${MAX_STEPS_DEFAULT})

pdfs/doublerbinary.asy: ${MACHINE_DIR}/doublerbinary.tm
	$(call create-pdfs,doublerbinary,6,doublerbinary,"1","10",${MAX_STEPS_DEFAULT})

pdfs/odd_three.asy: ${MACHINE_DIR}/odd.tm
	$(call create-pdfs,odd,3,odd_three,"1","11",${MAX_STEPS_DEFAULT})

pdfs/odd_four.asy: ${MACHINE_DIR}/odd.tm
	$(call create-pdfs,odd,4,odd_four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/successor.asy: ${MACHINE_DIR}/successor.tm
	$(call create-pdfs,successor,3,successor,"1","11",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/leq.asy: ${MACHINE_DIR}/leq.tm
	$(call create-pdfs-leavebs,leq,2 and 3,leq,"1","1 111",${MAX_STEPS_DEFAULT})

pdfs/bitwisenot.asy: ${MACHINE_DIR}/bitwisenot.tm
	$(call create-pdfs,bitwisenot,6,bitwisenot,"0","110",${MAX_STEPS_DEFAULT})

pdfs/singlebitnot.asy: ${MACHINE_DIR}/singlebitnot.tm
	$(call create-pdfs,singlebitnot,0,singlebitnot,"0","",${MAX_STEPS_DEFAULT})

pdfs/singlebitand.asy: ${MACHINE_DIR}/singlebitand.tm
	$(call create-pdfs,singlebitand,01,singlebitand,"0","1",${MAX_STEPS_DEFAULT})

pdfs/singlebitor.asy: ${MACHINE_DIR}/singlebitor.tm
	$(call create-pdfs,singlebitor,01,singlebitor,"0","1",${MAX_STEPS_DEFAULT})

pdfs/append01.asy: ${MACHINE_DIR}/append01.tm
	$(call create-pdfs,append01,11,append01,"1","1",${MAX_STEPS_DEFAULT})

# DUMMY keeps Bash from interpreting the comma in the string.
DUMMY = "1,1,11"
pdfs/addany.asy: ${MACHINE_DIR}/addany.tm
	$(call create-pdfs,addany,11 then 1 then 11,addany,"1",${DUMMY},${MAX_STEPS_DEFAULT})

pdfs/palindromeabba.asy: ${MACHINE_DIR}/palindrome.tm
	$(call create-pdfs,palindrome,abba,palindromeabba,"a","bba",${MAX_STEPS_DEFAULT})

pdfs/palindromeaba.asy: ${MACHINE_DIR}/palindrome.tm
	$(call create-pdfs,palindrome,aba,palindromeaba,"a","ba",${MAX_STEPS_DEFAULT})

pdfs/twobsabba.asy: ${MACHINE_DIR}/twobs.tm
	$(call create-pdfs,twobs,abba,twobsabba,"a","bba",${MAX_STEPS_DEFAULT})

pdfs/twobsaba.asy: ${MACHINE_DIR}/twobs.tm
	$(call create-pdfs,twobs,aba,twobsaba,"a","ba",${MAX_STEPS_DEFAULT})






### ========= These are for section I.4 exercises ===================

sectionfourexercises: pdfs/mu_ex1zero.asy pdfs/mu_ex1one.asy \
	pdfs/mu_ex1two.asy pdfs/mu_ex1three.asy pdfs/mu_ex1four.asy \
	pdfs/mu_ex1five.asy

pdfs/mu_ex1zero.asy: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,0,mu_ex1zero,"0","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1one.asy: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,1,mu_ex1one,"1","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1two.asy: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,2,mu_ex1two,"1","1",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1three.asy: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,3,mu_ex1three,"1","11",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1four.asy: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,4,mu_ex1four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1five.asy: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,5,mu_ex1five,"1","1111",${MAX_STEPS_DEFAULT})



