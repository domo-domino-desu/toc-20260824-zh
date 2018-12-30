#!/bin/bash
# convert the cover00.pdf to  cover.png for the joshua home page
convert           \
   -verbose       \
   -density 150   \
   -trim          \
    cover00.pdf      \
   -quality 100   \
   -flatten       \
   -sharpen 0x1.0 \
    cover.png
