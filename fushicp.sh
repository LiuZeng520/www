#!/bin/bash
x=0;y=0
function RED(){
    while [ $y -le $[$a-1] ] &>/dev/null;do
    no=0
    red_ran=$[RANDOM%33+1]
        for j in "${red[@]}";do
             [ $j -eq $red_ran ]&&no=1&&break
        done
        [ $no -eq 0 ] && red[$y]=$red_ran&& let y++
    done
echo -ne "\e[31m${red[*]}\e[0m"
red=()
y=0
}
function BLUE(){
      while [ $x -le $[$b-1] ] &>/dev/null;do
    no=0
    blue_ran=$[RANDOM%16+1]
        for j in "${blue[@]}";do
             [ $j -eq $blue_ran ]&&no=1&&break
        done
        [ $no -eq 0 ] && blue[$x]=$blue_ran&& let x++
    done
echo -ne " + \e[34m${blue[*]}\e[0m"
echo
blue=()
x=0
}
function Cn6(){
s1=1;s2=1;a=$[$1-$2+1]
for ((n=$a;n<=$1;n++));do
        let s1=s1*n;done
for ((m=1;m<=$2;m++));do
        let s2=s2*m;done
s1=$[$s1 / $s2]
}
if [ "$1" == "-h" ]||[ "$1" == "--help" ];then
	echo -e " [-b] 加数字确定蓝球数量\n [-r] 加数字确定红球数量\n [-h]|[--help] 帮助信息"
elif [ "$1" == "-r" ]||[ "$1" == "-b" ];then
	case $1,$3 in
		"-r","-b")
		a=$2;b=$4
		RED $1 $2 $3 $4;BLUE $1 $2 $3 $4
		i=$2;j=$4
		Cn6 $i 6
		echo -e "\e[1;3;35m一共 $[$s1 * $j * 2] 元\e[0m"
		;;
		"-b","-r")
		a=$4;b=$2
		RED $1 $2 $3 $4;BLUE $1 $2 $3 $4
		j=$2;i=$4
		Cn6 $i 6
		echo -e "\e[1;3;35m一共 $[$s1 * $j *2] 元\e[0m"
		;;
		*)
		echo "请输入有效参数[-b -r   -h|--help]"
		;;
	esac
else
	echo "请输入有效参数[-brh --help]"
fi
