#!/usr/bin/env bash
# 00buildzip.sh
#  Construct a .zip file of the slides
#
# 2025-May-17 JH Init PD
zip --junk-paths slides \
    README \
    prologue/prologue.pdf \
    background/background.pdf \
    languages/languages.pdf \
    automata/automata.pdf \
    complexity/complexity.pdf
