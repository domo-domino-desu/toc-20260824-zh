#!/bin/bash
# strip-blank-bookmarks.sh
#
# 2022-Jun-11 Jim Hefferon  PD
#  hyperref is putting in two bookmarks per chapter, one of which is blank.
# It is some interaction with another package (?titlesec?).  I have been
# unable to figure it out, so I am stripping them out of the book.out file.

# save the old version
cp book.out book.out.sav
# If the secodn {}'s field is nonempty then print the line
awk '$0 !~ /\BOOKMARK [^\{]*\{[^\{]*\{\}/ { print $0 }' book.out.sav > book.out
