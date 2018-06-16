# PCRE2-controlled rename operation, in bulk/globaling batch process  

Requirements: Bash, find, sed, mv and pcre2grep which I renamed it to 'gre'. Get it from:

https://github.com/luvit/pcre2/blob/master/src/pcre2grep.c   

Usage  
ren [mv option] SOURCE DEST  
usual/literal rename operation by mv command

ren [mv option] ':SOURCE  :DEST'  
rename PCRE regex pattern SOURCE to become DEST which may backrefer to any captured group in SOURCE  
Note the double colon (:) starting the source/destination field and note the enclosure by pair of either quotes ' or " 

The mv option if any is a spaceless field/string of single or multi option put sequentially
e.g, -bu  Backup with add '_old' suffix if the new designated name exists  
  -fu such case above but Force to overwrite it only if SOURCE is newer than that, i.e: Update  
type mv --help  

The searching ignores (is insensitive to) letter case. It'd accept either absolute or relative path argument which pattern will be matched. If it's relative that argument will be concatenated directly so it means it's on the current directory only, if it's meant to be anywhere under the current directory prefix it with regex .*?. 
Read the comments within codes.  

E.g. Let  
/c/usr/bin/hello folder containing files:  
world001  
world002  
wood001  
wood002  
wine00

ren ':(/c/.*?hel.*?w\w+?d)\d+(\d) :\1xxx\2'  
it'll be containing files:  
worldxxx1  
worldxxx2   
woodxxx1  
woodxxx2  
wine00  

In relative way: cd /c/usr/bin/hello  
ren ':(w\w+?d)\d+(\d) :\1xxx\2'  
or  
ren ':(.*?w\w+?d)\d+(\d) :\1xxx\2'  

But the latter will also rename /c/usr/bin/hello/world/world001 to /c/usr/bin/hello/world/worldxxx1  if any such exist    

DISCLAIMER:  
It's been very scarcely tested and just provided "as is". Do on your own risk, you'd better back up the data first. Does not guarantee any success and no warranty for data loss and damage.
