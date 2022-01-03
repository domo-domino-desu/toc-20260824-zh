#!/bin/bash
# convert_pdf_to_png.sh
#  Change the PDF output of asy to a PNG file suitable for the
# Jupyter notebooks, and move the result to the suitable dir.
#
# LICENSE
#  Public Domain
# HISTORY
#   2022-01-01 Jim Hefferon Written

convert -density 300x300 -resize 65% -sharpen 2x6 $1.pdf $1.png
cp $1.png ../img
