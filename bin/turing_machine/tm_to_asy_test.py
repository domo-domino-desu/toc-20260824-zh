#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Create easier urls for latexrefman tree view
"""

import sys, os, os.path
import traceback, pprint
import argparse
import time
import unittest

from tm_to_asy import __version__, __author__, __license__
import tm_to_asy

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
    os.path.basename(__file__)[:-3] + '.log'  # strip off the ".py"
)))
fh.setLevel(logging.ERROR)
fh.setFormatter(formatter)
log.addHandler(fh)

# ==============================================
OUTPUT0 = """step 0: q0: *1*11
step 1: q0: 1*1*1
step 2: q0: 11*1*
step 3: q0: 111*B*
step 4: q1: 11*1*B
step 5: q1: 11*B*B
step 6: q2: 1*1*BB
step 7: q2: *1*1BB
step 8: q2: *B*11BB
step 9: q3: B*1*1BB
step 10: HALT"""

class FirstTestCase(unittest.TestCase):
    """Tests."""
    def setUp(self):
        self.lines=OUTPUT0.splitlines()
        self.line_list = tm_to_asy.parse_lines(self.lines)
    
    
    def test_find_positions(self):
        """Finding the position from the output alone"""
        pprint.pprint(self.line_list)
        new_d_list = tm_to_asy.find_positions(self.line_list)
        pprint.pprint(new_d_list)
        # print("min_char {0!s}, max_char {0!s}".format(min_char, max_char))

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
