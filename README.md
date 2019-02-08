# GNU-extended regex controlled rename and copy operation globally, in bulk, using Linux Bash script  
Requirements:  
Bash, find, sed, mkdir, head and mv or cp, use mv to rename, use cp to copy.  
As Windows port, get MSYS2 on https://sourceforge.net/projects/msys2/files/latest/download?source=directory As Mac port, get on https://www.macports.org or Homebrew https://brew.sh/  
  
Copy the Bash script and paste, preappend it into ~/.bashrc file  
The script here is for renaming. For copying, duplicate function 'ren' script and change to whatever you like e.g. 'copy', use that instead after changing any line started with command "mv " replace it with "cp "  

# Usage  
ren [mv option] SOURCE DEST  
literal rename operation by mv command  


ren [mv option] 'SOURCE  ;;DEST'  
or  
copy [cp option] 'SOURCE  ;;DEST'   
if it's duplicated and changed function name to 'copy':  
 
rename GNU-extended regex pattern SOURCE to become DEST which may backrefer to any captured group in the SOURCE  
Note the doubled semicolon (;;) as the start of destination field and the enclosure by quote pair either ' ' or " "  

The searching default is ignoring (insensitive to) the letter case. But it has options  

-c    Force the search to be case sensitive   
-t    Do for testing only, do normally as instructed but will not effect anything, instead only report what is supposed to occur   
   
And are adjoined with all 'mv' options except -t option as it is replaced by -t explained above, type mv --help for more explanation  

 It'd accept either absolute or relative path argument whose patterns will match. As for relative path argument, it'll be concatenated directly thus it must be on current directory, if it's meant to be recursively anywhere under current directory, prefix it with keyword: **  
E.g,  
Let /home/hello folder containing files:  
$ cd /home/hello  
world001  
world002  
wood001  
wood002  
wine007  

In absolute path reference:  

ren ':(/home/.*?lo/\w+?d)\d+(\d) :\1xxx\2'  

So /home/hello will be containing:  
worldxxx1  
worldxxx2   
woodxxx1  
woodxxx2  
wine007  

For its relative path usage:  

ren ':(w\w+?d)\d+(\d) :\1xxx\2'  
  or  
ren ':(**w\w+?d)\d+(\d) :\1xxx\2'  

But the latter will also search and rename /home/hello/world/world007 to /home/hello/world/worldxxx7  if such exists  
It will always backup the target DEST by renaming, suffixing it with '_old', if the same name exists   

DISCLAIMER:  
It is just provided "as is". It has been sucessfully tested though not exhaustively.   
Do on your own risk, you'd better back up your data first. No guarantee for perfect accuracy and no warranty for data loss and damage.
