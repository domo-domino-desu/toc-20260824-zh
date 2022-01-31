#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Some command-line tests of turing-machine.rkt
"""
__version__ = "0.9"
__author__ = "Jim Hefferon"
__license__ = "GPL3"

import sys
import os, os.path
import traceback, pprint
import argparse
import time
import unittest

import subprocess # for run command

# Get the name of this program
PGM_ROOTNAME = os.path.splitext(os.path.basename(sys.argv[0]))[0]
PGM_SRC_DIR = os.path.dirname(__file__)

# Import the original files for doing this
BIN_SUBDIR_RELATIVE_PATH = "../../../bin/turing_machine"
sys.path.insert(0, BIN_SUBDIR_RELATIVE_PATH)

from tm_test import TM_CMD_DIR, run_tm, normalize_blanks
from tm_to_asy import parse_lines, find_positions, find_extreme_positions

# Global variables spare me from putting them in the call of each fcn.
VERBOSE = False
DEBUG = False

class JHException(Exception):
    pass

# def warn(s):
#     t = 'WARNING: '+s+"\n"
#     sys.stderr.write(t)
#     sys.stderr.flush()

# def error(s):
#     t = 'ERROR! '+s
#     sys.stderr.write(t)
#     sys.stderr.flush()
#     sys.exit(10)

import logging
# create file handler which logs even debug messages
log = logging.getLogger()
# Potential logging levels: DEBUG | INFO | WARNING | ERROR | CRITICAL
if DEBUG:
    log.setLevel(logging.DEBUG)  
else:
    log.setLevel(logging.ERROR)  # DEBUG | INFO | WARNING | ERROR | CRITICAL
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - Line: %(lineno)d\n%(message)s')
sh = logging.StreamHandler()
sh.setLevel(logging.ERROR)
sh.setFormatter(formatter)
log.addHandler(sh)
fh = logging.FileHandler(os.path.abspath(os.path.join(
    os.path.dirname(__file__), 
    PGM_ROOTNAME + '.log')))
fh.setLevel(logging.ERROR)
fh.setFormatter(formatter)
log.addHandler(fh)

# ===========================
# Directory where the racket program is.
# TM_CMD_DIR = os.path.join(PGM_SRC_DIR, "..", "..", "src", "scheme", "prologue")

# def run_tm(machine_filename, current_char='B', right_tape='', left_tape='', max_steps=100):
#     """Run an instance of the Turing machine simulator
#       machine_filename  string  Filename, including .tm.  Taken from 
#         subdir in TM_CMD_DIR if such a file exists, else taken from 
#         subdir machines/
#       current_char  -ne-char string  Character under the machine's R/W head
#       right_tape  string  Contents of the tape to the right of the head
#       left_tape  string  Contents of tape to the left of the head
#     """
#     if len(current_char)!=1:
#         error("run_tm: The current_char must be a one-character string.")
#     first_choice_filepath = os.path.join(TM_CMD_DIR,'machines',machine_filename)
#     if os.path.exists(first_choice_filepath):
#         fn = first_choice_filepath
#     else:
#         fn = "machines/{}".format(machine_filename)
#         warn("The file {0:s} is not found, so using {1:s}".format(first_choice_filepath,fn))
#     # print("fn is "+fn)
#     return subprocess.run([os.path.join(TM_CMD_DIR,'turing-machine.rkt'),'-f', fn, '-c', current_char, '-l', left_tape, '-r', right_tape, '-s', "{:d}".format(max_steps)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

# ============================================
# def get_final_config(s):
#     """From TM output, get the configuration that preceeds halting
#       s  string TM output
#     """
#     lines = s.splitlines()
#     lines = [x.strip() for x in lines]
#     d_list = tm_to_asy.parse_lines(lines)
#     # print("tm_test.get_final_config: d_list is {0!s}".format(pprint.pformat(d_list)))
#     return d_list[-1][0]

# def count_chars(config, c="1"):
#     """Return the number of occurrences of the character above or to the 
#     right of the head in the machine's configuration
#      config  configuration dictionary; see tm_to_asy.py
#      c  character
#     """
#     tau = config['currentchar']+config['suffix'] 
#     return tau.count(c)

# def is_blank(s):
#     """Test if the string is space or a B.
#       s  string of one character
#     """
#     s = s.replace("B"," ")
#     return s == " "

# def normalize_blanks(s):
#     """Change B's to spaces.
#       s  string 
#     """
#     return s.replace("B"," ")

# def is_empty(s):
#     """Test if the string is empty, where B's are normalized to spaces.
#       s  string
#     """
#     s = s.replace("B"," ")
#     return s.strip() == ""

# def ending_state_number(final_config):
#     """Get as a natural number the number of the final state
#     """
#     return int(final_config['state'])

def trim_blanks(s):
    """Return the tape string with blanks pruned from both ends
    """
    return s.strip('B ')

def final_dict(ell):
    """Get the final (typically pre-HALT) ending dictionary
    """
    return ell[-1][0]

def check_final_config(ell, prefix="", currentchar="", suffix=""):
    """Return True if the final config has the given prefix, currentchar,
         and suffix
    """
    d = final_dict(ell)
    return(trim_blanks(normalize_blanks(d['prefix']))==trim_blanks(normalize_blanks(prefix))
           and d['currentchar']==currentchar
           and trim_blanks(normalize_blanks(d['suffix']))==trim_blanks(normalize_blanks(suffix)))



# ==============================================
# Directory where UTM machines being tested live, relative to
# the general dir of  machines
UTM_MACHINES_DIR = os.path.join("..", "..", "..", "..",
                                "src", "lab", "machines")

# ==============================================
class CopyTestCase(unittest.TestCase):
    """Tests the copy routine of the Universal Turing machine."""
    TM_NAME = os.path.join(UTM_MACHINES_DIR, "utm_copy.tm")

    def test_run_tm(self):
        """See that the run_tm command works"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11BBTBBB',
                   left_tape='',
                   max_steps=100)
        print(r.stdout.decode(encoding='UTF-8'))
    
    def test_simple(self):
        """See that something works"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11BBTBBB',
                   left_tape='',
                   max_steps=100,
                   verbose=True)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        # print(d_list[-1])
        self.assertTrue(check_final_config(d_list,prefix="",currentchar="S",suffix="11BBT11B"))
    
    def test_some(self):
        """Try some cases"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='1BBTBBB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="",currentchar="S",suffix="1BBT1BB"))
    
    def test_zero(self):
        """Try the edge case of copying a zero"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='BBBTBBB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="",currentchar="S",suffix="BBBTBBB"))
    
    def test_full(self):
        """Try the edge case of copying all 1's up to T"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='111TBBB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="",currentchar="S",suffix="111T111"))
    
    def test_empty(self):
        """Try the edge case of S adjacent to T"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='TBBB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="",currentchar="S",suffix="TBBB"))
        



# ==============================================
class FindmaxTestCase(unittest.TestCase):
    """Tests the findmax routine of the universal Turing machine."""
    TM_NAME = os.path.join(UTM_MACHINES_DIR, "utm_findmax.tm")

    def test_run_tm(self):
        """See that the run_tm command works, view steps"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11B1BTB',
                   left_tape='',
                   max_steps=100)
        print(r.stdout.decode(encoding='UTF-8'))
    
    def test_simple(self):
        """See that something works"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11B1BTB',
                   left_tape='',
                   max_steps=100,
                   verbose=True)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="11",currentchar="S",suffix="11B1BTB"))
    
    def test_ascending(self):
        """Numbers in interval ascending"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11B111BTB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="111",currentchar="S",suffix="11B111BTB"))
    
    def test_descending(self):
        """Numbers in interval descending"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='111B11BTB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="111",currentchar="S",suffix="111B11BTB"))
    
    def test_equal(self):
        """Numbers in interval equal"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11B11BTB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="11",currentchar="S",suffix="11B11BTB"))
    
    def test_zero(self):
        """Number in interval is zero"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='BBBTB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="B",currentchar="S",suffix="BBBTB"))

        



# ==============================================
class MatchTestCase(unittest.TestCase):
    """Tests the match routine of the universal Turing machine."""
    TM_NAME = os.path.join(UTM_MACHINES_DIR, "utm_match.tm")

    def test_run_tm(self):
        """See that the run_tm command works, view steps"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11B1BT11B',
                   left_tape='',
                   max_steps=100)
        print(r.stdout.decode(encoding='UTF-8'))
    
    def test_simple(self):
        """See that something works"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11B1BTB',
                   left_tape='',
                   max_steps=100,
                   verbose=True)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="11",currentchar="S",suffix="11B1BTB"))
    
    def test_ascending(self):
        """Numbers in interval ascending"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11B111BTB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="111",currentchar="S",suffix="11B111BTB"))
    
    def test_descending(self):
        """Numbers in interval descending"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='111B11BTB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="111",currentchar="S",suffix="111B11BTB"))
    
    def test_equal(self):
        """Numbers in interval equal"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='11B11BTB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="11",currentchar="S",suffix="11B11BTB"))
    
    def test_zero(self):
        """Number in interval is zero"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='BBBTB',
                   left_tape='',
                   max_steps=100)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="B",currentchar="S",suffix="BBBTB"))



# ==============================================
class MoveTestCase(unittest.TestCase):
    """Tests the move routine of the universal Turing machine."""
    TM_NAME = os.path.join(UTM_MACHINES_DIR, "utm_shiftright.tm")

    def test_run_tm(self):
        """See that the run_tm command works, view steps"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='B1BTB11B1B',
                   left_tape='1B',
                   max_steps=100)
        print(r.stdout.decode(encoding='UTF-8'))
    
    def test_simple(self):
        """See that something works"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='B1BTB11B',
                   left_tape='BB',
                   max_steps=100,
                   verbose=True)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="11",currentchar="S",suffix="B1BTB"))
    
    def test_double_blank(self):
        """After interval is two blanks"""
        r = run_tm(self.TM_NAME,
                   current_char='S',
                   right_tape='B1BTBBB',
                   left_tape='B',
                   max_steps=100,
                   verbose=True)
        out = r.stdout.decode(encoding='UTF-8')
        d_list = parse_lines(out.splitlines())
        self.assertTrue(check_final_config(d_list,prefix="BBB",currentchar="S",suffix="B1BTB"))
    
    # def test_descending(self):
    #     """Numbers in interval descending"""
    #     r = run_tm(self.TM_NAME,
    #                current_char='S',
    #                right_tape='111B11BTB',
    #                left_tape='',
    #                max_steps=100)
    #     out = r.stdout.decode(encoding='UTF-8')
    #     d_list = parse_lines(out.splitlines())
    #     self.assertTrue(check_final_config(d_list,prefix="111",currentchar="S",suffix="111B11BTB"))
    
    # def test_equal(self):
    #     """Numbers in interval equal"""
    #     r = run_tm(self.TM_NAME,
    #                current_char='S',
    #                right_tape='11B11BTB',
    #                left_tape='',
    #                max_steps=100)
    #     out = r.stdout.decode(encoding='UTF-8')
    #     d_list = parse_lines(out.splitlines())
    #     self.assertTrue(check_final_config(d_list,prefix="11",currentchar="S",suffix="11B11BTB"))
    
    # def test_zero(self):
    #     """Number in interval is zero"""
    #     r = run_tm(self.TM_NAME,
    #                current_char='S',
    #                right_tape='BBBTB',
    #                left_tape='',
    #                max_steps=100)
    #     out = r.stdout.decode(encoding='UTF-8')
    #     d_list = parse_lines(out.splitlines())
    #     self.assertTrue(check_final_config(d_list,prefix="B",currentchar="S",suffix="BBBTB"))


            
# ===========================================================

# Run only these tests
# how to discover all tests? not this: suite.addTests(DoublerTestCase())
def suite():
    suite = unittest.TestSuite()
    # suite.addTest(MoveTestCase('test_run_tm'))
    suite.addTest(MoveTestCase('test_double_blank'))
    suite.addTest(CopyTestCase('test_simple'))
    suite.addTest(FindmaxTestCase('test_simple'))
    # suite.addTest(MatchTestCase('test_simple'))
    suite.addTest(MoveTestCase('test_simple'))
    # suite.addTest(CopyTestCase('test_full'))
    # suite.addTest(CopyTestCase('test_empty'))
    return suite

def main(args):
    # unittest.main()
    runner = unittest.TextTestRunner()
    runner.run(suite())

# ===========================================================
if __name__ == '__main__':
    try:
        start_time = time.time()
        # Parser: See http://docs.python.org/dev/library/argparse.html
        parser = argparse.ArgumentParser(description=__doc__+
                                         "\n"+__author__
                                         +" version: "+__version__
                                         +" license: "+__license__)
        parser.add_argument('-D', '--debug', action='store_true', default=DEBUG, help='run debugging code')
        parser.add_argument('-v', '--version', action='version', version=__version__)
        parser.add_argument('-V', '--verbose', action='store_true', default=False, help='verbose output')
        args = parser.parse_args()
        if args.debug:
            fh.setLevel(logging.DEBUG)
            log.setLevel(logging.DEBUG)
        elif args.verbose:
            fh.setLevel(logging.INFO)
            log.setLevel(logging.INFO)
        log.info("%s Started" % parser.prog)
        main(args)
        log.info("%s Ended" % parser.prog)
        log.info("Total running time in seconds: %0.2f" % (time.time() - start_time))
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
