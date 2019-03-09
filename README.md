# GNU-extended regex controlled rename and copy operation globally, in bulk, using Linux Bash script  
Requirements:  
Bash, find, sed, mkdir, head and mv to rename, or cp to copy.  

As Windows port, get MSYS2 on https://sourceforge.net/projects/msys2/files/latest/download?source=directory As Mac port, get on https://www.macports.org or Homebrew https://brew.sh/  
  
Copy the Bash script and paste, prepend it into ~/.bashrc file  
The script here is for renaming. For copying, duplicate whole function 'ren' and change to whatever you like, e.g. 'copy', and use that instead after changing all lines started with "mv ", replace each of "mv " with "cp "  

# Usage  
 -ren -h or --help  
    help explaining all the options, mv options and few additional options  

- ren [mv options..] SOURCE DEST  
   literal rename operation by mv command  

- ren [mv option..] [-N|-c|-f] 'SOURCE  ;;DEST'  

Rename GNU-extended regex pattern SOURCE to become DEST which may backrefer to any captured group in the SOURCE  
Note the doubled semicolon (;;) as the start of destination field, and it's enclosed by pair of '' or ""  

The searching default is ignoring (insensitive to) the letter case. But it has options  

-c        Force the search to be case sensitive   
-f FILE or  
-fFILE    Get SOURCE from a FILE
-N        For testing only, do normally as instructed but will not effect anything, instead only report what is supposed to perform   
   
And may be adjoined with all 'mv' options.

 It'd accept either absolute or relative path argument whose patterns will match.  
 For relative path argument it would be on current directory, if it's meant to be anywhere under current directory, prefix it with keyword: **  
E.g,  
Let /home/hello folder containing files:  
$ cd /home/hello  
world001  
world002  
wood001  
wood002  
wine007  

In absolute path reference:  

ren '(/home/.*?lo/\w+?d)\d+(\d) ;;\1xxx\2'  

So /home/hello will be containing:  
worldxxx1  
worldxxx2   
woodxxx1  
woodxxx2  
wine007  

For its relative path usage:  

ren '(w\w+?d)\d+(\d) ;;\1xxx\2'  
  or  
ren '(**w\w+?d)\d+(\d) ;;\1xxx\2'  

But the latter will also find and rename /home/hello/world/world007 to /home/hello/world/worldxxx7  if such exists  
It always backs up the target DEST if its name exists by renaming it, suffixing with "_old"
