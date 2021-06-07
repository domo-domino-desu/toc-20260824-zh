# Makefile
# For Linear Algebra by Jim Hefferon joshua.smcvt.edu/linearalgebra
# 2021-Jun-01 JH GPL 2

# SRC_DIR  Full path for src/
#  From http://timmurphy.org/2015/09/27/how-to-get-a-makefile-directory-path/
SRC_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

# TEXINPUTS
#  String giving location of .sty files, etc.
#  Note that because SRC_DIR ends with a slash, the slash here makes there
# be two slashes, which causes TeX to search all subdirs of SRC_DIR.  Note
# also that here the "$(TEXINPUTS)" refers to the environment variable.
TEXINPUTS := TEXINPUTS=$(SRC_DIR)/:$(TEXINPUTS)

# ASYMPTOTE_DIR
#  Asymptote uses this to look for config and imported files.
#  Note that because SRC_DIR ends with a slash, the slash here makes there
# be two slashes, which causes a search of all subdirs of SRC_DIR.   Note
# also that here the "$(ASYMPTOTE_DIR)" refers to the environment variable.
ASYMPTOTE_DIR := ASYMPTOTE_DIR=$(SRC_DIR)/asy//:$(SRC_DIR)/asy/asy-graphtheory-master/modules//:$(ASYMPTOTE_DIR)

# LaTeX compiler
LATEX := pdflatex

# LaTeX command line
#  The command line used to invoke LaTeX.  Set the environment, then call
# the program.
LATEX_CMD := $(TEXINPUTS) $(LATEX) 

# Asymptote command line.
# Set the environment and then call the program.
# Options:
#   -nosafe gets around GhostScript error when using opacity:
#      https://github.com/vectorgraphics/asymptote/issues/77
#  -vv makes it talk more
# ASYMPTOTE_CMD := $(TEXINPUTS) $(ASYMPTOTE_DIR) asy -nosafe
ASYMPTOTE_CMD := asy -nosafe

# Makeindex command line.
MAKEINDEX_CMD := makeindex -s sty/book.isty

# Command for making a .zip file, for the slides.
ZIP_CMD := zip


# .PHONY : all
# all : book.pdf answers.pdf

# book.pdf : book.tex cover preface prologue background languages automata complexity appendix
# 	$(LATEX_CMD) book.tex


# ============== cover ================

cover/asy/cover00.pdf : cover/asy/cover.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

cover/cover.tex : | cover/asy/cover00.pdf


# ============== prologue ================

# The PHONY is here because I use this as a test, as in "make xygraphs"
.PHONY : xygraphs
xygraphs : prologue/asy/xygraphs/xygraphs00.pdf

prologue/asy/xygraphs/xygraphs00.pdf : prologue/asy/xygraphs/xygraphs.asy
	cd $(@D); \
	echo "$(@D)"; \
	echo "$(<F)"; \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/circlediagram/circlediagram00.pdf : prologue/asy/circlediagram/circlediagram.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/circlediagram/infloop.pdf : prologue/asy/circlediagram/infloop.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/gates/gates00.pdf : prologue/asy/gates/gates.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/life/beacon00.pdf : prologue/asy/life/lifegraphics.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tape/tapeadd00.pdf : prologue/asy/tape/tapeadd.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm/tm000.pdf : prologue/asy/tm/tm.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/inverse/inverse000.pdf : prologue/asy/tm_exercises/inverse/inverse.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/replicator/replicator000.pdf : prologue/asy/tm_exercises/replicator/replicator.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

# .... TM_EXS start
# These are in principle created by running the TM simulator, but to reduce the
# difficulty of compiling the book, I've saved them in the git.

prologue/asy/tm_exercises/pdfs/add000.pdf : prologue/asy/tm_exercises/pdfs/add.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/addany000.pdf : prologue/asy/tm_exercises/pdfs/addany.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/addonetwo000.pdf : prologue/asy/tm_exercises/pdfs/addonetwo.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/addthree_four000.pdf : prologue/asy/tm_exercises/pdfs/addthree_four.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/addthree_zero000.pdf : prologue/asy/tm_exercises/pdfs/addthree_zero.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/addtwotwo000.pdf : prologue/asy/tm_exercises/pdfs/addtwotwo.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/addzerotwo000.pdf : prologue/asy/tm_exercises/pdfs/addzerotwo.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/addzerozero000.pdf : prologue/asy/tm_exercises/pdfs/addzerozero.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/append01000.pdf : prologue/asy/tm_exercises/pdfs/append01.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/bitwisenot000.pdf : prologue/asy/tm_exercises/pdfs/bitwisenot.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/blankones000.pdf : prologue/asy/tm_exercises/pdfs/blankones.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/constantthree000.pdf : prologue/asy/tm_exercises/pdfs/constantthree.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/doubler000.pdf : prologue/asy/tm_exercises/pdfs/doubler.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/doublerbinary000.pdf : prologue/asy/tm_exercises/pdfs/doublerbinary.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/infloop000.pdf : prologue/asy/tm_exercises/pdfs/infloop.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/leq000.pdf : prologue/asy/tm_exercises/pdfs/leq.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex1five000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex1five.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex1four000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex1four.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex1one000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex1one.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex1three000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex1three.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex1two000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex1two.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex1zero000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex1zero.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex2five000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex2five.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex2four000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex2four.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex2one000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex2one.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex2three000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex2three.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex2two000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex2two.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex2zero000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex2zero.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex3one000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex3one.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex3two000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex3two.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mu_ex3zero000.pdf : prologue/asy/tm_exercises/pdfs/mu_ex3zero.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mystery11000.pdf : prologue/asy/tm_exercises/pdfs/mystery11.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mystery110000.pdf : prologue/asy/tm_exercises/pdfs/mystery110.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mystery1011000.pdf : prologue/asy/tm_exercises/pdfs/mystery1011.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mystery1101000.pdf : prologue/asy/tm_exercises/pdfs/mystery1101.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/mysteryempty000.pdf : prologue/asy/tm_exercises/pdfs/mysteryempty.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/odd_four000.pdf : prologue/asy/tm_exercises/pdfs/odd_four.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/odd_three000.pdf : prologue/asy/tm_exercises/pdfs/odd_three.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/palindromeaba000.pdf : prologue/asy/tm_exercises/pdfs/palindromeaba.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/palindromeabba000.pdf : prologue/asy/tm_exercises/pdfs/palindromeabba.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/pred000.pdf : prologue/asy/tm_exercises/pdfs/pred.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/pred_empty000.pdf : prologue/asy/tm_exercises/pdfs/pred_empty.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/pred_five000.pdf : prologue/asy/tm_exercises/pdfs/pred_five.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/pred_two000.pdf : prologue/asy/tm_exercises/pdfs/pred_two.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/singlebitand000.pdf : prologue/asy/tm_exercises/pdfs/singlebitand.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/singlebitnot000.pdf : prologue/asy/tm_exercises/pdfs/singlebitnot.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/singlebitor000.pdf : prologue/asy/tm_exercises/pdfs/singlebitor.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/startswithzero000.pdf : prologue/asy/tm_exercises/pdfs/startswithzero.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/startswithzeroone000.pdf : prologue/asy/tm_exercises/pdfs/startswithzeroone.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/startswithzerostarone000.pdf : prologue/asy/tm_exercises/pdfs/startswithzerostarone.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/successor000.pdf : prologue/asy/tm_exercises/pdfs/successor.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/twobsaba000.pdf : prologue/asy/tm_exercises/pdfs/twobsaba.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

prologue/asy/tm_exercises/pdfs/twobsabba000.pdf : prologue/asy/tm_exercises/pdfs/twobsabba.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

# .... TM_EXS end

# The | makes these into order-only prereqs, so prologue.tex is not rebuilt 
prologue/prologue.tex : | prologue/asy/xygraphs/xygraphs00.pdf \
  prologue/asy/circlediagram/circlediagram00.pdf \
  prologue/asy/circlediagram/infloop.pdf \
  prologue/asy/gates/gates00.pdf \
  prologue/asy/life/beacon00.pdf \
  prologue/asy/tape/tapeadd00.pdf \
  prologue/asy/tm/tm000.pdf \
  prologue/asy/tm_exercises/inverse/inverse000.pdf \
  prologue/asy/tm_exercises/replicator/replicator000.pdf \
  prologue/asy/tm_exercises/pdfs/add000.pdf \
  prologue/asy/tm_exercises/pdfs/addany000.pdf \
  prologue/asy/tm_exercises/pdfs/addonetwo000.pdf \
  prologue/asy/tm_exercises/pdfs/addthree_four000.pdf \
  prologue/asy/tm_exercises/pdfs/addthree_zero000.pdf \
  prologue/asy/tm_exercises/pdfs/addtwotwo000.pdf \
  prologue/asy/tm_exercises/pdfs/addzerotwo000.pdf \
  prologue/asy/tm_exercises/pdfs/addzerozero000.pdf \
  prologue/asy/tm_exercises/pdfs/append01000.pdf \
  prologue/asy/tm_exercises/pdfs/bitwisenot000.pdf \
  prologue/asy/tm_exercises/pdfs/blankones000.pdf \
  prologue/asy/tm_exercises/pdfs/constantthree000.pdf \
  prologue/asy/tm_exercises/pdfs/doubler000.pdf \
  prologue/asy/tm_exercises/pdfs/doublerbinary000.pdf \
  prologue/asy/tm_exercises/pdfs/infloop000.pdf \
  prologue/asy/tm_exercises/pdfs/leq000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex1five000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex1four000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex1one000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex1three000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex1two000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex1zero000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex2five000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex2four000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex2one000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex2three000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex2two000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex2zero000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex3one000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex3two000.pdf \
  prologue/asy/tm_exercises/pdfs/mu_ex3zero000.pdf \
  prologue/asy/tm_exercises/pdfs/mystery1011000.pdf \
  prologue/asy/tm_exercises/pdfs/mystery110000.pdf \
  prologue/asy/tm_exercises/pdfs/mystery11000.pdf \
  prologue/asy/tm_exercises/pdfs/mystery1101000.pdf \
  prologue/asy/tm_exercises/pdfs/mysteryempty000.pdf \
  prologue/asy/tm_exercises/pdfs/odd_four000.pdf \
  prologue/asy/tm_exercises/pdfs/odd_three000.pdf \
  prologue/asy/tm_exercises/pdfs/palindromeaba000.pdf \
  prologue/asy/tm_exercises/pdfs/palindromeabba000.pdf \
  prologue/asy/tm_exercises/pdfs/pred000.pdf \
  prologue/asy/tm_exercises/pdfs/pred_empty000.pdf \
  prologue/asy/tm_exercises/pdfs/pred_five000.pdf \
  prologue/asy/tm_exercises/pdfs/pred_two000.pdf \
  prologue/asy/tm_exercises/pdfs/singlebitand000.pdf \
  prologue/asy/tm_exercises/pdfs/singlebitnot000.pdf \
  prologue/asy/tm_exercises/pdfs/singlebitor000.pdf \
  prologue/asy/tm_exercises/pdfs/startswithzero000.pdf \
  prologue/asy/tm_exercises/pdfs/startswithzeroone000.pdf \
  prologue/asy/tm_exercises/pdfs/startswithzerostarone000.pdf \
  prologue/asy/tm_exercises/pdfs/successor000.pdf \
  prologue/asy/tm_exercises/pdfs/twobsaba000.pdf \
  prologue/asy/tm_exercises/pdfs/twobsabba000.pdf


# ============== background ================

background/asy/3d/3d000.pdf : background/asy/3d/3d.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/aristotle/aristotle1000.pdf : background/asy/aristotle/aristotle.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/busybeaver/busybeaver00.pdf : background/asy/busybeaver/busybeaver.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/correspondences/correspondences000.pdf : background/asy/correspondences/correspondences.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/flowcharts/flowcharts00.pdf : background/asy/flowcharts/flowcharts.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/galileo/galileo000.pdf : background/asy/galileo/galileo.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/hp/hp00.pdf : background/asy/hp/hp.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/indexsets/indexsets.pdf : background/asy/indexsets/indexsets.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/maps/maps00.pdf : background/asy/maps/maps.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/asy/memory/memory00.pdf : background/asy/memory/memory.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

background/background.tex : | background/asy/3d/3d000.pdf \
  background/asy/aristotle/aristotle1000.pdf \
  background/asy/busybeaver/busybeaver00.pdf \
  background/asy/correspondences/correspondences000.pdf \
  background/asy/flowcharts/flowcharts00.pdf \
  background/asy/galileo/galileo000.pdf \
  background/asy/hp/hp00.pdf \
  background/asy/indexsets/indexsets.pdf \
  background/asy/maps/maps00.pdf \
  background/asy/memory/memory00.pdf


# ============== languages ================

languages/asy/graphs/graphs00.pdf : languages/asy/graphs/graphs.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

languages/asy/parsetree/parsetree000.pdf : languages/asy/parsetree/parsetree.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

languages/languages.tex : | languages/asy/graphs/graphs00.pdf \
  languages/asy/parsetree/parsetree000.pdf

# ============== automata ================

automata/asy/fsa/fsa00.pdf : automata/asy/fsa/fsa.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

# .... FSM_EXERCISES start

automata/asy/fsm_exercises/pdfs/endsinai000.pdf : automata/asy/fsm_exercises/pdfs/endsinai.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

automata/asy/fsm_exercises/pdfs/endsinaii000.pdf : automata/asy/fsm_exercises/pdfs/endsinaii.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

automata/asy/fsm_exercises/pdfs/endsinaiii000.pdf : automata/asy/fsm_exercises/pdfs/andsinaiii.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

automata/asy/fsm_exercises/pdfs/modfour000.pdf : automata/asy/fsm_exercises/pdfs/modfour.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

# .... FSM_EXERCISES end

automata/asy/machine/machine00.pdf : automata/asy/machine/machine.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

automata/asy/min/000.pdf : automata/asy/min/.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

automata/asy/nfsm/nfsm00.pdf : automata/asy/nfsm/nfsm.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

automata/asy/pda/pda00.pdf : automata/asy/pda/pda.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

automata/asy/regex/regex00.pdf : automata/asy/regex/regex.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

automata/automata.tex : | automata/asy/fsa/fsa00.pdf \
  automata/asy/fsm_exercises/pdfs/endsinai000.pdf \
  automata/asy/fsm_exercises/pdfs/endsinaii000.pdf \
  automata/asy/fsm_exercises/pdfs/endsinaiii000.pdf \
  automata/asy/fsm_exercises/pdfs/modfour000.pdf \
  automata/asy/machine/machine00.pdf \
  automata/asy/min/000.pdf \
  automata/asy/nfsm/nfsm00.pdf \
  automata/asy/pda/pda00.pdf \
  automata/asy/regex/regex00.pdf


# ============== complexity ================

complexity/asy/bigo/bigo00.pdf : complexity/asy/bigo/bigo.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

complexity/asy/circuit/000.pdf : complexity/asy/circuit/.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

complexity/asy/complexity/complexity00.pdf : complexity/asy/complexity/complexity.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

complexity/asy/flowcharts/flowcharts000.pdf : complexity/asy/flowcharts/flowcharts.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

complexity/asy/ndtm/ndtm000.pdf : complexity/asy/ndtm/ndtm.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

complexity/asy/pnp/pnp00.pdf : complexity/asy/pnp/pnp.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

complexity/asy/problems/problems00.pdf : complexity/asy/problems/problems.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

complexity/asy/xygraphs/xygraphs00.pdf : complexity/asy/xygraphs/xygraphs.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

complexity/complexity.tex : | complexity/asy/bigo/bigo00.pdf \
  complexity/asy/circuit/000.pdf \
  complexity/asy/complexity/complexity00.pdf \
  complexity/asy/flowcharts/flowcharts000.pdf \
  complexity/asy/ndtm/ndtm000.pdf \
  complexity/asy/pnp/pnp00.pdf \
  complexity/asy/problems/problems00.pdf \
  complexity/asy/xygraphs/xygraphs00.pdf


# ============== appendix ================

appendix/asy/functions000.pdf : appendix/asy/functions.asy
	cd $(@D); \
	$(ASYMPTOTE_CMD) "$(<F)"

appendix/appendix.tex : | appendix/asy/functions000.pdf


# ============== book ================

book.pdf : cover/cover.tex \
  preface/preface.tex \
  prologue/prologue.tex \
  background/background.tex \
  languages/languages.tex \
  automata/automata.tex \
  complexity/complexity.tex \
  appendix/appendix.tex
	$(LATEX_CMD) book
