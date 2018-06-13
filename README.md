# PCRE2-controlled, bulky rename operation, in globaling batch process  

Requirements: Bash, find, sed, mv and pcre2grep which I renamed it to 'gre'. Get it from:

https://github.com/luvit/pcre2/blob/master/src/pcre2grep.c   

Usage  
ren [mv option] SOURCE DEST  
usual/literal rename operation by mv command

ren [mv option] ':SOURCE  :DEST'  
rename PCRE regex pattern SOURCE to become DEST which may backrefer any captured group in SOURCE  
Note the double colon (:) starting the source/destination field and note the enclosure by pair of quotes; ' or " 

mv option if any must be a field/string of single or multi option put sequentially, must not have space
i.e, -bu Backup and Update 

it's good to read the useful comments within codes, such  
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
