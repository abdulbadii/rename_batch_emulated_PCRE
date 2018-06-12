# PCRE2-controlled rename operation in bulky / globalizing  

requirements:  
Bash, find, sed, mv and pcre2grep, but I renamed pcre2grep to 'gre', get it from:

https://github.com/luvit/pcre2/blob/master/src/pcre2grep.c   

Usage  
ren SOURCE DEST  
usual/literal rename operation

ren :SOURCE  :DEST  
rename PCRE regex pattern SOURCE to become DEST by backreferring any captured group in SOURCE having no Bash special character

ren ':SOURCE  :DEST'  
rename PCRE regex pattern SOURCE to become DEST by backreferring any captured group in SOURCE having some Bash special character  

E.g. Let  
/c/usr/bin/hello folder containing files:  
world001  
world002  
world003  
wood001  
wood002  
wine01

ren ':(/c/.*?hel.*?w\w+?)\d+(\d) :\1xxx\2'  
it'll be containing files:
worldxxx1  
worldxxx2  
worldxxx3  
woodxxx1  
woodxxx2  
winexxx1

DISCLAIMER:  
Very scarcely tested. It just provide "as is". Does not guarante anything that will lead to impairment and damage.
