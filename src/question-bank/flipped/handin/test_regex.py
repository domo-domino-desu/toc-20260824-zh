#!/usr/bin/env python                                                           
# test_regex.py                                                                 
# CGI scriptto have students test regular expressions                           
# 2015-Feb-05 JH                                                                
# 2022-Mar-28 Allow dash                                                        

import re
import string
import cgi
import cgitb; cgitb.enable()

HEADER = """Content-type: text/html                                             
                                                                                
<html>                                                                          
<head>                                                                          
  <title>Regular expression practice</title>                                    
</head>                                                                         
                                                                                
<body>                                                                          
"""

TRY_MSG = """                                                                   
<h2>Try a regular expression</h2>                                               
<p>                                                                             
  Enter a regular expression to run against the words in                        
  a dictionary.                                                                 
  </p>                                                                          
                                                                                
<form method="post" action="test_regex.py">                                     
  <p>                                                                           
    <input type="text" name="userregex" value="%s"/><input type="submit" value=\
"Submit">                                                                       
   </p>                                                                        
  </form>                                                                       
"""

FOOTER = """                                                                    
</body>                                                                         
</html>                                                                         
"""

ERROR = """                                                                     
<h3>ERROR!</h3>                                                                 
<p>That expression is ill-formed; it is not a regular expression this form can \
take.  Try again.</p>                                                           
"""

ERROR_BAD_CHAR = """                                                            
<h3>ERROR!</h3>                                                                 
<p>That expression contains characters that this routine cannot process, for se\
curity reasons.  Try again.</p>
"""

WORDS = """                                                                     
<h3>Results for the regular expression: %s</h3>                                 
"""

ACCEPTABLE_CHARS = string.letters+string.digits+'().*|{}-[],+?'


# form = cgi.FieldStorage()                                                     
# message = form.getvalue("message", "(no message)")                            

print(HEADER)

form = cgi.FieldStorage()
user_regex = form.getfirst("userregex",None)
if not(user_regex is None):
   for ch in user_regex:
      if not(ch in ACCEPTABLE_CHARS):
         print(ERROR_BAD_CHAR)
         user_regex = None
if (user_regex is None):
   print(TRY_MSG % ("",))
else:
   print(TRY_MSG % (cgi.escape(user_regex),))
if not(user_regex is None):
   try:
      user_re = re.compile(user_regex+"$", re.I)  # ignore case                 
   except:
      print(ERROR)
   else:
      print(WORDS % (cgi.escape(user_regex), ))
      dict = open('/usr/share/dict/american-english','r')
      wordlist = []
      for line in dict.readlines():
         line = line.rstrip()
         if line.endswith("'s"):
            continue
         if user_re.match(line):
            wordlist.append(line)
      print("<h4>There are %d matching words in the dictionary</h4>" % (len(wor\
dlist),))
      if wordlist:
         print("<p>")
         for wd in wordlist:
            print(cgi.escape(wd)+" ")
         print("</p>")
      else:
         print("<p>Give it another try?</p>")

print(FOOTER)
