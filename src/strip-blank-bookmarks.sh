#!/bin/bash
# strip-blank-bookmarks.sh
#
# 2022-Jun-11 Jim Hefferon  PD
#  hyperref is putting in two bookmarks per chapter, one of which is blank.
# It is some interaction with another package (?titlesec?).  I have been
# unable to figure it out, so I am stripping them out of the book.out file.

# save the old version
cp book.out book.out.sav
# Drop bookmarks whose title is empty.  titlesec also makes chapter bookmarks
# children of its empty part bookmark; when that part entry is removed, attach
# those children to our visible Chinese part bookmark instead.
awk '
  /\\BOOKMARK [^\{]*\{[^\{]*\{\}/ {
    if (match($0, /\{part\.[0-9]+\}\{\}/)) {
      chunk = substr($0, RSTART, RLENGTH)
      match(chunk, /part\.[0-9]+/)
      empty_part = substr(chunk, RSTART, RLENGTH)
      part_number = substr(empty_part, 6)
      redirect[empty_part] = "partbookmark." part_number ".0"
    }
    next
  }
  {
    for (old_parent in redirect) {
      gsub("\\{" old_parent "\\}", "{" redirect[old_parent] "}")
    }
    print
  }
' book.out.sav > book.out
