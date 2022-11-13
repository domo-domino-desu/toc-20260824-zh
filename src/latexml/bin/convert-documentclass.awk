#! /bin/awk -f
# convert-documentclass.awk
#  Change the documentclass of book.tex to latexmlcomputing, and also
# change it back.
#
# License: Public Domain
#
# 2022-Nov-02 Jim Hefferon jhefferon@smcvt.edu

/\documentclass{latexmlcomputing}/ { print "\documentclass{computing}"}
/\documentclass{computing}/        { print "\documentclass{latexcomputing}"}
$0 !~ /\documentclass{^}*}/        { print "KKK" }
