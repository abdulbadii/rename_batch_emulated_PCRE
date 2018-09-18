ren() {
s="$@";o=
[[ $1 =~ ^- ]]	&&(o=$1;s=${@:2})
if [[ $s =~ ^: ]]
then
s=${s:1}
[[ $s =~ ' :' ]] ||{ echo Put in the other ':' marker for regex replacement area;return; }
a=${s% :*};a=${a%% }
b=${s#* :}
# converting PCRE to GNU-extended regex
x=`echo $a |sed -r 's/(\[.*?)\\\w([^]]*\])/\1a-z0-9\2/g; s/(\[.*?)\\\d([^]]*\])/\10-9\2/g ;s/\\\d/[0-9]/g'`
echo GNU-ext regex:  $x
# RHS below after $, for Linux: \n, Mac port: \r, Windows port (Msys2):  
#	\r\n and insert "find -noleaf" option at line 21,29 thus: find <the dir> -noleaf -regextype....(so on)  
IFS=$'\n'
if [[ ${a##'('} =~ ^/ ]]
then
	# s is the first longest literal
	s=`echo $x |sed -r 's/([^[|*+\\{.]+).*/\1/ ;s/[()]//g'`
	for l in `find ${s%/*} -regextype posix-extended -iregex "$x" | gre -ie "${a/'/'/'\/'}"`
	{
	t=`echo $l | sed -r "s:$x:$b:i"`
	p="${t%/*}"
	if test ! -e "$p"	;then mkdir -p "$p" ;fi
	mv -vS .old $o "$l" "$t"
	}
else
	for l in `find ~+ -regextype posix-extended -iregex "$PWD/${x}" | gre -ie "$a"`
	{
	t=`echo $l | sed -r "s:$x:$b:i"`
	p="${t%/*}"
	if test ! -e "$p"	;then mkdir -p "$p" ;fi
	mv -vS .old $o "$l" "$t"
	}
fi
elif  test "$s" ;then
	i=;for f in $s
	{ ((i++));test $i = 2 &&p=$f }
	p=${p%/*}
	test -e $p ||mkdir -p $p
	mv -vS .old $o $*
fi;
}
