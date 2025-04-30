#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Increment index line references in a LaTeX .ind file
"""
__version__ = "0.9.0"
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

NATURAL_REGEX = r'(\d+)$'
NATURAL_RE = re.compile(NATURAL_REGEX)
RANGE_REGEX = r'(\d+)--(\d+)$'
RANGE_RE = re.compile(RANGE_REGEX)
def page_list_increment(s, increment):
    """Convert comma-separated string list of integers to a list of integers.
Increment each number in that list, return comma-separated string list of 
integers
    s  string  comma separated list of natural numbers
    increment  integer  add to each member of the list
"""
    r = []
    list_of_strings = s.split(",")
    for s in list_of_strings:
        t = s.strip()
        m_natural = NATURAL_RE.match(t)
        m_range = RANGE_RE.match(t)
        if m_natural:
            r.append( str(increment+int(m_natural.group(1))) )
        elif m_range:
            first_page = str(increment+int(m_range.group(1)))
            second_page = str(increment+int(m_range.group(2)))
            r.append( first_page+"--"+second_page )
        else:
            error("unable to increment page: "+s)
    return ", ".join(r)

HYPERPAGE_REGEX = r'\\hyperpage\{'
HYPREPAGE_RE = re.compile(HYPERPAGE_REGEX)
PAGELIST_REGEX = r'([^}]*)(.*)$'
PAGELIST_RE = re.compile(PAGELIST_REGEX)
def process_line(line, increment):
    # print("----- new line ----\n",line)
    string_list = re.split(HYPREPAGE_RE,line)
    r = [string_list[0]]  
    for s in string_list[1:]:
        # print("  s=", s)
        m = PAGELIST_RE.match(s)
        if m:
            page_list = m.group(1)
            # print("  page_list=",page_list)
            incremented_page_string = page_list_increment(page_list,increment)
            r.append(incremented_page_string+m.group(2))
        else:
            r.append(s)
    return "\\hyperpage{".join(r)
    

def readfile(fn, increment):
    with open(fn, "r") as f:
        line = f.readline()
        while line:
            result = process_line(line, increment)
            print(result)
            # print("result="+result+"\n===============") 
            line = f.readline()

# ===========================================================
def main(args):
    if args.debug:
        DEBUG=True
    if args.verbose:
        VERBOSE=True
    readfile(args.filename,int(args.increment))
        
        
# ===========================================================
DEFAULT_INCREMENT = 10
if __name__ == '__main__':
    try:
        start_time = time.time()
        # Parser: See http://docs.python.org/dev/library/argparse.html
        parser = argparse.ArgumentParser(description=__doc__+
                                         "  Author: "+__author__
                                         +", Version: "+__version__
                                         +", License: "+__license__)
        parser.add_argument('filename',
                            action='store',
                            default="book.ind",
                            help="File name")
        parser.add_argument('-i', '--increment',
                            action='store',
                            default=DEFAULT_INCREMENT,
                            help="Increment to apply. Default: {0!s}".format(DEFAULT_INCREMENT))
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
        log.error(traceback.format_exc())
        traceback.print_exc()
        os._exit(1)
