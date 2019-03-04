#! /usr/bin/bash
ren(){
T=;i=;o=;c=-iregex;I=i;
for a
{
case ${a:0:2} in
-t) T=1;;
-c) c=-regex;I=;;
-[A-Sa-suvz]) o="$o $a";;
-*) echo Unrecognized option \'$a\';;
*)
if [[ "$@" =~ ' ;;' ]];then
x=${a%[^ ]*;;*};x=$x${a:${#x}:1}
y=${a#* ;;}
# PCRE --> GNU-ext regex
x=$(echo $x |sed -E 's/(\[.*?)\\\w([^]]*\])/\1a-z0-9\2/g; s/(\[.*?)\\\d([^]]*\])/\10-9\2/g ;s/\\\d/[0-9]/g; s/([^\])\.\*/\1[^\/]*/g; s/\.?\*\*/.*/g')
# below RHS after $ '\n' for Linux, Windows port (Msys/mingw): '\r\n', Mac port: '\r'
v=${x#.\*};v=${v#/}
IFS=$'\r\n'
if [[ "$x" =~ ^\(*/ ]] ;then
	s=$(echo $x |sed -E 's/([^[|*+\\{.]+).*/\1/;s~(.+)/.*~\1~;s/[()]//g')	#the first longest literal
else s=~+;x=$PWD/$x
fi
if [ $T ] ;then
	for F in `find $s -regextype posix-extended $c "$x" |head -n99`
	{	t=`echo $F | sed -E "s|$v|$y|$I"`
		echo -e '\033[0;36m'Would rename '\033[0m'"$F -> $t";}
else
	F==;while([ "$F" ])
	do F=
	for F in `find $s -regextype posix-extended $c "$x" |head -n99`
	{
		t=`echo $F | sed -E "s|$v|$y|$I"`
		mkdir -p "${t%/*}"
		mv -bvS .old $o "$F" "$t"
	}
	done
fi
unset IFS
else
	t=${@: -1}
	mkdir -p "${t%/*}"
	mv -bvS .old $o ${@: -2} $t
fi;;
esac
}
}
