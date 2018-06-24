# PCRE2-controlled rename and copy operation in bulk and global using Linux Bash script  
Requirements:  
Bash, find, sed, pcre2grep, and mv or cp, to rename use mv, to copy use cp.  
As Windows port, get MSYS2 on https://sourceforge.net/projects/msys2/files/latest/download?source=directory  
As Mac port, get on https://www.macports.org or Apple’s developer website or Mac App Store: https://itunes.apple.com/id/app/xcode/id497799835?mt=12&ign-mpt=uo%3D4 or Homebrew https://brew.sh/  

To get pcre2grep try type: sudo apt-get pcre2grep
Windows port, on Msys2 terminal, type: pacman -S mingw-w64-x86_64-pcre2  
or get from many sources else such as: https://github.com/luvit/pcre2/blob/master/src/pcre2grep.c compile and install  
In any case rename it to 'gre' for brevity  

The script here is for renaming. For a copying one, duplicate the function namedly 'ren' and change it you like, say 'copy', then use that instead of 'ren' shown below. In line 22 and 27, replace 'mv'with 'cp'  

# Usage  
ren [mv option] SOURCE DEST  
usual/literal rename operation by mv command

ren [mv option] ':SOURCE  :DEST'  

rename PCRE regex pattern SOURCE to become DEST which may backrefer to any captured group in SOURCE  
Note the double colon (:) starting the source and destination field and note the enclosure by quotes pair of ' or " 

The mv option if any is a spaceless field/string of single or multi option put sequentially e.g:  
-b Backup if the target DEST name exists, by adding '_old' suffix  
-fu if the DEST name exists, force to overwrite it only if SOURCE is newer than it so it will be Updating  
type mv --help, for clear explanaition  

The searching is ignoring (insensitive to) letter case. It'd accept either absolute or relative path argument whose patterns will match. If it's relative that argument will be concatenated directly so it means it's on the current directory only, if it's meant to be anywhere recursively under the current directory prefix it with regex .*?. It's good to read the comments within script.  
E.g,
Let /c/usr/bin/hello folder containing files:  
world001  
world002  
wood001  
wood002  
wine007  

In absolute way:  

ren ':(/c/u.*?llo/w\w+?d)\d+(\d) :\1xxx\2'  

So it'd be containing:  
worldxxx1  
worldxxx2   
woodxxx1  
woodxxx2  
wine007  

In relative way:  

cd /c/usr/bin/hello  
ren ':(w\w+?d)\d+(\d) :\1xxx\2'  
  or  
ren ':(.*?w\w+?d)\d+(\d) :\1xxx\2'  

But the latter will also search and rename /c/usr/bin/hello/world/world007 to /c/usr/bin/hello/world/worldxxx7  if such exists   

DISCLAIMER:  
It's been sucessfully tested though not exhaustively and just provided "as is". Do on your own risk, you'd better back up your data first. No guarantee for perfect accuracy and no warranty for data loss and damage.
