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
  ${TM_DIR}/turing-machine.rkt -f ${MACHINE_DIR}/${1}.tm -c ${4} -r ${5}  -s ${6} > tmp/${3}.out
  ${SCRIPT_DIR}/tm_to_asy.py -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef



all: textbody topicexercises seconeexercises sectionfourexercises



### ========= These are for the text body ===================

textbody: pdfs/pred.pdf pdfs/add.pdf

pdfs/pred.pdf: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,3,pred,"1","11",${MAX_STEPS_DEFAULT})

pdfs/add.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,2 and 3,add,"1","1 111",${MAX_STEPS_DEFAULT})




### ========= These are for Topic exercises ===================

topicexercises: pdfs/pred_five.pdf pdfs/pred_empty.pdf pdfs/doubler.pdf \
	pdfs/addonetwo.pdf pdfs/addzerotwo.pdf pdfs/addzerozero.pdf  \
	pdfs/addthree_four.pdf pdfs/addthree_zero.pdf

pdfs/pred_five.pdf: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,5,pred_five,"1","1111",${MAX_STEPS_DEFAULT})

pdfs/pred_empty.pdf: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,empty tape,pred_empty," ","",${MAX_STEPS_DEFAULT})

pdfs/addonetwo.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,1 and 2,addonetwo,"1"," 11",${MAX_STEPS_DEFAULT})

pdfs/addzerotwo.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,0 and 2,addzerotwo," ","11",${MAX_STEPS_DEFAULT})

pdfs/addzerozero.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,0 and 0,addzerozero," ","",${MAX_STEPS_DEFAULT})

pdfs/addthree_four.pdf: ${MACHINE_DIR}/addthree.tm
	$(call create-pdfs,addthree,4,addthree_four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/addthree_zero.pdf: ${MACHINE_DIR}/addthree.tm
	$(call create-pdfs,addthree,0,addthree_zero," ","",${MAX_STEPS_DEFAULT})





### ========= These are for section one exercises ===================

seconeexercises: pdfs/pred_two.pdf pdfs/addtwotwo.pdf pdfs/infloop.pdf \
	pdfs/infloop.pdf pdfs/mystery11.pdf pdfs/mystery1011.pdf \
        pdfs/mystery110.pdf pdfs/mystery1101.pdf pdfs/mysteryempty.pdf \
        pdfs/blankones.pdf pdfs/constantthree.pdf pdfs/doubler.pdf \
	pdfs/doublerbinary.pdf pdfs/odd_three.pdf pdfs/odd_four.pdf \
	pdfs/successor.pdf pdfs/leq.pdf pdfs/bitwisenot.pdf \
	pdfs/singlebitnot.pdf pdfs/singlebitand.pdf pdfs/singlebitor.pdf \
	pdfs/append01.pdf pdfs/addany.pdf pdfs/palindromeabba.pdf \
	pdfs/palindromeaba.pdf pdfs/twobsabba.pdf pdfs/twobsaba.pdf \
	pdfs/startswithzero.pdf pdfs/startswithzeroone.pdf \
	pdfs/startswithzerostarone.pdf

pdfs/pred_two.pdf: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,2,pred_two,"1","1",${MAX_STEPS_DEFAULT})

pdfs/addtwotwo.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,2 and 2,addtwotwo,"1","1 11",${MAX_STEPS_DEFAULT})

pdfs/infloop.pdf: ${MACHINE_DIR}/infloop.tm
	$(call create-pdfs,infloop,blank tape,infloop," ","",11)

pdfs/mystery11.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,11,mystery11,"1","1",10)

pdfs/mystery1011.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,1011,mystery1011,"1","011",10)

pdfs/mystery110.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,110,mystery110,"1","10",10)

pdfs/mystery1101.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,1101,mystery1101,"1","101",10)

pdfs/mysteryempty.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,empty tape,mysteryempty," ","",10)

pdfs/blankones.pdf: ${MACHINE_DIR}/blankones.tm
	$(call create-pdfs,blankones,2,blankones,"1","1",${MAX_STEPS_DEFAULT})

pdfs/constantthree.pdf: ${MACHINE_DIR}/constantthree.tm
	$(call create-pdfs,constantthree,2,constantthree,"1","1",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/doubler.pdf: ${MACHINE_DIR}/doubler.tm
	$(call create-pdfs-leavebs,doubler,2,doubler,"1","1",${MAX_STEPS_DEFAULT})

pdfs/doublerbinary.pdf: ${MACHINE_DIR}/doublerbinary.tm
	$(call create-pdfs,doublerbinary,6,doublerbinary,"1","10",${MAX_STEPS_DEFAULT})

pdfs/odd_three.pdf: ${MACHINE_DIR}/odd.tm
	$(call create-pdfs,odd,3,odd_three,"1","11",${MAX_STEPS_DEFAULT})

pdfs/odd_four.pdf: ${MACHINE_DIR}/odd.tm
	$(call create-pdfs,odd,4,odd_four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/successor.pdf: ${MACHINE_DIR}/successor.tm
	$(call create-pdfs,successor,3,successor,"1","11",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/leq.pdf: ${MACHINE_DIR}/leq.tm
	$(call create-pdfs-leavebs,leq,2 and 3,leq,"1","1 111",${MAX_STEPS_DEFAULT})

pdfs/bitwisenot.pdf: ${MACHINE_DIR}/bitwisenot.tm
	$(call create-pdfs,bitwisenot,6,bitwisenot,"0","110",${MAX_STEPS_DEFAULT})

pdfs/singlebitnot.pdf: ${MACHINE_DIR}/singlebitnot.tm
	$(call create-pdfs,singlebitnot,0,singlebitnot,"0","",${MAX_STEPS_DEFAULT})

pdfs/singlebitand.pdf: ${MACHINE_DIR}/singlebitand.tm
	$(call create-pdfs,singlebitand,01,singlebitand,"0","1",${MAX_STEPS_DEFAULT})

pdfs/singlebitor.pdf: ${MACHINE_DIR}/singlebitor.tm
	$(call create-pdfs,singlebitor,01,singlebitor,"0","1",${MAX_STEPS_DEFAULT})

pdfs/append01.pdf: ${MACHINE_DIR}/append01.tm
	$(call create-pdfs,append01,11,append01,"1","1",${MAX_STEPS_DEFAULT})

# DUMMY keeps Bash from interpreting the comma in the string.
DUMMY = "1,1,11"
pdfs/addany.pdf: ${MACHINE_DIR}/addany.tm
	$(call create-pdfs,addany,11 then 1 then 11,addany,"1",${DUMMY},${MAX_STEPS_DEFAULT})

pdfs/palindromeabba.pdf: ${MACHINE_DIR}/palindrome.tm
	$(call create-pdfs,palindrome,abba,palindromeabba,"a","bba",${MAX_STEPS_DEFAULT})

pdfs/palindromeaba.pdf: ${MACHINE_DIR}/palindrome.tm
	$(call create-pdfs,palindrome,aba,palindromeaba,"a","ba",${MAX_STEPS_DEFAULT})

pdfs/twobsabba.pdf: ${MACHINE_DIR}/twobs.tm
	$(call create-pdfs,twobs,abba,twobsabba,"a","bba",${MAX_STEPS_DEFAULT})

pdfs/twobsaba.pdf: ${MACHINE_DIR}/twobs.tm
	$(call create-pdfs,twobs,aba,twobsaba,"a","ba",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/startswithzero.pdf: ${MACHINE_DIR}/startswithzero.tm
	$(call create-pdfs-leavebs,startswithzero,01101,startswithzero,"0","1101",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/startswithzeroone.pdf: ${MACHINE_DIR}/startswithzeroone.tm
	$(call create-pdfs-leavebs,startswithzeroone,01101,startswithzeroone,"0","1101",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/startswithzerostarone.pdf: ${MACHINE_DIR}/startswithzerostarone.tm
	$(call create-pdfs-leavebs,startswithzerostarone,00110,startswithzerostarone,"0","0110",${MAX_STEPS_DEFAULT})






### ========= These are for section I.4 exercises ===================

sectionfourexercises: pdfs/mu_ex1zero.pdf pdfs/mu_ex1one.pdf \
	pdfs/mu_ex1two.pdf pdfs/mu_ex1three.pdf pdfs/mu_ex1four.pdf \
	pdfs/mu_ex1five.pdf \
	pdfs/mu_ex2zero.pdf pdfs/mu_ex2one.pdf \
	pdfs/mu_ex2two.pdf pdfs/mu_ex2three.pdf pdfs/mu_ex2four.pdf \
	pdfs/mu_ex2five.pdf \
	pdfs/mu_ex3zero.pdf pdfs/mu_ex3one.pdf pdfs/mu_ex3two.pdf

pdfs/mu_ex1zero.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,0,mu_ex1zero," ","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1one.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,1,mu_ex1one,"1","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1two.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,2,mu_ex1two,"1","1",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1three.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,3,mu_ex1three,"1","11",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1four.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,4,mu_ex1four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1five.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,5,mu_ex1five,"1","1111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2zero.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,0,mu_ex2zero," ","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2one.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,1,mu_ex2one,"1","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2two.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,2,mu_ex2two,"1","1",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2three.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,3,mu_ex2three,"1","11",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2four.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,4,mu_ex2four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2five.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,5,mu_ex2five,"1","1111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex3zero.pdf: ${MACHINE_DIR}/mu_ex3.tm
	$(call create-pdfs,mu_ex3,0,mu_ex3zero," ","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex3one.pdf: ${MACHINE_DIR}/mu_ex3.tm
	$(call create-pdfs,mu_ex3,1,mu_ex3one,"1","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex3two.pdf: ${MACHINE_DIR}/mu_ex3.tm
	$(call create-pdfs,mu_ex3,2,mu_ex3two,"1","1",${MAX_STEPS_DEFAULT})




