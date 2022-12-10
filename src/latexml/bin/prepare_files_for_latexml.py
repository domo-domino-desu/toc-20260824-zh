#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Massage the .tex files to make them work with LaTeXML
"""
__version__ = "0.0.1"
__author__ = "Jim Hefferon"
__license__ = "GPL 3.0"

__TODO__ = """
1) Add APPENDIX_SUBS, PREFACE_SUBS
"""

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

LATEXML = "latexml"  # used as a prefix for file names to make cleaning easier



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


def fname_list_build(arg):
    """From command-line arg, produce the fname list
      arg  String, either comma-separated list of chapters or 'all'
    """
    if arg.casefold() == 'all':
        return ALL_DIRS
    r = _fname_list_build(arg)
    if not(r):
        warning("List of chapters is empty")
    return r

def _fname_list_build(arg):
    """Go through command-line arg to produce the fname list
      arg  String, comma-separated list of chapters
    """
    alist = arg.split(",")
    alist = [s.strip() for s in alist]  # strip leading and trailing blanks
    r = []
    for s in alist:
        if not(s.casefold() in ALL_DIRS):
            warning("No such chapter: "+s)
        else:
            r.append(s.lower())
    return r
        

def includeonly_build(fname_list):
    """Return the \includeonly{..} list that includes things on fname_list"""
    includeonly_body = _includeonly_build(fname_list)
    r = ["\includeonly{"] + includeonly_body + ["}"]
    r.append("}")
    return "\n".join(r)

def _includeonly_build(fname_list):
    """Return list of strings for \includeonly{..} from fname_list"""
    r = []
    for d in ALL_DIRS:
        s = "{0}/{0}".format(d)
        if not(d == ALL_DIRS[-1]):
            s = s+","
        if not(d in fname_list):
            s = "% "+s
        r.append(s)
    return r



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
INCLUDEGRAPHICS_ASY_SHARE_DIR_RE = re.compile(INCLUDEGRAPHICS_ASY_SHARE_DIR)
INCLUDEGRAPHICS_ASY_SHARE_DIR_REPLACEMENT = "\\1\\\\includegraphics{latexml/asy/share/\\2.svg}\\3"
PROLOGUE_RE_SUBS[INCLUDEGRAPHICS_ASY_SHARE_DIR_RE]=INCLUDEGRAPHICS_ASY_SHARE_DIR_REPLACEMENT

INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR = "(.*)\\\\includegraphics{prologue/asy/([^/]*)/([^\\.]*)\\.pdf}(.*)"
INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_RE = re.compile(INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR)
INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_REPLACEMENT = "\\1\\\\includegraphics{latexml/prologue/asy/\\2/\\3.pdf}\\4"
PROLOGUE_RE_SUBS[INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_RE] = INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_REPLACEMENT

VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR = "(.*)\\\\vcenteredhbox{\\\\includegraphics{prologue/asy/([^/]*)/([^\\.]*)\\.pdf}}(.*)"
VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_RE = re.compile(VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR)
VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASY_SUBDIR_REPLACEMENT = "\\1\\\\vcenteredhbox{\\\\includegraphics{latexml/prologue/asy/\\2/\\3.svg}}\\4"

VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASYDIR = "(.*)\\\\vcenteredhbox{\\\\includegraphics{\\\\asydir\s* ([^/]*)/([^\\.]*)\\.pdf}}(.*)"
VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASYDIR_RE = re.compile(VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASYDIR)
VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASYDIR_REPLACEMENT = "\\1\\\\vcenteredhbox{\\\\includegraphics{latexml/prologue/asy/\\2/\\3.svg}}\\4"
PROLOGUE_RE_SUBS[VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASYDIR_RE] = VCENTEREDHBOX_INCLUDEGRAPHICS_PROLOGUE_ASYDIR_REPLACEMENT

TAPEGRAPHIC = "(.*)\\\\tapegraphic{\\\\tmexercises\\s* ([^\\.]*)\\.pdf}(.*)"
TAPEGRAPHIC_RE = re.compile(TAPEGRAPHIC)
TAPEGRAPHIC_REPLACEMENT = "\\\\includegraphics{latexml/prologue/asy/tm_exercises/pdfs/\\2.svg}}\\3"
PROLOGUE_RE_SUBS[TAPEGRAPHIC_RE] = TAPEGRAPHIC_REPLACEMENT

# ........... background .......................
BACKGROUND_RE_SUBS = {}  # map compiled regex -> substitution string

INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR = "(.*)\\\\includegraphics{background/asy/([^/]*)/([^\\.]*)\\.pdf}(.*)"
INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR_RE = re.compile(INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR)
INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR_REPLACEMENT = "\\1\\\\includegraphics{latexml/background/asy/\\2/\\3.pdf}\\4"
BACKGROUND_RE_SUBS[INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR_RE] = INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR_REPLACEMENT

VCENTEREDHBOX_INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR = "(.*)\\\\vcenteredhbox{\\\\includegraphics{background/asy/([^/]*)/([^\\.]*)\\.pdf}}(.*)"
VCENTEREDHBOX_INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR_RE = re.compile(VCENTEREDHBOX_INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR)
VCENTEREDHBOX_INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR_REPLACEMENT = "\\1\\\\vcenteredhbox{\\\\includegraphics{latexml/background/asy/\\2/\\3\.svg}}\\4"
BACKGROUND_RE_SUBS[VCENTEREDHBOX_INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR_RE] = VCENTEREDHBOX_INCLUDEGRAPHICS_BACKGROUND_ASY_SUBDIR_REPLACEMENT

# ........... languages .......................
LANGUAGES_RE_SUBS = {}  # map compiled regex -> substitution string

INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR = "(.*)\\\\includegraphics{languages/asy/([^/]*)/([^\\.]*)\\.pdf}(.*)"
INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR_RE = re.compile(INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR)
INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR_REPLACEMENT = "\\1\\\\includegraphics{latexml/languages/asy/\\2/\\3.pdf}\\4"
LANGUAGES_RE_SUBS[INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR_RE] = INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR_REPLACEMENT

VCENTEREDHBOX_INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR = "(.*)\\\\vcenteredhbox{\\\\includegraphics{languages/asy/([^/]*)/([^\\.]*)\\.pdf}}(.*)"
VCENTEREDHBOX_INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR_RE = re.compile(VCENTEREDHBOX_INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR)
VCENTEREDHBOX_INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR_REPLACEMENT = "\\1\\\\vcenteredhbox{\\\\includegraphics{latexml/languages/asy/\\2/\\3\.svg}}\\4"
LANGUAGES_RE_SUBS[VCENTEREDHBOX_INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR_RE] = VCENTEREDHBOX_INCLUDEGRAPHICS_LANGUAGES_ASY_SUBDIR_REPLACEMENT

# ........... automata .......................
AUTOMATA_RE_SUBS = {}  # map compiled regex -> substitution string

INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR = "(.*)\\\\includegraphics{automata/asy/([^/]*)/([^\\.]*)\\.pdf}(.*)"
INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR_RE = re.compile(INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR)
INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR_REPLACEMENT = "\\1\\\\includegraphics{latexml/automata/asy/\\2/\\3.pdf}\\4"
AUTOMATA_RE_SUBS[INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR_RE] = INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR_REPLACEMENT

VCENTEREDHBOX_INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR = "(.*)\\\\vcenteredhbox{\\\\includegraphics{automata/asy/([^/]*)/([^\\.]*)\\.pdf}}(.*)"
VCENTEREDHBOX_INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR_RE = re.compile(VCENTEREDHBOX_INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR)
VCENTEREDHBOX_INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR_REPLACEMENT = "\\1\\\\vcenteredhbox{\\\\includegraphics{latexml/automata/asy/\\2/\\3\.svg}}\\4"
AUTOMATA_RE_SUBS[VCENTEREDHBOX_INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR_RE] = VCENTEREDHBOX_INCLUDEGRAPHICS_AUTOMATA_ASY_SUBDIR_REPLACEMENT

# ........... complexity .......................
COMPLEXITY_RE_SUBS = {}  # map compiled regex -> substitution string

INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR = "(.*)\\\\includegraphics{complexity/asy/([^/]*)/([^\\.]*)\\.pdf}(.*)"
INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR_RE = re.compile(INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR)
INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR_REPLACEMENT = "\\1\\\\includegraphics{latexml/complexity/asy/\\2/\\3.pdf}\\4"
COMPLEXITY_RE_SUBS[INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR_RE] = INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR_REPLACEMENT

VCENTEREDHBOX_INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR = "(.*)\\\\vcenteredhbox{\\\\includegraphics{complexity/asy/([^/]*)/([^\\.]*)\\.pdf}}(.*)"
VCENTEREDHBOX_INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR_RE = re.compile(VCENTEREDHBOX_INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR)
VCENTEREDHBOX_INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR_REPLACEMENT = "\\1\\\\vcenteredhbox{\\\\includegraphics{latexml/complexity/asy/\\2/\\3\.svg}}\\4"
COMPLEXITY_RE_SUBS[VCENTEREDHBOX_INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR_RE] = VCENTEREDHBOX_INCLUDEGRAPHICS_COMPLEXITY_ASY_SUBDIR_REPLACEMENT

# Merge the maps together
RE_SUBS = PROLOGUE_RE_SUBS \
    | BACKGROUND_RE_SUBS \
    | LANGUAGES_RE_SUBS \
    | AUTOMATA_RE_SUBS \
    | COMPLEXITY_RE_SUBS


def convert_pdf_graphic_calls_to_svg_calls(fname):
    """Starting with the file fname, return string with changed graphic calls.
      fname  String path of LaTeX file 
    """
    bname = os.path.basename(fname)
    (root, ext) = os.path.splitext(bname)
    if root.lower() == "preface":
        sub_map = PREFACE_RE_SUBS
    elif root.lower() == "prologue":
        sub_map = PROLOGUE_RE_SUBS
    elif root.lower() == "background":
        sub_map = BACKGROUND_RE_SUBS
    elif root.lower() == "languages":
        sub_map = LANGUAGES_RE_SUBS
    elif root.lower() == "automata":
        sub_map = AUTOMATA_RE_SUBS
    elif root.lower() == "complexity":
        sub_map = COMPLEXITY_RE_SUBS
    elif root.lower() == "appendix":
        sub_map = APPENDIX_RE_SUBS
    else:
        critical("The file basename must be one of prologue.tex, background.tex, etc.")
    changed_file = asy_pdfs_to_latexml_svgs(fname, sub_map)
    write_to_latexml_file(fname, changed_file)


def asy_pdfs_to_latexml_svgs(fname, sub_map):
    """Inside the .tex file fname, change calls for a PDF graphic into calls 
    for an SVG graphic.  Return a string that is file with changes made.
         fname  Path to unopened file
         sub_map  Dict compiled regex -> substitution string
    """
    if DEBUG:
        log.debug("Converting {fname} PDF graphics calls to SVG calls".format(fname=fname))
    with open(fname, 'r', encoding="utf-8") as fh:
        newfile_string, counter =_asy_pdfs_to_latexml_svgs(fh, sub_map)
        return(newfile_string)
        

def _asy_pdfs_to_latexml_svgs(fh, sub_map):
    """Change calls for a PDF graphic into a call for an SVG.  Return string that
    is file with changes made.
         fname  Path to unopened file
         sub_map  Dict compiled regex -> substitution string
    """
    counter = 0  # useful to tell if a change made any difference
    r = []
    for line in fh:
        flag = False
        for compiled_re in sub_map:
            m = compiled_re.match(line)
            if m:
                flag = True
                if DEBUG:
                    log.debug(">>> "+line)
                    log.debug("   m="+str(m))
                    log.debug("      proposed replacement: "+sub_map[compiled_re])
                s = compiled_re.sub(sub_map[compiled_re],line)
                if DEBUG:
                    log.debug("      result: "+s)
                counter = counter+1
                r.append(s)
                break
        if not(flag):
            r.append(line)
    return ("".join(r), counter)
    

# === Handle latexml files ====================================

def get_latexml_filename(fname):
    """From the path fname, return the path string that has the basename
    prefixed with the constant LATEXML.
      fname  String representing Path to file
    """
    (path_dir, path_basename) =  os.path.split(fname)
    latexml_fname = os.path.join(path_dir,LATEXML+path_basename)
    return latexml_fname

def write_to_latexml_file(fname, s):
    """Write the string to a file whose basename starts with "latexml".
         fname  Path to a file whose name will be used (not prefixed with "latexml")
         s String, encoded as UTF-8
    """
    latexml_fname = get_latexml_filename(fname)
    with open(latexml_fname, 'w', encoding="utf-8") as fh:
        fh.write(s)

def read_from_latexml_file(fname):
    """Return lines read from a file whose basename starts with "latexml".
         fname  Path to a file whose name will be used (not prefixed with "latexml")
    """
    latexml_fname = get_latexml_filename(fname)
    with open(latexml_fname, 'r', encoding="utf-8") as fh:
        return fh.readlines()


# ===========================================================
# ===========================================================
# ===========================================================
def main(args):
    if args.debug:
        DEBUG=True
    if args.verbose:
        VERBOSE=True
    if args.filename is None:
        critical("You must give a filename")
    else:
        fname = args.filename
    # book_file_contents = book_to_latexmlbook("../book.tex")
    file_contents = convert_pdf_graphic_calls_to_svg_calls(args.filename)
    # print(file_contents)
        
# ===========================================================
if __name__ == '__main__':
    try:
        start_time = time.time()
        # Parser: See http://docs.python.org/dev/library/argparse.html
        parser = argparse.ArgumentParser(description=__doc__+
                                         "  Author: "+__author__
                                         +", Version: "+__version__
                                         +", License: "+__license__)
        # parser.add_argument('-f', '--filename',
        #                     action='store',
        #                     default=None,
        #                     help="File name")
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
        parser.add_argument("filename",
                            type=str,
                            default=None,
                            help="LaTeX file to be massaged (won't be changed)")
        log.info("{0!s} Started".format(parser.prog))
        args = parser.parse_args()
        _set_log_level(log,args.log_level)        
        if DEBUG or args.debug:
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
