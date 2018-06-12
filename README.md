# PCRE2-controlled rename operation in bulky / globalizing  

usage  
ren SOURCE DEST  
usual/literal rename operation

ren :SOURCE  :DEST  
rename PCRE regex pattern SOURCE to become DEST by backreferring any captured group in SOURCE having no Bash special character

ren ':SOURCE  :DEST'  
rename PCRE regex pattern SOURCE to become DEST by backreferring any captured group in SOURCE having some Bash special character  

let
/c/usr/bin/hello folder containig files:  
world001  
world002  
world003  
wood001  
wood002  
wine01

ren ':(/c/.*?hel.*?w\w+?)\d+(\d) :\1xxx\2'  
it'll be containig files:
worldxxx1  
worldxxx2  
worldxxx3  
woodxxx1  
woodxxx2  
winexxx1

DISCLAIMER:  
Very scarcely tested. It just provide "as is". Do not guarante anything that can make failures and defections.
