#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Make animations for the web rather than rely on animate.sty
"""
__version__ = "0.9.0"
__author__ = "Jim Hefferon"
__license__ = "GPL 3.0"

__TODO__ = """
"""

import sys
import os, os.path
import re, string
import traceback, pprint
import argparse
import time

import subprocess

# Global variables spare me from putting them in the call of each fcn.
VERBOSE = False
DEBUG = False

PGM_ROOTNAME = os.path.splitext(os.path.basename(sys.argv[0]))[0]
PGM_DIR = os.path.dirname(__file__)

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

CHAPTER_DIRS = ["prologue",
                "background",
                "languages",
                "automata",
                "complexity"]
ALL_DIRS = ["preface"] + CHAPTER_DIRS + ["appendix"]


# =====================================================
# Regular expressions to match animation calls
# ANIMATE_STR = r"\s*\\animategraphics\[poster=([^\]]*)\]\{\d*\}\{([^\}]*)\}\{(\d*)\}\{(\d*)\}"
ANIMATE_STR = r"\s*\\animategraphics\[([^\]]*)\]\{\d*\}\{([^\}]*)\}\{([^\}]*)\}\{([^\}]*)\}.*"
ANIMATE_RE = re.compile(ANIMATE_STR)


# ===========================================================

# Full path to computing/src
SRC_DIR = os.path.normpath(os.path.join(PGM_DIR,"../../","src"))

# ASY_DIR Map chapter name to the constant \asydir used in those files.
# (This is used to allow the book and the slides to use the same graphics.)
ASY_DIR = {'prologue': 'prologue/asy/',
           # not used: 'background': ,
           # not used: 'languages':
           # not used 'automata':
           'complexity': 'complexity/asy/'
           } # dirs must end in '/'

def process_chapters(chapters, verbose=VERBOSE):
    """Run through each chapter, converting the animations.
        chapters  list of strings of chapter names  
    """
    chapters = [c.lower() for c in chapters]
    for c in chapters:
        if not(c in CHAPTER_DIRS):
            critical("No such chapter name: "+d)
    # Process them one at a time
    count = 0
    for c in chapters:
        if verbose:
            print("  chapter: "+c)
        count += process_chapter(c)
    return count

def _get_chapter_tex_filename(chapter):
    """From the string such as 'prologue' get the full path of the .tex file
        chapter  string chapter filename root
    This routine relies on the source file being in 
    <source tree top>/bin/tex4ht.  
    """
    p = os.path.normpath(os.path.join(SRC_DIR,chapter,chapter+".tex"))
    if DEBUG:
        print("_get_chapter_tex_filename: p="+p)
    return p
    
def process_chapter(chapter_rootname):
    """Go through the chapter tex file, getting the animation strings.
        chapter_rootname  string name of chapter, such as 'prologue'
    """
    tex_fname = _get_chapter_tex_filename(chapter_rootname)
    log.debug("process_chapter: tex_fname="+tex_fname)
    count = 0
    with open(tex_fname,'r') as f:
        for line in f:
            m = ANIMATE_RE.match(line)  # don't want search in case there is a % 
            if m:
                count +=1
                log.debug("process_chapter: Match="+line)
                poster = m.group(1)
                fn_prefix = m.group(2)
                start_dex = m.group(3)  # not a number, a string
                end_dex = m.group(4)
                if fn_prefix.startswith(r'\asydir '):
                    fn_prefix = ASY_DIR[chapter_rootname] + fn_prefix[len(r'\asydir '):]
                make_animations(poster, fn_prefix, start_dex, end_dex)
    log.debug("process_chapter: matches found in "+tex_fname+" is "+str(count))
    return count

# ===========================================================

def make_animations(poster, fn_prefix, start_dex, end_dex):
    """Create an animation suitable for the web
       poster string  either 'first' or 'last'
       fn_prefix  string  Start of name of files containing graphics
       start_dex  string  Digits of first such file
       end_dex  string  Digits of last such file
    This routine concatenates together the collection of pdf files numbered
    in that way. 
    """
    log.debug("make_animations: fn_prefix="+fn_prefix)
    log.debug("make_animations: fn_prefix="+fn_prefix)
    prefix_path = os.path.join(SRC_DIR,fn_prefix)  # full path
    if VERBOSE:
        print("    making "+prefix_path+" from "+start_dex+" to "+end_dex)
    num_digits = len(start_dex)
    fn_list =[]
    for dex in range(int(start_dex), int(end_dex)+1):
        fn = prefix_path + str(dex).rjust(num_digits,'0') + '.pdf'
        log.debug("  make_animations: fn="+fn)
        fn_list.append(fn)
    gif_fn = prefix_path+'.gif'
    log.debug("make_animations: gif_fn="+gif_fn)
    _make_animations(gif_fn, fn_list)

def _make_animations(gif_fn, fn_list):
    """Write an animated .gif to the directory containing gif_fn
       gif_fn  string  Full path to the created .gif
       fn_list list of strings
    """
    cmds = ['convert', '-delay 200', '-background white', '-density 300']
    cmds += fn_list
    cmds += ['-loop 0',]
    cmds += [gif_fn,]
    log.debug("_make_animations: cmds="+str(cmds))
    completed_process = subprocess.run(" ".join(cmds), shell=True, check=True)
        

# ===========================================================
def main(args):
    if args.debug:
        global DEBUG
        DEBUG = True
    if args.verbose:
        global VERBOSE
        VERBOSE = True
    if args.chapter is None:
        chapters = CHAPTER_DIRS
    else:
        chapters = args.chapter
    log.debug("main: chapters is "+str(chapters))
    process_chapters(chapters, args.verbose)
        
# ===========================================================
if __name__ == '__main__':
    try:
        start_time = time.time()
        # Parser: See http://docs.python.org/dev/library/argparse.html
        parser = argparse.ArgumentParser(description=__doc__+
                                         "  Author: "+__author__
                                         +", Version: "+__version__
                                         +", License: "+__license__)
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
        parser.add_argument("-c","--chapter",
                            type=str,
                            action='append',
                            default=None,
                            help="Chapter file to make animations for; can be called multiple times and if not called then all chapters are done")
        log.info("{0!s} Started".format(parser.prog))
        args = parser.parse_args()
        _set_log_level(log,args.log_level)        
        if DEBUG or args.debug:
            _set_log_level(log_fh,"DEBUG")
            _set_log_level(log,"DEBUG")
        elif args.verbose:
            _set_log_level(log_fh,"INFO")
            _set_log_level(log,"INFO")
        # Call the main routine
        main(args)
        # Clean up, report results
        # _set_log_level(log,"INFO")
        log.debug("{0!s} Ended.  Elapsed time {1:0.2f} sec".format(parser.prog,time.time() - start_time))
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
