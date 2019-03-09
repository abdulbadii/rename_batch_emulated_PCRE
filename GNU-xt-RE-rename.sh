#! /usr/bin/bash
ren(){
f=;N=;i=;o=;c=-iregex;I=i;
[ ${#@} \< 2 ]&&return
for a
{
[ "$f" = : ]&&{ f=$a;continue;}
case ${a:0:6} in
-F) f=:;;
-F????) f=${a:2};;
-N) N=1;;
-c) c=-regex;I=;;
-[HLPRSTabdfilnpstuvxz]) o="$o $a";;
--help|-h) echo -e For more help go to'\nhttps://github.com/abdulbadii/GNU-ext-regex-rename/blob/master/README.md\n'
	mv --help|sed -Ee 's/\bcp\b/kp/;8a\ \ -c\t\t\t\tCase sensitive search' -e '14a\ \ -N\t\t\t\tNot really execute, but only tell what it will do. It is useful as a test';return;;
-*) echo Ignoring unrecognized option \'$a\';;
*)
[ "$f" -a ! -f "$f" ]&&{
	f=$(echo $f| sed -E 's~\\\\~\\~g ;s~\\~/~g ;s~\b([a-z]):(/|\W)~/\1/~i')
	[ -f $f ]||{ echo file does not exist;return;}
}
if [[ "${@: -1}" =~ ' ;;' ]];then
x=${a%[^ ]*;;*};x=$x${a:${#x}:1}
y=${a#* ;;}
# PCRE --> GNU-ext regex
x=$(echo $x |sed -E 's/(\[.*?)\\\w([^]]*\])/\1a-z0-9\2/g; s/(\[.*?)\\\d([^]]*\])/\10-9\2/g ;s/\\\d/[0-9]/g; s/([^\])\.\*/\1[^\/]*/g; s/\.?\*\*/.*/g')
v=${x#.\*}
if [[ "$x" =~ ^\(*(/|[a-z]:) ]] ;then
	s=$(echo $x |sed -E 's/([^[|*+\\{.]+).*/\1/;s~(.+)/.*~\1~;s/[()]//g')	#the first longest literal
else s=~+;x=$PWD/$x
fi
IFS=$'\n'
if((N==1));then
	if [ "$f" ];then	while read -r e
	do	[ -f $e ] ||{
		F=`echo $e| sed -E 's/"([^"]+)"/\1/;s~\b([a-z]):(/|\W)~/\1/~i;s-\\\\-/-g'`
		[ -f $F ] ||continue;}
		t=`echo $F | sed -E "s|$v|$y|$I"`;echo -e '\033[0;36m'Would rename '\033[0m'"$F -> $t"
	done<$f
	else	for F in `find $s -regextype posix-extended $c "$x" |head -n499`
		{ t=`echo $F | sed -E "s|$v|$y|$I"`;echo -e '\033[0;36m'Would rename '\033[0m'"$F -> $t";}
	fi
else
	if [ "$f" ]	;then	while read -r e
	do	[ -f $e ] ||{
		F=`echo $e| sed -E 's/"([^"]+)"/\1/;s~\b([a-z]):(/|\W)~/\1/~i;s-\\\\-/-g'`
		[ -f $F ] ||continue;}
		t=`echo $F | sed -E "s|$v|$y|$I"`;mkdir -p "${t%/*}";mv -bvS .old $o "$F" "$t"
	done<$f
	else F==
		while([ "$F" ]);do F=
		for F in `find $s -regextype posix-extended $c "$x" |head -n419`
		{
			t=`echo $F | sed -E "s|$v|$y|$I"`
			mkdir -p "${t%/*}"
			mv -bvS .old $o "$F" "$t"
		}
		done
		fi
fi
unset IFS
else
	t=${@: -1};mkdir -p "${t%/*}";mv -bvS .old $o ${@: -2} $t
fi;;
esac
}
}
