ren(){
o=
if [[ $@ =~ ' ;;' ]]
then
s=$@
[[ $1 =~ ^-[^\;]+ ]]	&&{ o=$1;s=${@:2}; }
[[ $s =~ ' ;;' ]] ||{ echo Make the ';;' marker for regex replacement;return; }
a=${s%[^ ]*;;*};a=$a${s:${#a}:1}
b=${s#* ;;}
# PCRE --> GNU-ext regex
x=`echo $a |sed -E 's/(\[.*?)\\\w([^]]*\])/\1a-z0-9\2/g; s/(\[.*?)\\\d([^]]*\])/\10-9\2/g ;s/\\\d/[0-9]/g; s/([^\])\.\*/\1[^\/]*/; s/\*\*/.*/'`
r=${x%%[!.*]*}
[[ "$r" =~ \.\* ]]&&{ x=${x:${#r}};r='.*'; }
# below RHS after $ '\n' for Linux, Windows port (Msys/mingw): '\r\n', Mac port: '\r'
IFS=$'\r\n'
l==;while([ "$l" ])
do l=
	if [[ "$x" =~ ^\(*/ ]] ;then
		s=`echo $x |sed -E 's/([^[|*+\\{.]+).*/\1/ ;s/[()]//g'`	# s is the first longest literal
		for l in `find ${s%/*} -regextype posix-extended -iregex "$x" |head -n99`
		{
			t=`echo $l | sed -E "s|$x|$b|i"`
			mkdir -p "${t%/*}"
			mv -bvS .old $o "$l" "$t"
		}
	else
		for l in `find ~+ -type f -regextype posix-extended -iregex "$PWD/$r$x" |head -n99`
		{
		t=`echo $l | sed -E "s|$x|$b|i"`
		mkdir -p "${t%/*}"
		mv -bvS .old $o "$l" "$t"
		};fi
done
unset IFS
elif test "$s" ;then
	s=$1;t=$2;	[[ $1 =~ ^- ]]&&{ o=$1;s=$2;t=$3; }
	mkdir -p "${t%/*}"
	mv -bvS .old $o $s $t
fi
}
