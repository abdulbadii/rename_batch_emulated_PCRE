# PCRE2-controlled rename and copy operation in bulk/globaling process  

Requirements: Bash, find, sed, pcre2grep, and mv or cp, to rename use mv, to copy use cp.  As Windows-port for Linux you'd get MSYS2: https://sourceforge.net/projects/msys2/files/latest/download?source=directory  
As Mac-port for Linux get on Mac App Store: https://redirect.viglink.com/?format=go&jsonp=vglnk_152948260196320&key=f33f208bd7d94bed0a23fe052ea3ba17&libId=jimu85xi0100ohp6000DAbv4hoov2&loc=https%3A%2F%2Fwww.maketecheasier.com%2Finstall-linux-software-on-mac%2F&v=1&out=https%3A%2F%2Fitunes.apple.com%2Fus%2Fapp%2Fxcode%2Fid497799835&ref=https%3A%2F%2Fwww.google.com%2F&title=How%20to%20Install%20Linux%20Software%20on%20a%20Mac%20with%20MacPorts%20-%20Make%20Tech%20Easier&txt=Mac%20App%20Store  
or Apple’s developer website https://redirect.viglink.com/?format=go&jsonp=vglnk_152948262704721&key=f33f208bd7d94bed0a23fe052ea3ba17&libId=jimu85xi0100ohp6000DAbv4hoov2&loc=https%3A%2F%2Fwww.maketecheasier.com%2Finstall-linux-software-on-mac%2F&v=1&out=https%3A%2F%2Fdeveloper.apple.com%2Fdownload%2Fmore%2F&ref=https%3A%2F%2Fwww.google.com%2F&title=How%20to%20Install%20Linux%20Software%20on%20a%20Mac%20with%20MacPorts%20-%20Make%20Tech%20Easier&txt=Apple%E2%80%99s%20developer%20website  

Get pcre2grep from:  
https://github.com/luvit/pcre2/blob/master/src/pcre2grep.c   
compile and install to the OS, and rename it to 'gre' for brevity  

The script here is for renaming process. For copying one, duplicate the function namedly 'ren' and change it to word you like say 'copy', use 'copy' instead of 'ren' shown below. And replace 'mv' in line 22 and 27 with 'cp'   

# Usage  
ren [mv option] SOURCE DEST  
usual/literal rename operation by mv command

ren [mv option] ':SOURCE  :DEST'  
rename PCRE regex pattern SOURCE to become DEST which may backrefer to any captured group in SOURCE  
Note the double colon (:) starting the source/destination field and note the enclosure by pair of either quotes ' or " 

The mv option if any is a spaceless field/string of single or multi option put sequentially
e.g, -bu  Backup with add '_old' suffix if the target name exists  
  -fu such case above but Force to overwrite it only if SOURCE is newer than it i.e. it will Update  
type mv --help  

The searching is insensitive to (ignoring) letter case. It'd accept either absolute or relative path argument which pattern will match. If it's relative that argument will be concatenated directly so it means it's on the current directory only, if it's meant to be anywhere recursively under the current directory prefix it with regex .*?. It's good to read the comments within script.  
E.g,
Let /c/usr/bin/hello folder containing files:  
world001  
world002  
wood001  
wood002  
wine00

ren ':(/c/u.*?hel.*?w\w+?d)\d+(\d) :\1xxx\2'  

it'd be containing files:  
worldxxx1  
worldxxx2   
woodxxx1  
woodxxx2  
wine00  

In relative way:  
cd /c/usr/bin/hello  
ren ':(w\w+?d)\d+(\d) :\1xxx\2'  
  or  
ren ':(.*?w\w+?d)\d+(\d) :\1xxx\2'  

But the latter will also search and rename /c/usr/bin/hello/world/world001 to /c/usr/bin/hello/world/worldxxx1  if such exists   

DISCLAIMER:  
It was sucessfully tested though not exhaustively. It's just provided "as is". Do on your own risk, you'd better back up the data first. No guarantee for perfect accuracy and no warranty for data loss and damage.
