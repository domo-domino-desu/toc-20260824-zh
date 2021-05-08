#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Convert output from Turing machine simulator turing-machine.rkt 
for use in Asymptote.
"""
__version__ = "1.0.0"
__author__ = "Jim Hefferon"
__license__ = "GPL 3.0"

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
TEST_LINE = "step 1: q0:   BB*1*1101B "
TEST_LINES = """step 0: q0: *1*11
step 1: q0: 1*1*1
step 2: q0: 11*1*
step 3: q0: 111*B*
step 4: q1: 11*1*B
step 5: q1: 11*B*B
step 6: q2: 1*1*BB
step 7: q2: *1*1BB
step 8: q2: *B*11BB
step 9: q3: B*1*1BB
step 10: HALT
""".splitlines()

def get_input_file(fn):
    """Return a file.
      fn  string  Name of file.  If None then return stdin
    """
    if fn is None:
        return sys.stdin
    try:
        return open(fn, 'r')
    except IOError as e:
        critical("Input file {0!s} cannot be opened: {1!s}".format(fn,e))
            
def read_lines(f):
    """Return list of lines in the file.  Lines are stripped.
    """    
    lines = f.readlines()
    return [x.strip() for x in lines]

# Format example: TEST_LINE above
output_line_regex = r"step (\d*):\s*q(\d*):\s([^*]*)\*([^*]*)\*([^*:]*)\s*"
output_line_re = re.compile(output_line_regex, re.I)  # re.I in case capital q
def parse_line(lne,lne_no):
    """Return dictionary with the line's constituient parts (or None)
      lne  string  line of output from Turing machine simulator
    """
    m = output_line_re.match(lne)
    if m:
        return {'step': m.group(1),
                'state': m.group(2),
                'prefix': m.group(3),
                'currentchar': m.group(4),
                'suffix': m.group(5)}
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
        d = parse_line(lne,lne_no)
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
    print("state: {state}, prefix: {prefix}, current character: {currentchar}, suffix: {suffix}".format(**d))
  
def _find_position(prior_d, this_d):
    """Return a dictionary that adds information over those from
    parse_lines.  Specifically, add the fields 'position', which is the
    position of the head on the tape, where its initial position is 0.
    Also added is 'left_char_position' giving the position of the leftmost char
    now on the tape, and 'right_char_position'.
      prior_d this_d  dict  See parse_lines.
    """
    if prior_d is None:
        this_d['position'] = 0
        this_d['left_char_position'] = -len(this_d['prefix'])
        this_d['right_char_position'] = len(this_d['suffix'])
    # Else
    # detect an L
    elif ((len(this_d['prefix']) < len(prior_d['prefix']))
          or (len(this_d['suffix']) > len(prior_d['suffix']))):
        this_d['position'] = prior_d['position']-1
        this_d['left_char_position'] = min(this_d['position'],prior_d['left_char_position'])
        this_d['right_char_position'] = prior_d['right_char_position']
    # detect an R
    elif ((len(prior_d['prefix']) < len(this_d['prefix']))
          or (len(prior_d['suffix']) > len(this_d['suffix']))):
        this_d['position'] = prior_d['position']+1
        this_d['left_char_position'] = prior_d['left_char_position']
        this_d['right_char_position'] = max(this_d['position'],prior_d['right_char_position'])
    # No movement
    else:
        this_d['position'] = prior_d['position']
        this_d['left_char_position'] = prior_d['left_char_position']
        this_d['right_char_position'] = prior_d['right_char_position']
    return this_d

def find_positions(d_list):
    """Modify the list of dictionaries returned from parse_lines.  
    Specifically, add the fields 'position', which is the
    position of the head on the tape, where its initial position is 0.
    Also there is 'left_char_position' giving the position of the leftmost char
    now on the tape, and 'right_char_position'.
      d_list  list of dicts  See parse_lines.
    """
    prior_d, this_d = None, None
    new_list = []
    for d,line_no in d_list:
        this_d = d
        this_d = _find_position(prior_d, this_d)
        new_list.append((this_d,line_no))
        prior_d = this_d
    return new_list

def find_extreme_positions(d_list):
    """Find the furthest left and right postions taken by any char at any step
     d_list  list of dictionaries.  See parse_lines.
    """
    furthest_left, furthest_right = 0,0
    for d,line_no in d_list:
        furthest_left = min(furthest_left, d['left_char_position'])
        furthest_right = max(furthest_right, d['right_char_position'])
    return furthest_left, furthest_right
    
def tape_output(d,furthest_left,furthest_right,fn,replace_blanks=False):
    """Return a string giving one tape_output(...) line of the asy file
      d  dict  results of parsing the output line.
      furthest_left, furthest_right  integers  Furthest chars at any step.
      fn  string  Name of PDF file that Asy will output to.  
      replace_blanks=False  boolean  Replace 'B' with ' '?
    """
    position = int(d['position'])
    prefix = d['prefix']
    left_char_position = d['left_char_position']
    currentchar = d['currentchar']
    suffix = d['suffix']
    right_char_position = d['right_char_position']
    left_padding = " "*(d['left_char_position']-furthest_left)
    right_padding = " "*(furthest_right-d['right_char_position'])
    r = ['"'+fn+'"']  # Asy needs quotes to konw it is a string
    tape_string = left_padding+prefix+currentchar+suffix+right_padding
    if replace_blanks:
        tape_string = tape_string.replace("B"," ")
    r.append('"'+tape_string+'"')
    r.append("{:d}".format(+len(left_padding)+len(d['prefix'])))  # position of head
    r.append('"$\\state{'+d['state']+'}$"')
    return "tape_output("+",".join(r)+");"

ASY_HEAD = """// {0:s}.asy
// Draw a succession of tapes for a Turing machine computation
// This is generated by computing/bin/turing_machine/tm_to_asy.py

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

# Get the relative path from the current dir to the dir computing/src/asy
def rel_path_to_asy(from_dir=os.curdir):
    dex = from_dir.rfind(os.sep+"computing"+os.sep)
    asy_dir = os.path.join(from_dir[:dex],'computing/src/asy/')
    # print("rel_path_to_asy: from_dir is {0:s} asy_dir is {1:s}".format(from_dir,asy_dir))
    return os.path.relpath(asy_dir,start=from_dir)

# Create an .asy file
def asy(d_list, furthest_left, furthest_right, fn_prefix, replace_blanks = False):
    """Create an asy file and populate it with the tape_output lines
     d_list  list of dicts  Results of parsing a line
     furthest_left, furthest_right  integers  Posns of furthest chars ever.
     fn_prefix  string  Prefix of name of file Asy will output to.  Note that
       this routine adds "{:03d}" so three digits get appended to this prefix
     replace_blanks=False  boolean  Replace 'B' with ' '?
    """
    asy_dir = rel_path_to_asy(os.path.abspath(os.path.dirname(fn_prefix)))
    # print("fn_prefix is {0:s} asy_dir is {1:s}".format(fn_prefix,asy_dir))
    r = [ASY_HEAD.format(fn_prefix,asy_dir)]
    fn = os.path.basename(fn_prefix)+"{0:03d}"
    for d,i in d_list:
        r.append(tape_output(d,
                             furthest_left,
                             furthest_right,
                             fn=fn.format(i),
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
    new_d_list = find_positions(d_list)
    if args.debug:
        print("======= new d_list =======\n ",pprint.pformat(d_list))
    furthest_left, furthest_right = find_extreme_positions(new_d_list)
    # print("=== furthest_left is ",pprint.pformat(furthest_left)," furthest right=",pprint.pformat(furthest_right))
    if args.debug:
        for d,i in d_list:
            print("line ",i)
            print_parsed_line(d)
            print(tape_output(d,furthest_left,furthest_right,fn="tm{0:03d}".format(i)))
    asy(d_list, furthest_left, furthest_right, args.output, replace_blanks=args.blanks)
        
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
                            default='tm',
                            help="Prefix of .asy filename. Default: tm")
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
