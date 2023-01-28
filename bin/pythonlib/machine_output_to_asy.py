# -*- coding: utf-8 -*-
"""
Routines used to convert output from the Turing machine simulator or
Finite State machine simulator, etc., into .asy files, that can later be
run through Asymptote.
"""
__version__ = "0.0.1"
__author__ = "Jim Hefferon"
__license__ = "GPL 3.0"

# 2023-Jan-27 Jim Hefferon Create, to hold routine that fix directory handling.

import sys
import os, os.path
import re, string
import traceback, pprint
import argparse
import time

# Global variables spare me from putting them in the call of each fcn.
VERBOSE = False
DEBUG = False

PGM_ROOTNAME = os.path.splitext(os.path.basename(sys.argv[0]))[0]
PGM_SRC_DIR = os.path.dirname(__file__)

class JHException(Exception):
    pass


# ======= handling directory of input and output .asy files =====
# Allowed strings for the top dir in the tree of files for the project.
# Should match the project's INSTALL instructions.
TOPDIR_NAMES = {'computing',
                'toc',
                'toc-master'}

from pathlib import Path
def _find_rightmost_dir(p=os.curdir, dirnames=TOPDIR_NAMES):
    """Given a path, return a list of the path components starting
    from one that is an element of dirnames.  If there is more than one 
    pathname component that is an element of dirnames, then return 
    a list starting at the rightmost such one.
       p=os.curdir  path
       dirnames=TOPDIR_NAMES  set or list of possible names for the directory 
    """
    s = list(Path(p).parts)
    # Reverse the sequence, to look for the first element of dirnames
    s.reverse()  # reverses in place
    found_dirname, found_place = None, -1  
    for i, path_part in enumerate(s):
        if path_part in dirnames:
            found_dirname, found_place = path_part, i
            break
    if found_place < 0:
        return None
    else:
        t = s[:found_place+1]
        t.reverse()
        return t

# Get the relative path from the current dir to the dir computing/src/asy
def rel_path_to_asy(from_dir=os.curdir, dirnames=TOPDIR_NAMES):
    """Return the relative path to the project's directory of asy setup files,
    such as "../../computing/src/asy".  This is needed because the .asy files
    have to read in those setup files, such as jh.asy, and so they need the dir.
      from_dir=os.curdir string   directory where the .asy files live
      dirnames=TOPDIR_NAMES
    """
    # Get list of the directory component such that one from dirnames
    # starts it.
    path_part_list = _find_rightmost_dir(from_dir, dirnames)
    if path_part_list is None:
        critical("Unable to find the top directory of the repo in the path "+from_dir+": repo must be below a directory name from the list "+(", ".join(dirnames)))
    s = []
    for i in range(len(path_part_list)):
        s.append("..")
    r = os.path.join(os.sep.join(s), path_part_list[0], 'src', 'asy')
    # print("r is "+r)
    return r
