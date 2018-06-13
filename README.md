# PCRE2-controlled, bulky rename operation, in globaling batch process  

Requirements: Bash, find, sed, mv and pcre2grep which I renamed it to 'gre'. Get it from:

https://github.com/luvit/pcre2/blob/master/src/pcre2grep.c   

Usage  
ren SOURCE DEST  
usual/literal rename operation by mv command

ren :SOURCE  :DEST  

rename PCRE regex pattern SOURCE to become DEST by backreferring any captured group in SOURCE having no Bash special character
Note the double colon ':' starting either field of the source/destination  

ren ':SOURCE  :DEST'  
rename PCRE regex pattern SOURCE to become DEST by backreferring any captured group in SOURCE having some Bash special character  

be sure to read useful comments within codes, such  
  The RHS of Bash value below on Linux-port Windows (Msys2), use \r\n while Linux-port on Mac use \r, instead of \n

E.g. Let  
/c/usr/bin/hello folder containing files:  
world001  
world002  
world003  
wood001  
wood002  
wine00

ren ':(/c/.*?hel.*?w\w+?d)\d+(\d) :\1xxx\2'  
it'll be containing files:
worldxxx1  
worldxxx2  
worldxxx3  
woodxxx1  
woodxxx2  
wine00

DISCLAIMER:  
It's been very scarcely tested and just provided "as is". Do on your own risk, you'd better back up the data first. Does not guarantee any success and no warranty for data loss and damage.
