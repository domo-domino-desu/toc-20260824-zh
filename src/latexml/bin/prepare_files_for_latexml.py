#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Massage the .tex files to make them work better with LaTeXML
"""
__version__ = "0.0.1"
__author__ = "Jim Hefferon"
__license__ = "GPL 3.0"

import sys
import os, os.path
import re, string
import traceback, pprint
import argparse
import time

# Global variables spare me from putting them in the call of each fcn.
VERBOSE = True
DEBUG = True

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

CHAPTER_DIRS = ["prologue",
                "background",
                "languages",
                "automata",
                "complexity"]
ALL_DIRS = ["preface"] + CHAPTER_DIRS + ["appendix"]




# =====================================================
# =========== convert book.tex to latexmlbook.tex
# ====================================================
BOOK_RE_SUBS = {}  # map compiled re -> substitution

DOCUMENTCLASS = "\\\\documentclass\\{computing\\}"
DOCUMENTCLASS_RE = re.compile(DOCUMENTCLASS)
DOCUMENTCLASS_REPLACEMENT = "\\\\documentclass{latexcomputing}"
BOOK_RE_SUBS[DOCUMENTCLASS_RE] = DOCUMENTCLASS_REPLACEMENT

# These names are misleading.  They are used to convert \includeonly{...} lines,
# but also used to convert \include{...} lines
INCLUDEONLY_PREFACE = r"(.*)preface/preface(%?)(,?)(\}?)(.*)"
INCLUDEONLY_PREFACE_RE = re.compile(INCLUDEONLY_PREFACE)
INCLUDEONLY_PREFACE_REPLACEMENT = "\\1preface/latexmlpreface\\2\\3\\4\\5"
BOOK_RE_SUBS[INCLUDEONLY_PREFACE_RE] = INCLUDEONLY_PREFACE_REPLACEMENT

INCLUDEONLY_PROLOGUE = "(.*)prologue/prologue(%?)(,?)(\\}?)(.*)"
INCLUDEONLY_PROLOGUE_RE = re.compile(INCLUDEONLY_PROLOGUE)
INCLUDEONLY_PROLOGUE_REPLACEMENT = "\\1prologue/latexmlprologue\\2\\3\\4\\5"
BOOK_RE_SUBS[INCLUDEONLY_PROLOGUE_RE] = INCLUDEONLY_PROLOGUE_REPLACEMENT

INCLUDEONLY_BACKGROUND = "(.*)background/background(%?)(,?)(\\}?)(.*)"
INCLUDEONLY_BACKGROUND_RE = re.compile(INCLUDEONLY_BACKGROUND)
INCLUDEONLY_BACKGROUND_REPLACEMENT = "\\1background/latexmlbackground\\2\\3\\4\\5"
BOOK_RE_SUBS[INCLUDEONLY_BACKGROUND_RE] = INCLUDEONLY_BACKGROUND_REPLACEMENT

INCLUDEONLY_LANGUAGES = "(.*)languages/languages(%?)(,?)(\\}?)(.*)"
INCLUDEONLY_LANGUAGES_RE = re.compile(INCLUDEONLY_LANGUAGES)
INCLUDEONLY_LANGUAGES_REPLACEMENT = "\\1languages/latexmllanguages\\2\\3\\4\\5"
BOOK_RE_SUBS[INCLUDEONLY_LANGUAGES_RE] = INCLUDEONLY_LANGUAGES_REPLACEMENT

INCLUDEONLY_AUTOMATA = "(.*)automata/automata(%?)(,?)(\\}?)(.*)"
INCLUDEONLY_AUTOMATA_RE = re.compile(INCLUDEONLY_AUTOMATA)
INCLUDEONLY_AUTOMATA_REPLACEMENT = "\\1automata/latexmlautomata\\2\\3\\4\\5"
BOOK_RE_SUBS[INCLUDEONLY_AUTOMATA_RE] = INCLUDEONLY_AUTOMATA_REPLACEMENT

INCLUDEONLY_COMPLEXITY = "(.*)complexity/complexity(%?)(,?)(\\}?)(.*)"
INCLUDEONLY_COMPLEXITY_RE = re.compile(INCLUDEONLY_COMPLEXITY)
INCLUDEONLY_COMPLEXITY_REPLACEMENT = "\\1complexity/latexmlcomplexity\\2\\3\\4\\5"
BOOK_RE_SUBS[INCLUDEONLY_COMPLEXITY_RE] = INCLUDEONLY_COMPLEXITY_REPLACEMENT

INCLUDEONLY_APPENDIX = "(.*)appendix/appendix(%?)(,?)(\\}?)(.*)"
INCLUDEONLY_APPENDIX_RE = re.compile(INCLUDEONLY_APPENDIX)
INCLUDEONLY_APPENDIX_REPLACEMENT = "\\1appendix/latexmlappendix\\2\\3\\4\\5"
BOOK_RE_SUBS[INCLUDEONLY_APPENDIX_RE] = INCLUDEONLY_APPENDIX_REPLACEMENT

def book_to_latexmlbook(fname):
    """Input book.tex, output latexmlbook.tex
         fname  Path to unopened file
    """
    counter = 0
    r = []
    with open(fname) as file:
        for line in file:
            flag = False
            for compiled_re in BOOK_RE_SUBS:
                m = compiled_re.match(line)
                if m:
                    flag = True
                    print(">>> ",line)
                    print("   m=",m)
                    print("      proposed replacement: ",BOOK_RE_SUBS[compiled_re])
                    s = compiled_re.sub(BOOK_RE_SUBS[compiled_re],line)
                    print("      result: ",s)
                    counter = counter+1
                    r.append(s)
                    break
            if not(flag):
                r.append(line)
    return "".join(r)


# =====================================================
# =========== convert PDF graphic calls to SVG ones
# ====================================================

# ........... prologue .......................
PROLOGUE_RE_SUBS = {}  # map compiled regex -> substitution string

# PDF's in src/asy/share
INCLUDEGRAPHICS_ASY_SHARE_DIR = "(.*)\\\\includegraphics{asy/share/([^\\.]*)\\.pdf}(.*)"
INCLUDEGRAPHICS_PROLOGUE_ASY_SHARE_DIR_RE = re.compile(INCLUDEGRAPHICS_ASY_SHARE_DIR)
INCLUDEGRAPHICS_ASY_SHARE_DIR_REPLACEMENT = "\\1\\\\includegraphics{latexml/asy/share/\\2.svg}\\3"
PROLOGUE_RE_SUBS[INCLUDEGRAPHICS_PROLOGUE_ASY_SHARE_DIR_RE]=INCLUDEGRAPHICS_ASY_SHARE_DIR_REPLACEMENT

INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR = "(.*)\\\\includegraphics{prologue/asy/([^/]*)/([^\\.]*)\\.pdf}(.*)"
INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_RE = re.compile(INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR)
INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_REPLACEMENT = "\\1\\\\includegraphics{prologue/asy/\\2/\\3.pdf}\\4"
PROLOGUE_RE_SUBS[INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_RE] = INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_REPLACEMENT

VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR = "(.*)\\\\vcenteredhbox{\\\\includegraphics{prologue/asy/([^/]*)/([^\\.]*)\\.pdf}}(.*)"
VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_RE = re.compile(VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR)
VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_REPLACEMENT = "\\1\\\\vcenteredhbox{\\\\includegraphics{prologue/asy/\\2/\\3\.svg}}\\4"
PROLOGUE_RE_SUBS[VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_RE] = VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_REPLACEMENT

TAPEGRAPHIC = "(.*)\\\\tapegraphic{\\\\tmexercises\\s* ([^\\.]*)\\.pdf}(.*)"
TAPEGRAPHIC_RE = re.compile(TAPEGRAPHIC)
TAPEGRAPHIC_REPLACEMENT = "\\\\includegraphics{latexml/prologue/asy/tm_exercises/pdfs/\\2.svg}}\\3"
PROLOGUE_RE_SUBS[TAPEGRAPHIC_RE] = TAPEGRAPHIC_REPLACEMENT

def asy_pdfs_to_latexml_svgs(fname):
    """Change calls for a PDF graphic into a call for an SVG.
         fname  Path to unopened file
    """
    counter = 0
    r = []
    with open(fname) as file:
        for line in file:
            flag = False
            for compiled_re in PROLOGUE_RE_SUBS:
                m = compiled_re.match(line)
                if m:
                    flag = True
                    print(">>> ",line)
                    print("   m=",m)
                    print("      proposed replacement: ",PROLOGUE_RE_SUBS[compiled_re])
                    s = compiled_re.sub(PROLOGUE_RE_SUBS[compiled_re],line)
                    print("      result: ",s)
                    counter = counter+1
                    r.append(s)
                    break
            if not(flag):
                r.append(line)
    return "".join(r)
    

# ===========================================================
def main(args):
    if args.debug:
        DEBUG=True
    if args.verbose:
        VERBOSE=True
    book_file_contents = book_to_latexmlbook("../book.tex")
    # file_contents = asy_pdfs_to_latexml_svgs(args.filename)
    # print(book_file_contents)
        
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
                            help="File name")
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
