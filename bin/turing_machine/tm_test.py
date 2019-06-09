#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Some command-line tests of turing-machine.rkt
"""
__version__ = "0.9.0"
__author__ = "Jim Hefferon"
__license__ = "GPL3"

import sys
import os
import traceback
import argparse
import time
import unittest

import tm_to_asy
import subprocess # for run command

PGM_ROOTNAME = os.path.splitext(os.path.basename(sys.argv[0]))[0]
PGM_SRC_DIR = os.path.dirname(__file__)

# Global variables spare me from putting them in the call of each fcn.
VERBOSE = False
DEBUG = False

class JHException(Exception):
    pass

def warn(s):
    t = 'WARNING: '+s+"\n"
    sys.stderr.write(t)
    sys.stderr.flush()

def error(s):
    t = 'ERROR! '+s
    sys.stderr.write(t)
    sys.stderr.flush()
    sys.exit(10)

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
TM_CMD_DIR = os.path.join(PGM_SRC_DIR, "..", "..", "src", "scheme", "prologue")

def run_tm(machine_filename, current_char='B', right_tape='', left_tape=''):
    """Run an instance of the Turing machine simulator
      machine_filename  string  Filename, including .tm.  Taken from 
        subdir in TM_CMD_DIR if such a file exists, else taken from 
        subdir machines/
      current_char  -ne-char string  Character under the machine's R/W head
      right_tape  string  Contents of the tape to the right of the head
      left_tape  string  Contents of tape to the left of the head
    """
    first_choice_filepath = os.path.join(TM_CMD_DIR,'machines',machine_filename)
    if os.path.exists(first_choice_filepath):
        fn = first_choice_filepath
    else:
        fn = "machines/{}".format(machine_filename)
        warn("The file {0:s} is not found, so using {1:s}".format(first_choice_filepath,fn))
    # print("fn is "+fn)
    return subprocess.run([os.path.join(TM_CMD_DIR,'turing-machine.rkt'),'-f', fn, '-c', current_char, '-l', left_tape, '-r', right_tape], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

# ============================================
def get_final_config(s):
    """From TM output, get the configuration tht preceeds halting
      s  string TM output
    """
    lines = s.splitlines()
    lines = [x.strip() for x in lines]
    d_list = tm_to_asy.parse_lines(lines)
    return d_list[-1][0]

def count_chars(config, c="1"):
    """Return the number of occurrences of the character above or to the 
    right of the head in the machine's configuration
     config  configuration dictionary; see tm_to_asy.py
     c  character
    """
    tau = config['currentchar']+config['suffix'] 
    return tau.count(c)

def is_empty(s):
    """Test if the string is empty, where B's are normalized to spaces.
      s  string
    """
    s = s.replace("B"," ")
    return s.strip() == ""
    
# ==============================================
class PredecessorTestCase(unittest.TestCase):
    """Tests the predecessor Turing machine."""

    # def test_run_tm(self):
    #     """See that the run_tm command works"""
    #     r = run_tm('pred.tm', '1', '111')
    #     print(r.stdout.decode(encoding='UTF-8'))
    
    def test_simple(self):
        """Do the dumbest possible thing"""
        i = 4
        sigma = "1"*i
        r = run_tm('pred.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        number_ones = count_chars(final_config)
        # print("number of 1's is {0!s}".format(number_ones))
        self.assertEqual(number_ones,3)
        
    def test_some(self):
        """Try it on an initial sequence of inputs"""
        for i in range(1,10):
            sigma = "1"*i
            r = run_tm('pred.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            number_ones = count_chars(final_config)
            self.assertEqual(number_ones,i-1,"Predecessor should remove a 1")
        
    def test_zero(self):
        """Try it on a zero input"""
        sigma = ""
        r = run_tm('pred.tm', 'B')
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        number_ones = count_chars(final_config)
        self.assertEqual(number_ones,0,"Zero input should give zero out")

    def test_equivalence_space_and_B(self):
        """Test that space and B are the same"""
        r_space = run_tm('pred.tm', ' ')
        r_B = run_tm('pred.tm', 'B')
        out_space = r_space.stdout.decode(encoding='UTF-8')
        out_B = r_B.stdout.decode(encoding='UTF-8')
        self.assertEqual(out_space,out_B,"Space and B should be the same")

    
# ==============================================
class AddTwoTestCase(unittest.TestCase):
    """Tests the addtwo Turing machine."""

    def test_simple(self):
        """Do the dumbest possible thing"""
        i, j = 2, 3
        sigma = ("1"*i) + " " + ("1"*j)
        r = run_tm('sum.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        number_ones = count_chars(final_config)
        # print("number of 1's is {0!s}".format(number_ones))
        self.assertEqual(number_ones,5)
        
    def test_some(self):
        """Try it on an initial sequence of inputs"""
        for i in range(1,5):
            for j in range(1,5):
                sigma = ("1"*i) + " " + ("1"*j)
                r = run_tm('sum.tm', sigma[0], sigma[1:])
                out = r.stdout.decode(encoding='UTF-8')
                # print(out)
                final_config = get_final_config(out)
                number_ones = count_chars(final_config)
                self.assertEqual(number_ones,i+j,"Addtwo should add them")
        
    def test_zeroes(self):
        """Try when one or both are zero"""
        for i,j in [(0,3), (3,0), (0,0)]:
            sigma = ("1"*i) + " " + ("1"*j)
            r = run_tm('sum.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            number_ones = count_chars(final_config)
            self.assertEqual(number_ones,i+j,"Addtwo should add even zeroes")

    
# ==============================================
class AddThreeTestCase(unittest.TestCase):
    """Tests the addthree Turing machine."""

    def test_simple(self):
        """Do the dumbest possible thing"""
        i = 4
        sigma = ("1"*i)
        r = run_tm('addthree.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        number_ones = count_chars(final_config)
        # print("number of 1's is {0!s}".format(number_ones))
        self.assertEqual(number_ones,7)
        
    def test_some(self):
        """Try it on an initial sequence of inputs"""
        for i in range(1,5):
            sigma = ("1"*i)
            r = run_tm('addthree.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            number_ones = count_chars(final_config)
            # print("number of 1's is {0!s}".format(number_ones))
            self.assertEqual(number_ones,i+3)
        
    def test_zeroes(self):
        """Try when the input is 0"""
        i = 0
        sigma = ("1"*i)
        r = run_tm('addthree.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        number_ones = count_chars(final_config)
        # print("number of 1's is {0!s}".format(number_ones))
        self.assertEqual(number_ones,3)
    
# ==============================================
class Decide010TestCase(unittest.TestCase):
    """Tests the decide010 Turing machine."""

    def test_a(self):
        """Test the first item"""
        for i in range(1,4):
            sigma = ("1"*i)
            r = run_tm('decide010a.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertEqual(sigma,final_config['prefix'])
        # Now test with an empty input
        sigma=""
        r = run_tm('decide010a.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertEqual(sigma,final_config['prefix'])

    def test_b(self):
        """Test the second item"""
        empty_string = ""
        for i in range(1,2):
            sigma = ("1"*i)
            r = run_tm('decide010b.tm', " ", "", sigma)
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertEqual(empty_string,final_config['suffix'])
        # Now test with an empty input
        sigma=""
        r = run_tm('decide010b.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertEqual(empty_string,final_config['suffix'])
        
    def test_c(self):
        """Test the full machine"""
        # A simple "yes"
        sigma="010"
        r = run_tm('decide010c.tm', "0", "10" )
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("1",final_config['currentchar'], "This should be a simple yes")
        # A simple "no"
        sigma="1101"
        r = run_tm('decide010c.tm', "1", "101" )
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("0",final_config['currentchar'], "This should be a simple no")
        # Various strings
        for sigma,ans in [("000101","1"), ("01","0"), ("010110101","1")]:
            r = run_tm('decide010c.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(is_empty(final_config['suffix']))
            self.assertEqual(ans,final_config['currentchar'], sigma+" should give "+ans)
        # Empty string
        sigma=""
        r = run_tm('decide010c.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("0",final_config['currentchar'],"Empty string is not a fit")

    
# ==============================================
class BlankOnesTestCase(unittest.TestCase):
    """Tests the blankones Turing machine."""

    def test_simple(self):
        """Test the dumbest thing"""
        i = 4
        sigma = ("1"*i)
        r = run_tm('blankones.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertTrue(is_empty(final_config['currentchar']),"All the four ones have been blanked")

    def test_some(self):
        """Test a few cases"""
        for i in range(1,3):
            sigma = ("1"*i)
            r = run_tm('blankones.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(is_empty(final_config['suffix']))
            self.assertTrue(is_empty(final_config['currentchar']),"All the {!s} ones have been blanked".format(i))


    
# ==============================================
class ConstantThreeTestCase(unittest.TestCase):
    """Tests the constantthree Turing machine."""

    def test_simple(self):
        """Test the dumbest thing"""
        i = 4
        sigma = ("1"*i)
        r = run_tm('constantthree.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual(final_config['suffix'],"11","Suffix has two 1's")
        self.assertEqual("1",final_config['currentchar'],"Current char is the leading 1")

    def test_some(self):
        """Test a few cases"""
        for i in range(1,3):
            sigma = ("1"*i)
            r = run_tm('constantthree.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertEqual(final_config['suffix'],"11","Suffix has two 1's")
            self.assertEqual("1",final_config['currentchar'],"Current char is the leading 1")

    def test_empty(self):
        """Test the empty input string"""
        sigma = ("")
        r = run_tm('constantthree.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual(final_config['suffix'],"11","Suffix has two 1's")
        self.assertEqual("1",final_config['currentchar'],"Current char is the leading 1")

            
# ===========================================================
def main(args):
    unittest.main()

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
