#! /usr/bin/bash
ren(){
[[ "$1" =~ -h|--help ]]&&{ echo -e For more help go to https://github.com/abdulbadii/GNU-ext-regex-rename/blob/master/README.md
	mv --help|sed -Ee 's/\bmv\b/ren/;8a\ \ -c\t\t\t\tCase sensitive search' -e '14a\ \ -N\t\t\t\tNot to really execute only tell what it will do. It is useful as a test' ;}
(($#<2))&&return
N=;i=;o=;c=-iregex;I=i;
if [[ "${@: -1}" =~ ' ;;' ]];then
for a
{
case ${a:0:6} in
-f????) f=${a:2};f=${f#=};;
-N) N=1;;
-c) c=-regex;I=;;
-[HLPRSTabdfilnpstuvxz]) o=$o$a\ ;;
-*) echo Unrecognized option \'$a\';return;;
*)
if [ ! -f $f ];then
	f=$(echo $f| sed -E 's~\\\\~\\~g ;s~\\~/~g ;s~\b([a-z]):(/|\W)~/\1/~i')
	[ -f $f ]||{ echo file does not exist;return;}
fi
y=${a#* ;;}
x=${a%[^ ]*;;*};x=$x${a:${#x}:1}
# PCRE --> GNU-ext regex
x=$(echo $x |sed -E 's/(\[.*?)\\\w([^]]*\])/\1a-z0-9\2/g; s/(\[.*?)\\\d([^]]*\])/\10-9\2/g ;s/\\\d/[0-9]/g; s/([^\])\.\*/\1[^\/]*/g; s/\.?\*\*/.*/g')
v=${x#.\*}
if [[ "$x" =~ ^\(*(/|[a-z]:) ]] ;then
	s=$(echo $x |sed -E 's/([^[|*+\\{.]+).*/\1/;s~(.+)/.*~\1~;s/[()]//g')	#the first longest literal
else s=~+;x=$PWD/$x
fi
IFS=$'\n';LC_ALL=C
if((N==1));then
	if [ "$f" ];then	while read -r F
	do	[ -e $F ] ||{ F=$(echo $F|sed -E 's/[^!#-~]*([!#-~]+)[^!#-~]*/\1/;s~(\\+|//+)~/~g;s~\b([a-z]):(/|\W)~/\1/~i')
			[ -e $F ] ||continue;}
		t=`echo $F | sed -E "s|$v|$y|$I"`
		[ $F = $t ]||{
		echo -ne '\033[0;36m'Would\ 
		if [ ${F%/*} = ${t%/*} ];then	echo Rename
		elif [ ${F##*/} = ${t##*/} ];then	echo Move
		else	echo Move then rename
		fi
		echo -e '\033[0m'"$F -> $t\n"
		}
	done<$f
	else	for F in `find $s -regextype posix-extended $c "$x" |head -n499`
	{	t=`echo $F | sed -E "s|$v|$y|$I"`
		[ $F = $t ]||{
		echo -ne '\033[0;36m'Would\ 
		if [ ${F%/*} = ${t%/*} ];then	echo Rename
		elif [ ${F##*/} = ${t##*/} ];then	echo Move
		else	echo Move then rename
		fi
		echo -e '\033[0m'"$F -> $t\n"
		}
	}
	fi
else
	if [ "$f" ];then	while read -r F
	do	[ -e $F ] ||{ F=$(echo $F|sed -E 's/[^!#-~]*([!#-~]+)[^!#-~]*/\1/;s~(\\+|//+)~/~g;s~\b([a-z]):(/|\W)~/\1/~i')
			[ -e $F ] ||continue;}
		t=`echo $F | sed -E "s|$v|$y|$I"`
		[ $F = $t ]||{
		mkdir -p "${t%/*}";mv -bS .old $o "$F" "$t"
		if [ ${F%/*} = ${t%/*} ];then	echo Renaming $F -\> $t
		elif [ ${F##*/} = ${t##*/} ];then	echo Moving $F -\> $t
		else	echo Moving and renaming $F -\> $t
		fi;}
	done<$f
	else F==
		while([ "$F" ])
		do F=
		for F in `find $s -regextype posix-extended $c "$x" |head -n499`
		{
		t=`echo $F | sed -E "s|$v|$y|$I"`
		[ $F = $t ]||{
		mkdir -p "${t%/*}";mv -bS .old $o "$F" "$t"
		if [ ${F%/*} = ${t%/*} ];then	echo Renaming $F -\> $t
		elif [ ${F##*/} = ${t##*/} ];then	echo Moving $F -\> $t
		else	echo Moving and renaming $F -\> $t
		fi;}
		}
		done
	fi
fi
unset IFS;;esac
}
else	t=xv${@: -1};mkdir -p "${t%/*}";mv -bvS .old $o ${@: -2} $t
fi
}
