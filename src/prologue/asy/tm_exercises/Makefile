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
	@mkdir -p tmp/ pdfs/
  ${TM_DIR}/turing-machine.rkt -f ${MACHINE_DIR}/${1}.tm -c ${4} -r ${5} -s ${6} > tmp/${3}.out
  ${SCRIPT_DIR}/tm_to_asy.py --blanks -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef

# create-pdfs-leavebs
# Like the prior macro but the --blanks option is not used in tm_to_asy.py
# so the tapes will have B's in them.
define create-pdfs-leavebs
  @echo "Using ${1}.tm on ${2} to get file family ${3}"
	@mkdir -p tmp/ pdfs/
  ${TM_DIR}/turing-machine.rkt -f ${MACHINE_DIR}/${1}.tm -c ${4} -r ${5}  -s ${6} > tmp/${3}.out
  ${SCRIPT_DIR}/tm_to_asy.py -f tmp/${3}.out -o pdfs/${3}
  cd pdfs; asy ${3}
endef



all: textbody topicexercises seconeexercises sectionfourexercises



### ========= These are for the text body ===================

textbody: pdfs/pred000.pdf pdfs/add000.pdf

pdfs/pred000.pdf: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,3,pred,"1","11",${MAX_STEPS_DEFAULT})

pdfs/add000.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,2 and 3,add,"1","1 111",${MAX_STEPS_DEFAULT})




### ========= These are for Topic exercises ===================

topicexercises: \
  pdfs/pred_five000.pdf \
  pdfs/pred_empty000.pdf \
  pdfs/doubler000.pdf \
  pdfs/addonetwo000.pdf \
  pdfs/addzerotwo000.pdf \
  pdfs/addzerozero000.pdf \
  pdfs/addthree_four000.pdf \
  pdfs/addthree_zero000.pdf

pdfs/pred_five000.pdf: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,5,pred_five,"1","1111",${MAX_STEPS_DEFAULT})

pdfs/pred_empty000.pdf: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,empty tape,pred_empty," ","",${MAX_STEPS_DEFAULT})

pdfs/addonetwo000.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,1 and 2,addonetwo,"1"," 11",${MAX_STEPS_DEFAULT})

pdfs/addzerotwo000.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,0 and 2,addzerotwo," ","11",${MAX_STEPS_DEFAULT})

pdfs/addzerozero000.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,0 and 0,addzerozero," ","",${MAX_STEPS_DEFAULT})

pdfs/addthree_four000.pdf: ${MACHINE_DIR}/addthree.tm
	$(call create-pdfs,addthree,4,addthree_four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/addthree_zero000.pdf: ${MACHINE_DIR}/addthree.tm
	$(call create-pdfs,addthree,0,addthree_zero," ","",${MAX_STEPS_DEFAULT})





### ========= These are for section one exercises ===================

seconeexercises: \
  pdfs/pred_two000.pdf \
  pdfs/addtwotwo000.pdf \
  pdfs/infloop000.pdf \
  pdfs/infloop000.pdf \
  pdfs/mystery11000.pdf \
  pdfs/mystery1011000.pdf \
  pdfs/mystery110000.pdf \
  pdfs/mystery1101000.pdf \
  pdfs/mysteryempty000.pdf \
  pdfs/blankones000.pdf \
  pdfs/constantthree000.pdf \
  pdfs/doubler000.pdf \
  pdfs/doublerbinary000.pdf \
  pdfs/odd_three000.pdf \
  pdfs/odd_four000.pdf \
  pdfs/successor000.pdf \
  pdfs/leq000.pdf \
  pdfs/bitwisenot000.pdf \
  pdfs/singlebitnot000.pdf \
  pdfs/singlebitand000.pdf \
  pdfs/singlebitor000.pdf \
  pdfs/append01000.pdf \
  pdfs/addany000.pdf \
  pdfs/palindromeabba000.pdf \
  pdfs/palindromeaba000.pdf \
  pdfs/twobsabba000.pdf \
  pdfs/twobsaba000.pdf \
  pdfs/startswithzero000.pdf \
  pdfs/startswithzeroone000.pdf \
  pdfs/startswithzerostarone000.pdf

pdfs/pred_two000.pdf: ${MACHINE_DIR}/pred.tm
	$(call create-pdfs,pred,2,pred_two,"1","1",${MAX_STEPS_DEFAULT})

pdfs/addtwotwo000.pdf: ${MACHINE_DIR}/add.tm
	$(call create-pdfs,add,2 and 2,addtwotwo,"1","1 11",${MAX_STEPS_DEFAULT})

pdfs/infloop000.pdf: ${MACHINE_DIR}/infloop.tm
	$(call create-pdfs,infloop,blank tape,infloop," ","",11)

pdfs/mystery11000.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,11,mystery11,"1","1",10)

pdfs/mystery1011000.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,1011,mystery1011,"1","011",10)

pdfs/mystery110000.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,110,mystery110,"1","10",10)

pdfs/mystery1101000.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,1101,mystery1101,"1","101",10)

pdfs/mysteryempty000.pdf: ${MACHINE_DIR}/mystery.tm
	$(call create-pdfs,mystery,empty tape,mysteryempty," ","",10)

pdfs/blankones000.pdf: ${MACHINE_DIR}/blankones.tm
	$(call create-pdfs,blankones,2,blankones,"1","1",${MAX_STEPS_DEFAULT})

pdfs/constantthree000.pdf: ${MACHINE_DIR}/constantthree.tm
	$(call create-pdfs,constantthree,2,constantthree,"1","1",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/doubler000.pdf: ${MACHINE_DIR}/doubler.tm
	$(call create-pdfs-leavebs,doubler,2,doubler,"1","1",${MAX_STEPS_DEFAULT})

pdfs/doublerbinary000.pdf: ${MACHINE_DIR}/doublerbinary.tm
	$(call create-pdfs,doublerbinary,6,doublerbinary,"1","10",${MAX_STEPS_DEFAULT})

pdfs/odd_three000.pdf: ${MACHINE_DIR}/odd.tm
	$(call create-pdfs,odd,3,odd_three,"1","11",${MAX_STEPS_DEFAULT})

pdfs/odd_four000.pdf: ${MACHINE_DIR}/odd.tm
	$(call create-pdfs,odd,4,odd_four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/successor000.pdf: ${MACHINE_DIR}/successor.tm
	$(call create-pdfs,successor,3,successor,"1","11",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/leq000.pdf: ${MACHINE_DIR}/leq.tm
	$(call create-pdfs-leavebs,leq,2 and 3,leq,"1","1 111",${MAX_STEPS_DEFAULT})

pdfs/bitwisenot000.pdf: ${MACHINE_DIR}/bitwisenot.tm
	$(call create-pdfs,bitwisenot,6,bitwisenot,"0","110",${MAX_STEPS_DEFAULT})

pdfs/singlebitnot000.pdf: ${MACHINE_DIR}/singlebitnot.tm
	$(call create-pdfs,singlebitnot,0,singlebitnot,"0","",${MAX_STEPS_DEFAULT})

pdfs/singlebitand000.pdf: ${MACHINE_DIR}/singlebitand.tm
	$(call create-pdfs,singlebitand,01,singlebitand,"0","1",${MAX_STEPS_DEFAULT})

pdfs/singlebitor000.pdf: ${MACHINE_DIR}/singlebitor.tm
	$(call create-pdfs,singlebitor,01,singlebitor,"0","1",${MAX_STEPS_DEFAULT})

pdfs/append01000.pdf: ${MACHINE_DIR}/append01.tm
	$(call create-pdfs,append01,11,append01,"1","1",${MAX_STEPS_DEFAULT})

# DUMMY keeps Bash from interpreting the comma in the string.
DUMMY = "1,1,11"
pdfs/addany000.pdf: ${MACHINE_DIR}/addany.tm
	$(call create-pdfs,addany,11 then 1 then 11,addany,"1",${DUMMY},${MAX_STEPS_DEFAULT})

pdfs/palindromeabba000.pdf: ${MACHINE_DIR}/palindrome.tm
	$(call create-pdfs,palindrome,abba,palindromeabba,"a","bba",${MAX_STEPS_DEFAULT})

pdfs/palindromeaba000.pdf: ${MACHINE_DIR}/palindrome.tm
	$(call create-pdfs,palindrome,aba,palindromeaba,"a","ba",${MAX_STEPS_DEFAULT})

pdfs/twobsabba000.pdf: ${MACHINE_DIR}/twobs.tm
	$(call create-pdfs,twobs,abba,twobsabba,"a","bba",${MAX_STEPS_DEFAULT})

pdfs/twobsaba000.pdf: ${MACHINE_DIR}/twobs.tm
	$(call create-pdfs,twobs,aba,twobsaba,"a","ba",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/startswithzero000.pdf: ${MACHINE_DIR}/startswithzero.tm
	$(call create-pdfs-leavebs,startswithzero,01101,startswithzero,"0","1101",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/startswithzeroone000.pdf: ${MACHINE_DIR}/startswithzeroone.tm
	$(call create-pdfs-leavebs,startswithzeroone,01101,startswithzeroone,"0","1101",${MAX_STEPS_DEFAULT})

# note the use of leavebs here
pdfs/startswithzerostarone000.pdf: ${MACHINE_DIR}/startswithzerostarone.tm
	$(call create-pdfs-leavebs,startswithzerostarone,00110,startswithzerostarone,"0","0110",${MAX_STEPS_DEFAULT})






### ========= These are for section I.4 exercises ===================

sectionfourexercises: \
  pdfs/mu_ex1zero000.pdf \
  pdfs/mu_ex1one000.pdf \
  pdfs/mu_ex1two000.pdf \
  pdfs/mu_ex1three000.pdf \
  pdfs/mu_ex1four000.pdf \
  pdfs/mu_ex1five000.pdf \
  pdfs/mu_ex2zero000.pdf \
  pdfs/mu_ex2one000.pdf \
  pdfs/mu_ex2two000.pdf \
  pdfs/mu_ex2three000.pdf \
  pdfs/mu_ex2four000.pdf \
  pdfs/mu_ex2five000.pdf \
  pdfs/mu_ex3zero000.pdf \
  pdfs/mu_ex3one000.pdf \
  pdfs/mu_ex3two000.pdf

pdfs/mu_ex1zero000.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,0,mu_ex1zero," ","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1one000.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,1,mu_ex1one,"1","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1two000.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,2,mu_ex1two,"1","1",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1three000.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,3,mu_ex1three,"1","11",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1four000.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,4,mu_ex1four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex1five000.pdf: ${MACHINE_DIR}/mu_ex1.tm
	$(call create-pdfs,mu_ex1,5,mu_ex1five,"1","1111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2zero000.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,0,mu_ex2zero," ","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2one000.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,1,mu_ex2one,"1","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2two000.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,2,mu_ex2two,"1","1",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2three000.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,3,mu_ex2three,"1","11",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2four000.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,4,mu_ex2four,"1","111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex2five000.pdf: ${MACHINE_DIR}/mu_ex2.tm
	$(call create-pdfs,mu_ex2,5,mu_ex2five,"1","1111",${MAX_STEPS_DEFAULT})

pdfs/mu_ex3zero000.pdf: ${MACHINE_DIR}/mu_ex3.tm
	$(call create-pdfs,mu_ex3,0,mu_ex3zero," ","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex3one000.pdf: ${MACHINE_DIR}/mu_ex3.tm
	$(call create-pdfs,mu_ex3,1,mu_ex3one,"1","",${MAX_STEPS_DEFAULT})

pdfs/mu_ex3two000.pdf: ${MACHINE_DIR}/mu_ex3.tm
	$(call create-pdfs,mu_ex3,2,mu_ex3two,"1","1",${MAX_STEPS_DEFAULT})




