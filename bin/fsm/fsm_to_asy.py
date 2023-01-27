#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Convert output from Finite State machine simulator finit-state-machine.rkt 
for use in Asymptote.
"""
__version__ = "1.0.4"
__author__ = "Jim Hefferon"
__license__ = "GPL 3.0"

# 2020-Jun-14 JH Simplified version of turing machine script
# 2023-Jan-27 JH Fix directory handling.

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

import logging
# Potential logging levels: DEBUG | INFO | WARNING | ERROR | CRITICAL
LOG_LEVEL_CHOICES=["debug", "info", "warning", "error", "critical", "default"]
DEFAULT_LOG_LEVEL = "warning"
if not(DEFAULT_LOG_LEVEL in LOG_LEVEL_CHOICES):
    critical("DEFAULT_LOG_LEVEL "+str(DEFAULT_LOG_LEVEL)+ \
             " must be in LOG_LEVEL_CHOICES="+str(LOG_LEVEL_CHOICES))

def _set_log_level(log, choice=DEFAULT_LOG_LEVEL):
    c = choice.casefold()  # like lower() but for case-insensitive matching
    # log.debug('Logging level set to '+choice)
    if (c == "debug"):
        log.setLevel(logging.DEBUG)
    elif (c == "info"):
        log.setLevel(logging.INFO)
    elif (c == "warning"):
        log.setLevel(logging.WARNING)
    elif (c == "error"):
        log.setLevel(logging.ERROR)
    elif (c == "critical"):
        log.setLevel(logging.CRITICAL)
    else:
        error("Logging level {0!s} not known".format(choice))

# Establish logging
log = logging.getLogger(__name__)
_set_log_level(log)
# Log errors to the console
log_sh = logging.StreamHandler(stream=sys.stderr)
log_sh.setFormatter(logging.Formatter('%(levelname)s - Line: %(lineno)d\n  %(message)s'))
_set_log_level(log_sh,"ERROR")
log.addHandler(log_sh)
# Log most everything to a file
log_fh = logging.FileHandler(os.path.abspath(os.path.join(
    os.path.dirname(__file__), 
    PGM_ROOTNAME + '.log')),
    mode='w')
log_fh.setFormatter(logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - Line: %(lineno)d\n%(message)s'))
_set_log_level(log_fh,"INFO")
log.addHandler(log_fh)
if DEBUG:
    _set_log_level(log_sh,"DEBUG")
    _set_log_level(log_fh,"DEBUG")

def warning(s):
    t = 'WARNING: '+s+"\n"
    log.warning(t)

def error(s, level=10):
    t = 'ERROR: '+s+"\n"
    log.error(t,exc_info=True)
    sys.exit(level)

def critical(s, level=1):
    t = 'CRITICAL ERROR: '+s+"\n"
    log.critical(t,exc_info=True)
    sys.exit(level)

# ============================================
TEST_LINE = "Step 1: q1: 0011 "
TEST_LINES = """Step 0: q0: 10011
Step 1: q1: 0011
Step 2: q1: 011
Step 3: q1: 11
Step 4: q2: 1
Step 5: q3: 
""".splitlines()

def get_input_file(fn):
    """Return a file.
      fn  string  Name of file.  If None then stdin is returned
    """
    if fn is None:
        return sys.stdin
    try:
        return open(fn, 'r')
    except IOError as e:
        critical("Cannot open input file {0!s} because: {1!s}".format(fn,e))
            
def read_lines(f):
    """Return list of lines in the file.  Lines are stripped.
    """    
    lines = f.readlines()
    return [x.strip() for x in lines]

# Format example: TEST_LINE above
output_line_regex = r"(s|S)tep (\d*):\s*q(\d*):\s([^\s]*)\s*$"
output_line_re = re.compile(output_line_regex, re.I)  # re.I in case capital q
def parse_line(lne):
    """Return dictionary with the line's constituient parts (or None)
      lne  string  line of output from Turing machine simulator
    """
    m = output_line_re.match(lne)
    if m:
        return {'step': m.group(2),
                'state': m.group(3),
                'input': m.group(4)
        }
    else:
        return None
         
def parse_lines(lines):
    """Return a list of dictionary's with line's constituent parts.  If a line
    does not parse then it is skipped.
    """
    total_parsed = 0
    initial_offset_left, initial_offset_right = None, None
    min_pos, max_pos = 0, 0
    line_list = []
    for lne_no,lne in enumerate(lines):
        d = parse_line(lne)
        if DEBUG:
            print("  parse_lines: lne={0!s} and d={1!s}".format(lne,d))
        if not(d is None):
            d['line'] = lne
            line_list.append((d,lne_no))
    return line_list

def print_parsed_line(d):
    """Show results of parsing the line, for debugging
     d  dict  Results from parsing a line
    """
    print("step:{step}, state: {state}, input: {input}".format(**d))
  
    
def tape_output(d,fn,replace_blanks=False):
    """Return a string giving one tape_output(...) line of the asy file
      d  dict  results of parsing the output line.
      fn  string  Name of PDF file that Asy will output to.  
      replace_blanks=False  boolean  Replace 'B' with ' '?
    """
    r = ['"'+fn+'"']  # Asy needs quotes to konw it is a string
    tape_string = d['input']
    if replace_blanks:
        tape_string = tape_string.replace("B"," ")
    r.append('"'+tape_string+'"')
    r.append("{:d}".format(0))  # position of head
    r.append('"$\\state{'+d['state']+'}$"')
    return "tape_output_withend("+",".join(r)+");"

ASY_HEAD = """// {0:s}.asy
// Draw a succession of tapes for a Finite State machine computation
// This is generated by computing/bin/fsm/fsm_to_asy.py

import settings;
settings.outformat="pdf";
settings.render=0;

// cd needed for relative import 
cd("{1:s}");
// import jh;
import tape;
cd("");

unitsize(1pt);
"""
ASY_TAIL = """
"""

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

# ================ Create an .asy file ======================
def asy(d_list, fn_prefix, replace_blanks = False):
    """Create an asy file and populate it with the tape_output lines
     d_list  list of dicts  Results of parsing a line
     fn_prefix  string  Prefix of name of file Asy will output to.  Note that
       this routine adds "{:03d}" so output pdf's will have three digits 
       appended to this prefix, so the succession of tape snapshots
       will be xxx000.pdf, xxx001.pdf ...
     replace_blanks=False  boolean  Replace 'B' with ' '?
    """
    asy_dir = rel_path_to_asy(os.path.abspath(os.path.dirname(fn_prefix)))
    # asy_dir = "../../../../asy"  # Directory where jh.asy, tape.asy live
    print("fn_prefix is {0:s} asy_dir is {1:s}".format(fn_prefix,asy_dir))
    r = [ASY_HEAD.format(fn_prefix,asy_dir)]
    fn = os.path.basename(fn_prefix)+"{0:03d}"
    for d,i in d_list:
        r.append(tape_output(d,
                             fn=fn.format(i-1),
                             replace_blanks=replace_blanks))
    r.append(ASY_TAIL)
    f = open(fn_prefix+".asy","w")
    f.write("\n".join(r))
    f.close()

def get_file_contents(fn):
    """Return the file contents
      fn  string  File name 
    """
    with open(fn,'r') as f:
        lines = f.read()
    return lines

# ===========================================================
def main(args):
    if args.debug:
        DEBUG=True
    if args.verbose:
        VERBOSE=True
    file_contents = get_file_contents(args.filename)
    d_list = parse_lines(file_contents.splitlines())
    # print("d_list is ",pprint.pformat(d_list))
    # new_d_list = find_positions(d_list)
    if args.debug:
        print("======= new d_list =======\n ",pprint.pformat(d_list))
    if args.debug:
        for d,i in d_list:
            print("line ",i)
            print_parsed_line(d)
            print(tape_output(d,fn="tm{0:03d}".format(i)))
    asy(d_list, args.output, replace_blanks=args.blanks)
        
# ===========================================================
if __name__ == '__main__':
    try:
        start_time = time.time()
        # Parser: See http://docs.python.org/dev/library/argparse.html
        parser = argparse.ArgumentParser(description=__doc__+
                                         "  Author: "+__author__
                                         +", Version: "+__version__
                                         +", License: "+__license__)
        parser.add_argument('-f', '--filename',
                            action='store',
                            default=None,
                            help="File with Turing machine output")
        parser.add_argument('-o', '--output',
                            action='store',
                            default='fsm',
                            help="Prefix of .asy filename, including location in the file tree. Default: (currentdir/)fsm")
        parser.add_argument('-b', '--blanks',
                            action='store_true',
                            default=False,
                            help="Convert B to blank. Default: {0!s}".format(False))
        parser.add_argument('-D', '--debug',
                            action='store_true',
                            default=DEBUG,
                            help="Run debugging code. Default: {0!s}".format(DEBUG))
        parser.add_argument('-L', '--log_level',
                            action='store',
                            type=str,
                            choices=LOG_LEVEL_CHOICES,
                            default=DEFAULT_LOG_LEVEL,
                            help="Set the logging level. Default: {0!s}".format(DEFAULT_LOG_LEVEL))
        parser.add_argument('-v', '--version',
                            action='version',
                            version=__version__)
        parser.add_argument('-V', '--verbose',
                            action='store_true',
                            default=False,
                            help='Give verbose output. Default: {0!s}'.format(VERBOSE))
        log.info("{0!s} Started".format(parser.prog))
        args = parser.parse_args()
        _set_log_level(log,args.log_level)        
        if args.debug:
            _set_log_level(log_fh,"DEBUG")
            _set_log_level(log,"DEBUG")
        elif args.verbose:
            _set_log_level(log_fh,"INFO")
            _set_log_level(log,"INFO")
        main(args)
        _set_log_level(log,"INFO")
        log.info("{0!s} Ended.  Elapsed time {1:0.2f} sec".format(parser.prog,time.time() - start_time))
        sys.exit(0)
    except KeyboardInterrupt as e:  # Ctrl-C
        raise e
    except SystemExit as e:  # sys.exit()
        raise e
    except Exception as e:
        print('ERROR, UNEXPECTED EXCEPTION')
        print(str(e))
        traceback.print_exc()
        os._exit(1)
