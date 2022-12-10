#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Run unit tests
"""

import sys, os, os.path
import traceback, pprint
import argparse
import time
import unittest

import uuid   # make unique file names

PGM_ROOTNAME = os.path.splitext(os.path.basename(sys.argv[0]))[0]
PGM_UNDER_TEST_ROOTNAME = PGM_ROOTNAME[:-1*len('_test')]
PGM_SRC_DIR = os.path.dirname(__file__)

if not(PGM_UNDER_TEST_ROOTNAME == 'prepare_files_for_latexml'):
    critical("The name of this file and the name of the tested file don't fit")
    
from prepare_files_for_latexml import __version__, __author__, __license__
import prepare_files_for_latexml as prepare

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

def critical(s, level=1):
    t = 'CRITICAL ERROR: '+s+"\n"
    log.critical(t,exc_info=True)
    sys.exit(level)

# Steal protect's warning, error, and critical functions for easier checking
WARNING_STRING = ""
def grab_warning(s):
    global WARNING_STRING
    WARNING_STRING = s
prepare.warning = grab_warning

ERROR_STRING = ""
def grab_error(s, level=10):
    global ERROR_STRING 
    ERROR_STRING = s
prepare.error = grab_error

CRITICAL_STRING = ""
def grab_critical(s, level=1):
    global CRITICAL_STRING 
    CRITICAL_STRING = s
prepare.critical = grab_critical

    
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


# ============== LaTeXML files =======================

class TestNamingLatexmlFiles(unittest.TestCase):
    """Test the naming of files intended for latexml processing"""
    
    def test_get_latexml_filename(self):
        """Check that it returns the right file name"""
        latexml_string = prepare.LATEXML # should be "latexml"
        # Test various paths without a file extension
        self.assertEqual(latexml_string+'fn',
                         prepare.get_latexml_filename('fn'))
        self.assertEqual('/full/path/'+latexml_string+'fn',
                         prepare.get_latexml_filename('/full/path/fn'))
        self.assertEqual('relative/path/'+latexml_string+'fn',
                         prepare.get_latexml_filename('relative/path/fn'))
        # Test with a file extension
        self.assertEqual(latexml_string+'fn.py',
                         prepare.get_latexml_filename('fn.py'))
        self.assertEqual('/full/path/'+latexml_string+'fn.py',
                         prepare.get_latexml_filename('/full/path/fn.py'))
        self.assertEqual('relative/path/'+latexml_string+'fn.py',
                         prepare.get_latexml_filename('relative/path/fn.py'))


class TestReadingWritingLatexmlFiles(unittest.TestCase):
    """Test writing to and reading from files intended for latexml processing"""
    test_string = "abcdef abcdef"

    def setUp(self):
        """Open a file with stuff in it"""
        # Don't bother with tmp file as it is harder to find for debugging
        self.fn = uuid.uuid4().hex+".tex"  # Extremely likely to be unique name
        self.latexml_fn = prepare.get_latexml_filename(self.fn)
        try:
            self.f = open(self.latexml_fn,'w')
            self.f.write(self.test_string)
            self.f.close()
        except e:
            critical("unable to open test latexml file "+self.latexml_fn+": "+str(e))

    def tearDown(self):
        try:
            os.remove(self.latexml_fn)
        except e:
            critical("unable to remove latexml file "+self.latexml_fn+" because: "+str(e))
            
    def test_read_from_latexml_file(self):
        """Read with the modified file name"""
        res = prepare.read_from_latexml_file(self.fn)
        self.assertEqual(res[0],self.test_string)
            
    def test_write_to_latexml_file(self):
        """Write to the modified file name"""
        tmp_fn = uuid.uuid4().hex+".tex"  # Extremely likely to be unique name
        s = "xyz xyz"
        prepare.write_to_latexml_file(tmp_fn,s)
        res = prepare.read_from_latexml_file(tmp_fn)
        self.assertEqual(res[0],s)
        os.remove(prepare.get_latexml_filename(tmp_fn))



# ============== \includeonly =======================


class TestFnameListBuild(unittest.TestCase):
    """Test building list of chapters from the command line arg"""

    def test_simple(self):
        self.assertEqual(["prologue"],
            prepare._fname_list_build("prologue"))

    def test_list(self):
        self.assertEqual(["prologue","background"],
            prepare._fname_list_build("prologue,background"))
        self.assertEqual(["prologue","background"],
                         prepare._fname_list_build("prologue, background"),
                         "Expected to strip space before 'background'")
        self.assertEqual(["prologue","background"],
                         prepare._fname_list_build("Prologue, Background"),
                         "Expected chapter names to convert to lower case")
        self.assertEqual(["prologue"],
                         prepare._fname_list_build("prologue, backgroudn"),
                         "Expected misspelled second chapter to not be included")
        self.assertEqual("No such chapter: backgroudn",
                         WARNING_STRING)
        


class TestIncludeonlyBuild(unittest.TestCase):
    """Test building list of chapters to include from chapter list"""

    def test_simple(self):
        arg = "prologue"
        fname_list = prepare._fname_list_build(arg)
        self.assertIn("prologue/prologue,",
            prepare._includeonly_build(fname_list))
        print("RUNNUING!!!")

    def test_list(self):
        arg = "prologue, background"
        fname_list = prepare._fname_list_build(arg)
        includeonly_list = prepare._includeonly_build(fname_list)
        self.assertIn("prologue/prologue,",
                      includeonly_list)
        self.assertIn("background/background,",
                      includeonly_list)

    def test_list_commented(self):
        arg = "prologue, background"
        fname_list = prepare._fname_list_build(arg)
        includeonly_list = prepare._includeonly_build(fname_list)
        self.assertIn("% automata/automata,",
                      includeonly_list)

    def test_list_end(self):
        """Look for final list item to not have a comma"""
        arg = "prologue, appendix"
        fname_list = prepare._fname_list_build(arg)
        includeonly_list = prepare._includeonly_build(fname_list)
        self.assertIn("appendix/appendix",
                      includeonly_list)

        
# ===========================================================
def suite():
    suite = unittest.TestSuite()
    suite.addTest(TestFnameListBuild('test_simple'))
    # unittest.defaultTestLoader.loadTestsFromTestCase(TestFnameListBuild)
    # unittest.defaultTestLoader.loadTestsFromTestCase(TestIncludeonlyBuild)
    suite.addTests(unittest.defaultTestLoader.loadTestsFromTestCase(TestFnameListBuild))
    suite.addTests(unittest.defaultTestLoader.loadTestsFromTestCase(TestIncludeonlyBuild))
    return suite

def main(args):
    # Have Python run them all
    # unittest.main()
    # Have Python only run the ones I want.
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
