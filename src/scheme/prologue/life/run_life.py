#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
run_life.py

Generate the .asy files for the Game of Life topic in the Theory of Computation
text.
"""
__version__ = "0.95.0"
__author__ = "Jim Hefferon"
__license__ = "GPL 3.0"

import sys
import os, os.path
import subprocess
import re, string
import traceback, pprint
import argparse
import time

import platform # Check Python version
from pathlib import Path # Create gameboards dir without race cond

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
_set_log_level(log_sh,"WARNING")
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

# The defaults (game,num_steps)
GAMES = [("beacon",10),
         ("beehive",1),
         ("blinker",2),
         ("block",1),
         ("eater",0),
         ("eateranim",35),
         ("glider",0),
         ("glideranim",16),
         ("glideranimr",16),
         ("lonely",1),
         ("mwss",0),
         ("mwssanim",28),
         ("rabbits",0),
         ]

# Where the .asy files will be compiled
PROLOGUE_ASY_LIFE_RELATIVE_DIR = "../../../prologue/asy/life/"
# Put the gameboards somewhere else, to make the dir more readable
GAMEBOARDS_DIRNAME = "gameboards"
PROLOGUE_ASY_LIFE_GAMEBOARDS_DIR = PROLOGUE_ASY_LIFE_RELATIVE_DIR+GAMEBOARDS_DIRNAME

def run_all_games(games, verbose=False):
    """ Run all the Game of Life simulations, giving output gameboards as files.
    games list of pairs (fn,num_steps)
    verbose=False
    Output file names will be like: blinker000.life, .. blinker008.life if
    num_steps=8.  The 000 file is the init file stripped of comments.
    """
    for (fn,num_steps) in games:
        # Copy the file from src/prologue/asy/life to here
        try:
            s = " ".join(["cp", PROLOGUE_ASY_LIFE_RELATIVE_DIR+fn+'.init', "."])
            log.info("Issued subprocess: "+s)
            r = subprocess.run(s, shell=True)
            if r.returncode < 0:
                log.error("File cp was terminated by signal "+str(-retcode))
            elif r.returncode != 0:
                log.error("cp command "+s+" returned nonzero code: "+str(r.returncode))
        except OSError as e:
            log.error("cp execution failed: "+str(e))
        # Run the simulator
        run_one_game(fn, num_steps, verbose=verbose)
        # Create Asymptote file to get num_steps-many .pdf outputs
        make_asy_file(fn, num_steps, verbose=verbose)
        # Move the resulting files from here to src/prologue/asy/life/gameboards
        try:
            fn_gameboard = fn+"[0-9][0-9][0-9].life"
            s = " ".join(["mv", fn_gameboard, PROLOGUE_ASY_LIFE_GAMEBOARDS_DIR])
            log.info("Issued subprocess: "+s)
            r = subprocess.run(s, shell=True)
            if r.returncode < 0:
                error("File mv "+fn_gameboard+" terminated by signal "+str(-retcode))
            elif r.returncode != 0:
                error("mv "+fn_gameboard+" returned nonzero code: "+str(r.returncode))
        except OSError as e:
            error("command "+s+" execution failed: "+str(e))
        # Move the Asymptote driver file to one dir up
        try:
            fn_all = fn+"_all.asy"
            s = " ".join(["mv", fn_all, PROLOGUE_ASY_LIFE_RELATIVE_DIR])
            log.info("Issued subprocess: "+s)
            r = subprocess.run(s, shell=True)
            if r.returncode < 0:
                error("mv "+fn_all+" terminated by signal "+str(-retcode))
            elif r.returncode != 0:
                error("mv "+fn_all+" returned nonzero code: "+str(r.returncode))
        except OSError as e:
            error("command "+s+" execution failed: "+str(e))
        # Run Asymptote
        # try:
        #     s = " ".join(["asy", fn+"_all.asy"])
        #     log.info("Issued subprocess: "+s)
        #     r = subprocess.run(s, shell=True)
        #     if r.returncode < 0:
        #         log.error("asy process was terminated by signal "+str(-retcode))
        #     elif r.returncode != 0:
        #         log.error("asy process returned nonzero code: "+str(r.returncode))
        # except OSError as e:
        #     log.error("asy process execution failed: "+str(e))
    return None


def run_one_game(fn, num_steps, verbose=False):
    """Run one Game of Life simulation, giving output gameboards as files.
    fn  string Initial gameboard. If using `blinker.init' then fn=`blinker'
    num_steps  integer  Number of generations to run.
    verbose=False
    Output file names will be like: blinker000.life, .. blinker008.life if
    num_steps=8.  The 000 file is the init file (stripped of comments).
    """
    try:
        s = " ".join(["./life.rkt", "-s "+str(num_steps), fn+".init"]) 
        log.info("Issued subprocess: "+s)
        r = subprocess.run(s, shell=True, capture_output=True)
        if r.returncode < 0:
            error("Run one Life game "+s+" was terminated by signal "+str(-retcode))
        elif r.returncode !=0:
            error("Run one Life game "+s+" returned nonzero code: "+str(r.returncode))
    except OSError as e:
        error("Run one Life game "+s+" execution failed: "+str(e))
    return r.returncode

ASY_FILE_CONTENTS="""// life_file.asy
// Running Asymptote on this file will make a graphic or a sequence 
// of graphics {{0}}000.pdf, {{0}}001.pdf, etc. for the Game of Life topic
// This file is generated by src/scheme/prologue/life/run_life.py

// Set up defaults
settings.outformat = \"pdf\";

// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jh;

// Get routine one_gameboard(..) that reads a plain text gameboard
import life;

string fn = \"{0}\";
for (int dex=0; dex<={1}; ++dex) {{
  picture p = one_gameboard(\"{2}\",fn,dex,0.25cm);
  shipout(fn+format(\"%03d\",dex), p);
}}
"""
def make_asy_file(fn, num_steps, verbose=False):
    log.info("make_asy_file: fn="+fn)
    with open(fn+"_all.asy", 'w', encoding="utf-8") as f:
        f.write(ASY_FILE_CONTENTS.format(fn, num_steps, GAMEBOARDS_DIRNAME))


# ===========================================================
def main(args):
    if args.verbose:
        VERBOSE=True
    if args.filename and args.steps:
        fn = args.filename
        if fn.endswith('.init'):
            fn = fn[:5]
        steps = int(args.steps)
        games = [(fn, steps)]
    elif args.filename:
        error("If you give a filename you must give a number of steps (it canbe 0)", 2)
    elif args.steps:
        error("If you give a number of steps then you must give a filename", 2)
    else:
        games = GAMES
    # If not there, create gameboards dir
    try:
        Path(PROLOGUE_ASY_LIFE_GAMEBOARDS_DIR).mkdir(parents=False, exist_ok=True)
    except FileNotFoundError as e:
        error("run_life.py: Parent directories of "+PROLOGUE_ASY_LIFE_GAMEBOARDS_DIR+" not found: "+str(e))
    except FileExistsError as e:
        error("run_life.py: Cannot make directory "+PROLOGUE_ASY_LIFE_GAMEBOARDS_DIR+" because a file by that name exists already: "+str(e))
    # Step through all the games
    run_all_games(games, True)
    # make_asy_file('test',42)
        
# ===========================================================
if __name__ == '__main__':
    try:
        start_time = time.time()
        # Parser: See http://docs.python.org/dev/library/argparse.html
        parser = argparse.ArgumentParser(description=__doc__+
                                         "  Author: "+__author__
                                         +", Version: "+__version__
                                         +", License: "+__license__
                                         +". Filenames and steps come in pairs so if you give one then you must give both"
                                         +". Best is to give neither, which rund  the defaults: so just $ ./run_life.py.")
        parser.add_argument('-f', '--filename',
                            action='store',
                            default=None,
                            help="File name, usually ending with .init")
        parser.add_argument('-s', '--steps',
                            action='store',
                            default=None,
                            help="Number of generations to run")
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
        # Check the Python version
        (python_version_major,python_version_minor,python_version_patchlevel) = platform.python_version_tuple()
        (major,minor)=(int(python_version_major),int(python_version_minor))
        if major < 3:
            error("Python version must be 3.5 or more; this is Python "+python_version_major)
        elif ((major == 3)
              and (minor < 5)): 
            error("Python version must be 3.5 or more; this is Python "+python_version_major+"."+python_version_minor)
        # If debug expected, log everythong
        if args.verbose:
            _set_log_level(log_fh,"DEBUG")
            _set_log_level(log_sh,"DEBUG")
            _set_log_level(log,"DEBUG")
        # Call the normal running
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
