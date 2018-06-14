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
# The RHS below after '$' char if Linux: \n, if ported on Windows (Msys2): \r\n if ported on Mac:  \r
IFS=$'\n'
if [[ ${a##'('} =~ ^/ ]]
then
	# s is the first longest literal
	s=`echo $x |sed -r 's/([^[|*+\\{.]+).*/\1/ ;s/[()]//g'`
	for l in `f ${s%/*} -noleaf -regextype posix-extended -iregex "$x" | gre -ie "${a/'/'/'\/'}"`
	{
	mv $o -vS _old $l `echo $l | sed -r "s~$x~$b~i"`
	}
else
	for l in `f ~+ -noleaf -regextype posix-extended -iregex "$PWD/${x}" | gre -ie "$a"`
	{
	mv $o -vS _old $l `echo $l | sed -r "s~$x~$b~i"`
	}
fi
elif test $s ;then mv -vS _old $o $*
fi;}

