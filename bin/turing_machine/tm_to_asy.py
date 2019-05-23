#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Convert output from Turing machine simulator for use in Asymptote.
"""
__version__ = "0.8.0"
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
# print("ROOTNAME is "+PGM_ROOTNAME)
print("basename is "+os.path.basename(__file__).rstrip('.py'))

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
# TEST_LINES = """step 0: q0: *1*11 :0
# step 1: q0: 1*1*1 :1
# step 2: q0: 11*1* :2
# step 3: q0: 111*B* :3
# step 4: q1: 11*1*B :2
# step 5: q1: 11*B*B :2
# step 6: q2: 1*1*BB :1
# step 7: q2: *1*1BB :0
# step 8: q2: *B*11BB :-1
# step 9: q3: B*1*1BB :0
# step 10: HALT
# """.splitlines()
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
    if fn is None:
        return sys.stdin
    try:
        return open(fn, 'r')
    except IOError as e:
        critical("Input file {0!s} cannot be opened: {1!s}".format(fn,e))
            
def read_lines(f):
    lines = f.readlines()
    return [x.strip() for x in lines]

# Format example: "q0:   BB*1*1101B "
# output_line_regex = r"step (\d*):\s*q(\d*):\s([^*]*)\*([^*]*)\*([^*:]*)\s:([+-]?\d*)"
output_line_regex = r"step (\d*):\s*q(\d*):\s([^*]*)\*([^*]*)\*([^*:]*)\s*"
output_line_re = re.compile(output_line_regex, re.I)  # re.I in case capital q
def parse_line(lne,lne_no):
    """Split one line into the constituient parts
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
        # error("line number {0:d} not a regex match with {1:s}: {2:s}".format(line_no,output_line_re,lne))
        return None
    # error("line number {0:d} not a match: >>{1:s}<<".format(line_no,lne))
         
def parse_lines(lines):
    total_parsed = 0
    initial_offset_left, initial_offset_right = None, None
    min_pos, max_pos = 0, 0
    line_list = []
    for lne_no,lne in enumerate(lines):
        # print("lne is",lne)
        d = parse_line(lne,lne_no)
        if not(d is None):
            d['line'] = lne
            line_list.append((d,lne_no))
            # if total_parsed == 0:
            #     initial_offset_left = len(d['prefix'])
            #     initial_offset_right = len(d['suffix'])
            # total_parsed = total_parsed+1
            # pos = int(d['position'])
            # min_pos = min(min_pos, pos)
            # max_pos = max(max_pos, pos)
    return line_list

def print_parsed_line(d):
    """Show results of parsing the line, for debugging
     d  dict  Results from parsing a line
    """
    print("state: {state}, prefix: {prefix}, current character: {currentchar}, suffix: {suffix}".format(**d))
  
def find_position(prior_d, this_d):
    """From the TM tape, detect the action, and adjust the position of the
    head accordingly, where the position of the head is the number of squares
    from its starting position
      prior_d this_d  dict  See parse_line.
    """
    if prior_d is None:
        this_d['position'] = 0
        this_d['left_char_position'] = -len(this_d['prefix'])
        this_d['right_char_position'] = len(this_d['suffix'])
    # Else
    # detect an L
    elif ((len(this_d['prefix']) < len(prior_d['prefix']))
          or (len(this_d['suffix']) > len(prior_d['suffix']))):
        this_d['position'] = prior_d['position']+1
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
    """Find the furthest left character at each stage, and the furthest right.
    """
    prior_d, this_d = None, None
    new_list = []
    for d,line_no in d_list:
        this_d = d
        this_d = find_position(prior_d, this_d)
        new_list.append((this_d,line_no))
        prior_d = this_d
    return new_list

def find_extreme_positions(d_list):
    """Find the furthest left and right postions taken by any char at any step
     d_list list of dictionaries
    """
    furthest_left, furthest_right = 0,0
    for d,line_no in d_list:
        furthest_left = min(furthest_left, d['left_char_position'])
        furthest_right = max(furthest_right, d['right_char_position'])
    return furthest_left, furthest_right
    
def tape_output(d,furthest_left,furthest_right,fn="tm{0:03d}".format(0),replace_blanks=False):
    """Return a string giving one tape_output(...) line of the asy file
      d  dict  results of parsing the line
      fn  string  file name to which Asy will drop output
      tape_width  integer  Asy makes the tape this wide, in pts
    """
    position = int(d['position'])
    prefix = d['prefix']
    left_char_position = d['left_char_position']
    currentchar = d['currentchar']
    suffix = d['suffix']
    right_char_position = d['right_char_position']
    left_padding = " "*(d['left_char_position']-furthest_left)
    right_padding = " "*(furthest_right-d['right_char_position'])
    r = ['"'+fn+'"']
    tape_string = left_padding+prefix+currentchar+suffix+right_padding
    if replace_blanks:
        tape_string = tape_string.replace("B"," ")
    r.append('"'+tape_string+'"')
    r.append("{:d}".format(+len(left_padding)+len(d['prefix'])))  # position of head
    r.append('"$q_'+d['state']+'$"')
    return "tape_output("+",".join(r)+");"

ASY_HEAD = """// {0:s}.asy
//  draw succession of tapes for a Turing machine computation

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

# Get the relative path from the current dir to the computing/src/asy
def rel_path_to_asy(dir=os.getcwd()):
    dex = dir.rfind(os.sep+"computing"+os.sep)
    target_dir = os.path.join(dir[:dex],'computing/src/asy')
    return os.path.relpath(target_dir)

# Create an .asy file
def asy(d_list, furthest_left, furthest_right, fn_prefix, asy_dir = rel_path_to_asy(), replace_blanks = False):
    """Create an asy file and populate it with the tape_output lines
     d  dict result of parsing a line
     fn_prefix  string  name of output file
     asy_dir string  Relative Path to computing/src/asy from the current dir
    """
    r = [ASY_HEAD.format(fn_prefix,asy_dir)]
    fn = fn_prefix+"{0:03d}"
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

# ===========================================================
def main(args):
    # f = get_input_file(args.filename)
    d = parse_line(TEST_LINE,1)
    print_parsed_line(d)
    d_list = parse_lines(TEST_LINES)
    print("d_list is ",pprint.pformat(d_list))
    new_d_list = find_positions(d_list)
    print("======= new d_list =======\n ",pprint.pformat(d_list))
    furthest_left, furthest_right = find_extreme_positions(new_d_list)
    print("=== furthest_left is ",pprint.pformat(furthest_left)," furthest right=",pprint.pformat(furthest_right))
    for d,i in d_list:
        print("line ",i)
        print_parsed_line(d)
        print(tape_output(d,furthest_left,furthest_right,fn="tm{0:03d}".format(i)))
    asy(d_list, furthest_left, furthest_right, "tm", replace_blanks=True)
        
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
                            help="File with output. Default: stdin")
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
