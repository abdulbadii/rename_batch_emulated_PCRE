#! /usr/bin/bash
ren(){
N=;i=;o=;c=-iregex;I=i;
for a
{
case ${a:0:3} in
-N) N=1;;
-c) c=-regex;I=;;
-[HLPRSTabdfilnpstuvxz]) o="$o $a";;
--h|-h) echo -e For more help go to'\nhttps://github.com/abdulbadii/GNU-ext-regex-rename/edit/master/README.md\n'
	mv --help|sed -Ee 's/\bmv\b/ren/;8a\ \ -c\t\t\t\tCase-sensitive search' -e '14a\ \ -N\t\t\t\tNot really to execute only tell what it will do. Provide as a test';return;;
-*) echo Unrecognized option \'$a\';return;;
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
if [ $N ] ;then
	for F in `find $s -regextype posix-extended $c "$x" |head -n313`
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
	t=${@: -1};mkdir -p "${t%/*}";mv -bvS .old $o ${@: -2} $t
fi;;
esac
}
}
