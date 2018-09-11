#! /usr/bin/bash
ren() {
s=$*;o=
[[ $1 =~ ^- ]]	&&(o=$1;s=$2)
if [[ $s =~ ^: ]]
then
s=${s:1}
[[ $s =~ ' :' ]] ||{ echo Put in the other ':' as marker for regex replacement pattern;return; }
a=${s% :*};a=${a%% }
b=${s#* :}
# converting PCRE to GNU-extended regex
x=`echo $a |sed -r 's/(\[.*?)\\\w([^]]*\])/\1a-z0-9\2/g; s/(\[.*?)\\\d([^]]*\])/\10-9\2/g ;s/\\\d/[0-9]/g'`
echo GNU-ext regex:  $x
# The RHS below after '$' char if Linux: \n, if Windows port (Msys2): \r\n if Mac port: \r  
IFS=$'\n'
if [[ ${a##'('} =~ ^/ ]]
then
	# s is the first longest literal
	s=`echo $x |sed -r 's/([^[|*+\\{.]+).*/\1/ ;s/[()]//g'`
	for l in `find ${s%/*} -regextype posix-extended -iregex "$x" | gre -ie "${a/'/'/'\/'}"`
	{
	if test ! -e $l mkdir $l
	mv -vS _old $o $l `echo $l | sed -r "s:$x:$b:i"`
	}
else
	for l in `find ~+ -regextype posix-extended -iregex "$PWD/${x}" | gre -ie "$a"`
	{
	if test ! -e $l mkdir $l
	mv -vS _old $o $l `echo $l | sed -r "s:$x:$b:i"`
	}
fi
elif test $s ;then mv -vS _old $o $*
fi;}

