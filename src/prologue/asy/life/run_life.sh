#!/bin/bash
# run_life.sh
#  Run the life.scm program with the needed input files to get the needed
# output files

# Make an output directory if it does not already exist
mkdir -p out

csi -ss life.scm 'beacon.init' 'beacon' 10

csi -ss life.scm 'beehive.init' 'beehive' 1

csi -ss life.scm 'blinker.init' 'blinker' 2

csi -ss life.scm 'block.init' 'block' 1

csi -ss life.scm 'eater.init' 'eater' 0

csi -ss life.scm 'eateranim.init' 'eateranim' 35

csi -ss life.scm 'glider.init' 'glider' 0

csi -ss life.scm 'glideranim.init' 'glideranim' 16

csi -ss life.scm 'glideranimr.init' 'glideranimr' 16

csi -ss life.scm 'lonely.init' 'lonely' 1

csi -ss life.scm 'mwss.init' 'mwss' 0

csi -ss life.scm 'mwssanim.init' 'mwssanim' 28

# csi -ss life.scm 'pair00.life' 'pair' 01

csi -ss life.scm 'rabbits.init' 'rabbits' 0

# csi -ss life.scm 'shuttle00.life' 'shuttle' 14

# csi -ss life.scm 'beacon00.life' 'beacon' 10

# csi -ss life.scm 'beehive00.life' 'beehive' 1

# csi -ss life.scm 'blinker00.life' 'blinker' 2

# csi -ss life.scm 'block00.life' 'block' 1

# csi -ss life.scm 'eater00.life' 'eater' 0

# csi -ss life.scm 'eateranim00.life' 'eateranim' 35

# csi -ss life.scm 'glider00.life' 'glider' 0

# csi -ss life.scm 'glideranim00.life' 'glideranim' 16

# csi -ss life.scm 'glideranimr00.life' 'glideranimr' 16

# csi -ss life.scm 'lonely00.life' 'lonely' 1

# csi -ss life.scm 'mwss00.life' 'mwss' 0

# csi -ss life.scm 'mwssanim00.life' 'mwssanim' 28

# # csi -ss life.scm 'pair00.life' 'pair' 01

# csi -ss life.scm 'rabbits.life' 'rabbits' 0

# # csi -ss life.scm 'shuttle00.life' 'shuttle' 14
