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
import traceback, pprint
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

def run_tm(machine_filename, current_char='B', right_tape='', left_tape='', max_steps=100):
    """Run an instance of the Turing machine simulator
      machine_filename  string  Filename, including .tm.  Taken from 
        subdir in TM_CMD_DIR if such a file exists, else taken from 
        subdir machines/
      current_char  -ne-char string  Character under the machine's R/W head
      right_tape  string  Contents of the tape to the right of the head
      left_tape  string  Contents of tape to the left of the head
    """
    if len(current_char)!=1:
        error("run_tm: The current_char must be a one-character string.")
    first_choice_filepath = os.path.join(TM_CMD_DIR,'machines',machine_filename)
    if os.path.exists(first_choice_filepath):
        fn = first_choice_filepath
    else:
        fn = "machines/{}".format(machine_filename)
        warn("The file {0:s} is not found, so using {1:s}".format(first_choice_filepath,fn))
    # print("fn is "+fn)
    return subprocess.run([os.path.join(TM_CMD_DIR,'turing-machine.rkt'),'-f', fn, '-c', current_char, '-l', left_tape, '-r', right_tape, '-s', "{:d}".format(max_steps)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

# ============================================
def get_final_config(s):
    """From TM output, get the configuration tht preceeds halting
      s  string TM output
    """
    lines = s.splitlines()
    lines = [x.strip() for x in lines]
    d_list = tm_to_asy.parse_lines(lines)
    # print("tm_test.get_final_config: d_list is {0!s}".format(pprint.pformat(d_list)))
    return d_list[-1][0]

def count_chars(config, c="1"):
    """Return the number of occurrences of the character above or to the 
    right of the head in the machine's configuration
     config  configuration dictionary; see tm_to_asy.py
     c  character
    """
    tau = config['currentchar']+config['suffix'] 
    return tau.count(c)

def is_blank(s):
    """Test if the string is space or a B.
      s  string of one character
    """
    s = s.replace("B"," ")
    return s == " "

def normalize_blanks(s):
    """Change B's to spaces.
      s  string 
    """
    return s.replace("B"," ")

def is_empty(s):
    """Test if the string is empty, where B's are normalized to spaces.
      s  string
    """
    s = s.replace("B"," ")
    return s.strip() == ""

def ending_state_number(final_config):
    """Get as a natural number the number of the final state
    """
    return int(final_config['state'])
    
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
        self.assertEqual("1",final_config['currentchar'],"The ")

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


    
# ==============================================
class DoublerTestCase(unittest.TestCase):
    """Tests the doubler Turing machine."""

    def test_simple(self):
        """Test the dumbest thing"""
        i = 2
        sigma = "1"*i
        r = run_tm('doubler.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual(final_config['suffix'],"111","Suffix has three 1's")
        self.assertEqual("1",final_config['currentchar'],"Current char is the leading 1")

    def test_some(self):
        """Test a few cases"""
        for i in range(1,4):
            sigma = ("1"*i)
            r = run_tm('doubler.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertEqual(final_config['suffix'],"1"*(2*i-1),"Suffix has {0!s} 1's".format(2*i-1))
            self.assertEqual("1",final_config['currentchar'],"Current char is the leading 1")

    def test_empty(self):
        """Test input of zero"""
        sigma = ""
        r = run_tm('doubler.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']),"Suffix has zero 1's")
        self.assertTrue(is_blank(final_config['currentchar']),"Current char is a blank")
            


    
# ==============================================
class DoublerBinaryTestCase(unittest.TestCase):
    """Tests the doublerbinary Turing machine."""

    def test_simple(self):
        """Test the dumbest thing"""
        i = 2
        sigma = "{0:b}".format(i)
        r = run_tm('doublerbinary.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual(final_config['suffix'],"00","Suffix has two 0's")
        self.assertEqual("1",final_config['currentchar'],"Current char is the leading 1 for 4 in binary")

    def test_some(self):
        """Test a few cases"""
        for i in range(1,7):
            sigma = "{0:b}".format(i)
            r = run_tm('doublerbinary.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            expected_outcome = "{0:b}".format(2*i)
            self.assertEqual(final_config['suffix'],expected_outcome[1:])
            self.assertEqual(final_config['currentchar'],expected_outcome[0])

    def test_zero(self):
        """Test input of zero"""
        sigma = "0"
        r = run_tm('doublerbinary.tm', "0")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        expected_outcome = "0"
        self.assertEqual(final_config['suffix'],expected_outcome[1:])
        self.assertEqual(final_config['currentchar'],expected_outcome[0])
            


    
# ==============================================
class OddTestCase(unittest.TestCase):
    """Tests the odd Turing machine."""

    def test_simple(self):
        """Test the dumbest thing"""
        i = 3
        sigma = "1"*1
        r = run_tm('odd.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("1",final_config['currentchar'],"3 is odd")

    def test_some(self):
        """Test a few cases"""
        for i in range(1,7):
            sigma = "1"*i
            r = run_tm('odd.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(is_empty(final_config['suffix']))
            if ((i % 2) == 1):
                self.assertEqual("1",final_config['currentchar'],"The number {0:d} is odd".format(i))
            else:
                self.assertTrue(is_blank(final_config['currentchar']),"The number {0:d} is even".format(i))

    def test_zero(self):
        """Test input of zero"""
        sigma = ""
        r = run_tm('odd.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertTrue(is_blank(final_config['currentchar']),"The number 0 is even")

    
# ==============================================
class SuccessorTestCase(unittest.TestCase):
    """Tests the successor Turing machine."""

    def test_simple(self):
        """Test the dumbest thing"""
        i = 3
        sigma = "1"*1
        r = run_tm('successor.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(count_chars(final_config),i+1)
        self.assertEqual("1",final_config['currentchar'])

    def test_some(self):
        """Test a few cases"""
        for i in range(1,9):
            sigma = "1"*1
            r = run_tm('successor.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(count_chars(final_config),i+1)
            self.assertEqual("1",final_config['currentchar'])

    def test_zero(self):
        """Test input of zero"""
        sigma = ""
        r = run_tm('successor.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("1",final_config['currentchar'],"The successsor of 0 is 1")
            

    
# ==============================================
class LeqTestCase(unittest.TestCase):
    """Tests the leq Turing machine."""

    def test_simple(self):
        """Test the dumbest thing"""
        i, j = 2, 3
        sigma = ("1"*i) + " " + ("1"*j)
        r = run_tm('leq.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("1",final_config['currentchar'],"Indeed, 2 leq 3")

    def test_some(self):
        """Test a few cases"""
        for i in range(1,7):
            for j in range(1,7):
                sigma = ("1"*i) + " " + ("1"*j)
                r = run_tm('leq.tm', sigma[0], sigma[1:],max_steps=250)
                out = r.stdout.decode(encoding='UTF-8')
                # print(out)
                final_config = get_final_config(out)
                self.assertTrue(is_empty(final_config['prefix']),"Nonempty prefix when i={0:d} j={1:d}".format(i,j))
                self.assertTrue(is_empty(final_config['suffix']))
                if (i<=j):
                    self.assertEqual("1",final_config['currentchar'],"Indeed, 2 leq 3")
                else:
                    self.assertTrue(is_blank(final_config['currentchar']))

    def test_zero(self):
        """Test input of zero"""
        for i in range(0,3):
            for j in range(0,3):
                sigma = ("1"*i) + " " + ("1"*j)
                r = run_tm('leq.tm', sigma[0], sigma[1:],max_steps=250)
                out = r.stdout.decode(encoding='UTF-8')
                print(out)
                final_config = get_final_config(out)
                self.assertTrue(is_empty(final_config['prefix']),"Nonempty prefix when i={0:d} j={1:d}".format(i,j))
                self.assertTrue(is_empty(final_config['suffix']))
                if (i<=j):
                    self.assertEqual("1",final_config['currentchar'],"Indeed, 2 leq 3")
                else:
                    self.assertTrue(is_blank(final_config['currentchar']))

    
# ==============================================
class BitwiseOpsTestCase(unittest.TestCase):
    """Tests the bitwise operations Turing machines."""

    def test_not(self):
        """Test bitwise NOT"""
        sigma = "1001" 
        r = run_tm('bitwisenot.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual("110",final_config['suffix'])
        self.assertEqual("0",final_config['currentchar'])
        for i in range(0,16):
            sigma = "{:04b}".format(i)
            r = []
            for x in sigma:
                if (x=="0"):
                    r.append("1")
                else:
                    r.append("0")
            sigmacomp = "".join(r)
            # print("sigma={0:s} and sigmacomp={1:s}".format(sigma,sigmacomp))
            r = run_tm('bitwisenot.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertEqual(sigmacomp[1:],final_config['suffix'])
            self.assertEqual(sigmacomp[0],final_config['currentchar'])
    
# ==============================================
class SingleBitTestCase(unittest.TestCase):
    """Tests the single bit operations Turing machines."""

    def test_not(self):
        """Test single bit NOT"""
        sigma = "0" 
        r = run_tm('singlebitnot.tm', sigma[0])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("1",final_config['currentchar'])
        sigma = "1" 
        r = run_tm('singlebitnot.tm', sigma[0])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("0",final_config['currentchar'])

    def test_and(self):
        """Test single bit AND"""
        for (sigma,ans) in [("00","0"),
                            ("01","0"),
                            ("10","0"),
                            ("11","1")]: 
            r = run_tm('singlebitand.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(is_empty(final_config['suffix']))
            self.assertEqual(ans,final_config['currentchar'])

    def test_or(self):
        """Test single bit OR"""
        for (sigma,ans) in [("00","0"),
                            ("01","1"),
                            ("10","1"),
                            ("11","1")]: 
            r = run_tm('singlebitor.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(is_empty(final_config['suffix']))
            self.assertEqual(ans,final_config['currentchar'])

            
    
# ==============================================
class Append01TestCase(unittest.TestCase):
    """Tests the append 01 operations Turing machines."""

    def test_simple(self):
        """Test some dumb thing"""
        sigma = "1111" 
        r = run_tm('append01.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual(sigma[1:]+"01",final_config['suffix'])
        self.assertEqual(sigma[0],final_config['currentchar'])

    def test_some(self):
        """Test a few cases"""
        for sigma,tau in [("00","0001"),
                          ("1","101")]:
            r = run_tm('append01.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertEqual(tau[1:],final_config['suffix'])
            self.assertEqual(tau[0],final_config['currentchar'])

    def test_blank(self):
        """Test if the input string is blank"""
        r = run_tm('append01.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual("1",final_config['suffix'])
        self.assertEqual("0",final_config['currentchar'])

            
    
# ==============================================
class AddAnyTestCase(unittest.TestCase):
    """Tests the add any operations Turing machines."""

    def test_simple(self):
        """Test some dumb thing"""
        sigma = "11,1,11" 
        r = run_tm('addany.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual("1111",normalize_blanks(final_config['suffix']).strip())
        self.assertEqual("1",final_config['currentchar'])

    def test_some(self):
        """Test a few cases"""
        for sigma,tau in [("1,1","11"),
                          ("111,1111,1","11111111")]:
            r = run_tm('addany.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertEqual(tau[1:],normalize_blanks(final_config['suffix']).strip())
            self.assertEqual("1",final_config['currentchar'])

    def test_one(self):
        """Test no commas"""
        sigma = "11" 
        r = run_tm('addany.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertEqual(sigma[1:],normalize_blanks(final_config['suffix']).strip())
        self.assertEqual(sigma[0],final_config['currentchar'])

    def test_blank(self):
        """Test if the input string is blank"""
        r = run_tm('addany.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertTrue(is_blank(final_config['currentchar']))

            
    
# ==============================================
# class DuplicateTestCase(unittest.TestCase):
#     """Tests the duplication operations Turing machines."""

#     def test_simple(self):
#         """Test some dumb thing"""
#         sigma = "11" 
#         r = run_tm('duplicate.tm', sigma[0], sigma[1:])
#         out = r.stdout.decode(encoding='UTF-8')
#         print(out)
#         # final_config = get_final_config(out)
#         # self.assertTrue(is_empty(final_config['prefix']))
#         # self.assertEqual("1111",normalize_blanks(final_config['suffix']).strip())
#         # self.assertEqual("1",final_config['currentchar'])

#     # def test_some(self):
#     #     """Test a few cases"""
#     #     for sigma,tau in [("1,1","11"),
#     #                       ("111,1111,1","11111111")]:
#     #         r = run_tm('addany.tm', sigma[0], sigma[1:])
#     #         out = r.stdout.decode(encoding='UTF-8')
#     #         # print(out)
#     #         final_config = get_final_config(out)
#     #         self.assertTrue(is_empty(final_config['prefix']))
#     #         self.assertEqual(tau[1:],normalize_blanks(final_config['suffix']).strip())
#     #         self.assertEqual("1",final_config['currentchar'])

#     # def test_one(self):
#     #     """Test no commas"""
#     #     sigma = "11" 
#     #     r = run_tm('addany.tm', sigma[0], sigma[1:])
#     #     out = r.stdout.decode(encoding='UTF-8')
#     #     # print(out)
#     #     final_config = get_final_config(out)
#     #     self.assertTrue(is_empty(final_config['prefix']))
#     #     self.assertEqual(sigma[1:],normalize_blanks(final_config['suffix']).strip())
#     #     self.assertEqual(sigma[0],final_config['currentchar'])

#     # def test_blank(self):
#     #     """Test if the input string is blank"""
#     #     r = run_tm('addany.tm', " ")
#     #     out = r.stdout.decode(encoding='UTF-8')
#     #     print(out)
#     #     final_config = get_final_config(out)
#     #     self.assertTrue(is_empty(final_config['prefix']))
#     #     self.assertTrue(is_empty(final_config['suffix']))
#     #     self.assertTrue(is_blank(final_config['currentchar']))

            
    
# ==============================================
class PalindromeTestCase(unittest.TestCase):
    """Tests the palindrome Turing machines."""

    def test_simple(self):
        """Test some dumb thing"""
        sigma = "abba" 
        r = run_tm('palindrome.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("1",final_config['currentchar'])

    def test_some(self):
        """Test a few cases"""
        for sigma in ["aa", "bbbb"]:
            r = run_tm('palindrome.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(is_empty(final_config['suffix']))
            self.assertEqual("1",final_config['currentchar'])
        for sigma in ["aba","bbabb","a"]:
            r = run_tm('palindrome.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(is_empty(final_config['suffix']))
            self.assertEqual("1",final_config['currentchar'])
        # These are non-palindromes
        for sigma in ["ab","bbab"]:
            r = run_tm('palindrome.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertTrue(is_empty(final_config['prefix']))
            self.assertTrue(is_empty(final_config['suffix']))
            self.assertTrue(is_blank(final_config['currentchar']))

    def test_blank(self):
        """Test a blank input string"""
        r = run_tm('palindrome.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        print(out)
        final_config = get_final_config(out)
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertEqual("1",final_config['currentchar'])

            
    
# ==============================================
class TwobsTestCase(unittest.TestCase):
    """Tests the two b's Turing machines."""

    def test_simple(self):
        """Test some dumb thing"""
        sigma = "abba" 
        r = run_tm('twobs.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertEqual(3,ending_state_number(final_config))

    def test_some(self):
        """Test a few cases"""
        for sigma in ["aabb", "bbbb", "bbaaa", "bb"]:
            r = run_tm('twobs.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertEqual(3,ending_state_number(final_config),"Expected {0:s} to succeed".format(sigma))
        # These do not have "bb"
        for sigma in ["aba", "babab", "aa", "b"]:
            r = run_tm('twobs.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertEqual(4,ending_state_number(final_config),"Expected {0:s} to fail".format(sigma))

    def test_empty(self):
        """Test an empty input string"""
        r = run_tm('twobs.tm', " ")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertEqual(4,ending_state_number(final_config), "Expected the empty input string to succeed")

            
    
# ==============================================
class MuEx1TestCase(unittest.TestCase):
    """Tests an exercise in the mu-recursion section."""

    def test_simple(self):
        """Test some dumb thing"""
        sigma = "1"*4 
        r = run_tm('mu_ex1.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertEqual(5,count_chars(final_config))

    def test_some(self):
        """Test a few cases"""
        for i in range(1,6):
            sigma = "1"*i 
            r = run_tm('mu_ex1.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertEqual(i+1,count_chars(final_config))

    def test_empty(self):
        """Test the empty string""" 
        r = run_tm('mu_ex1.tm', " ", "")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertEqual(1,count_chars(final_config))

            
    
# ==============================================
class MuEx2TestCase(unittest.TestCase):
    """Tests an exercise in the mu-recursion section."""

    def test_simple(self):
        """Test some dumb thing"""
        sigma = "1"*4 
        r = run_tm('mu_ex2.tm', sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertEqual(5,count_chars(final_config))

    def test_some(self):
        """Test a few cases"""
        for i in range(1,6):
            sigma = "1"*i 
            r = run_tm('mu_ex2.tm', sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.assertEqual(i+1,count_chars(final_config))

    def test_empty(self):
        """Test the empty string""" 
        r = run_tm('mu_ex2.tm', " ", "")
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        self.assertEqual(1,count_chars(final_config))

            
    
# ==============================================
class StartsWithZeroTestCase(unittest.TestCase):
    """Tests exercise in intro acting as char fcn of set of strings starting with zero."""

    TM_FILE_NAME = 'startswithzero.tm'

    def is_char_function(self,final_config):
        """Test a finished machine acts as a characteristic function, so all 
           cells are blank except the one under the head, and that one has 
           either '0' or '1'
             final_config  dictionary returned by get_final_config
        """
        self.assertTrue(is_empty(final_config['prefix']))
        self.assertTrue(is_empty(final_config['suffix']))
        self.assertTrue(final_config['currentchar'] in ['1','0'])
    
    def test_simple(self):
        """Test some dumb thing"""
        sigma = "0"*4 
        r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out) # show the machine's output for debugging
        final_config = get_final_config(out)
        self.assertEqual(1,count_chars(final_config))
        # acts as a function?
        # print("final_config is {0!s}".format(pprint.pformat(final_config)))
        self.is_char_function(final_config)
        self.assertTrue(final_config['currentchar']=='1')

    def test_empty(self):
        """Test the empty string"""
        sigma = " "
        r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        # print("final_config is {0!s}".format(pprint.pformat(final_config)))
        self.is_char_function(final_config)
        self.assertTrue(final_config['currentchar']=='0')
        
    def test_some(self):
        """Test a few cases"""
        # Starts with 1
        for i in range(1,6):
            sigma = "1"+("1"*i) 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='0')
        # Starts with 0
        for i in range(1,6):
            sigma = "0"+("1"*i) 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='1')
        # Starts with 0, mix of chars
        for i in range(1,3):
            sigma = "0"+("01"*i) 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='1')
        # Starts with 1, mix of chars
        for i in range(1,3):
            sigma = "1"+("01"*i) 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='0')

            
    
# ==============================================
class StartsWithZeroOneTestCase(unittest.TestCase):
    """Tests exercise in intro acting as char fcn of set of strings starting with 01."""

    TM_FILE_NAME = 'startswithzeroone.tm'

    def is_char_function(self,final_config):
        """Test a finished machine acts as a characteristic function, so all 
           cells are blank except the one under the head, and that one has 
           either '0' or '1'
             final_config  dictionary returned by get_final_config
        """
        self.assertTrue(is_empty(final_config['prefix']), "prefix "+final_config['prefix']+" should be empty")
        self.assertTrue(is_empty(final_config['suffix']), "suffix "+final_config['suffix']+" should be empty")
        self.assertTrue(final_config['currentchar'] in ['1','0'], "current character "+final_config['currentchar']+"should be 0 or 1")
        
    def test_simple(self):
        """Test some dumb thing"""
        sigma = "01"+ ("0"*4) 
        r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out) # show the machine's output for debugging
        final_config = get_final_config(out)
        # print("final_config is {0!s}".format(pprint.pformat(final_config)))
        self.is_char_function(final_config)
        self.assertTrue(final_config['currentchar']=='1')

    def test_empty(self):
        """Test the empty string"""
        sigma = " "
        r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        # print("final_config is {0!s}".format(pprint.pformat(final_config)))
        self.is_char_function(final_config)
        self.assertTrue(final_config['currentchar']=='0')
        
    def test_some(self):
        """Test a few cases"""
        # Starts with 1
        for i in range(1,6):
            sigma = "1"+("1"*i) 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='0')
        # Starts with 10
        for i in range(1,6):
            sigma = "10"+("1"*i) 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='0')
        # Starts with 01, mix of chars
        for i in range(1,3):
            sigma = "01"+("01"*i) 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='1')
        # Starts with 10, mix of chars
        for i in range(1,3):
            sigma = "10"+("01"*i) 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='0')
        
    def test_all(self):
        """Test all small cases"""
        # Bitstrings starting with 1
        for i in range(0,2**4):
            sigma = "1"+format(i,"b") 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='0')
        # Starts with 01
        for i in range(0,2**4):
            sigma = "01"+format(i,"b") 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='1')


            
    
# ==============================================
class StartsWithZeroStarOneTestCase(unittest.TestCase):
    """Tests exercise in intro acting as char fcn of set of strings starting 
       with some number of 0's followed by a 1."""

    TM_FILE_NAME = 'startswithzerostarone.tm'

    def is_char_function(self,final_config):
        """Test a finished machine acts as a characteristic function, so all 
           cells are blank except the one under the head, and that one has 
           either '0' or '1'
             final_config  dictionary returned by get_final_config
        """
        self.assertTrue(is_empty(final_config['prefix']), "prefix "+final_config['prefix']+" should be empty")
        self.assertTrue(is_empty(final_config['suffix']), "suffix "+final_config['suffix']+" should be empty")
        self.assertTrue(final_config['currentchar'] in ['1','0'], "current character "+final_config['currentchar']+"should be 0 or 1")
        
    def test_simple(self):
        """Test some dumb thing"""
        sigma = "001"+ ("0"*4) 
        r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out) # show the machine's output for debugging
        final_config = get_final_config(out)
        # print("final_config is {0!s}".format(pprint.pformat(final_config)))
        self.is_char_function(final_config)
        self.assertTrue(final_config['currentchar']=='1')

    def test_empty(self):
        """Test the empty string"""
        sigma = " "
        r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
        out = r.stdout.decode(encoding='UTF-8')
        # print(out)
        final_config = get_final_config(out)
        # print("final_config is {0!s}".format(pprint.pformat(final_config)))
        self.is_char_function(final_config)
        self.assertTrue(final_config['currentchar']=='0')

    def test_no_one(self):
        """Test the a bunch of 0's but no 1"""
        for i in range(1,5):
            sigma = "0"*i
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            # print("final_config is {0!s}".format(pprint.pformat(final_config)))
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='0')
        
    # def test_some(self):
    #     """Test a few cases"""
    #     # Starts with 1
    #     for i in range(1,6):
    #         sigma = "1"+("1"*i) 
    #         r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
    #         out = r.stdout.decode(encoding='UTF-8')
    #         # print(out)
    #         final_config = get_final_config(out)
    #         self.is_char_function(final_config)
    #         self.assertTrue(final_config['currentchar']=='0')
    #     # Starts with 10
    #     for i in range(1,6):
    #         sigma = "10"+("1"*i) 
    #         r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
    #         out = r.stdout.decode(encoding='UTF-8')
    #         # print(out)
    #         final_config = get_final_config(out)
    #         self.is_char_function(final_config)
    #         self.assertTrue(final_config['currentchar']=='0')
    #     # Starts with 01, mix of chars
    #     for i in range(1,3):
    #         sigma = "01"+("01"*i) 
    #         r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
    #         out = r.stdout.decode(encoding='UTF-8')
    #         # print(out)
    #         final_config = get_final_config(out)
    #         self.is_char_function(final_config)
    #         self.assertTrue(final_config['currentchar']=='1')
    #     # Starts with 10, mix of chars
    #     for i in range(1,3):
    #         sigma = "10"+("01"*i) 
    #         r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
    #         out = r.stdout.decode(encoding='UTF-8')
    #         # print(out)
    #         final_config = get_final_config(out)
    #         self.is_char_function(final_config)
    #         self.assertTrue(final_config['currentchar']=='0')
        
    def test_all(self):
        """Test all small cases"""
        # Bitstrings starting with 1
        for i in range(0,2**3):
            sigma = "1"+format(i,"b") 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='1')
        # Starts with 01
        for i in range(0,2**3):
            sigma = "01"+format(i,"b") 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='1')
        # Starts with 001
        for i in range(0,2**3):
            sigma = "01"+format(i,"b") 
            r = run_tm(self.TM_FILE_NAME, sigma[0], sigma[1:])
            out = r.stdout.decode(encoding='UTF-8')
            # print(out)
            final_config = get_final_config(out)
            self.is_char_function(final_config)
            self.assertTrue(final_config['currentchar']=='1')



            
# ===========================================================

# Run only these tests
# how to discover all tests? not this: suite.addTests(DoublerTestCase())
def suite():
    suite = unittest.TestSuite()
    suite.addTest(StartsWithZeroStarOneTestCase('test_simple'))
    suite.addTest(StartsWithZeroStarOneTestCase('test_empty'))
    suite.addTest(StartsWithZeroStarOneTestCase('test_no_one'))
    suite.addTest(StartsWithZeroStarOneTestCase('test_all'))
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
