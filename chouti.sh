#!/bin/bash
TI(){
dir="/var/ftp/homework"
file_num=$(ls $dir|wc -l)
file_list=($(ls $dir))
index=$[RANDOM%file_num]
file=${file_list[index]}
line_num=$(cat $dir/$file|wc -l)
line_index=$[RANDOM%line_num+1]
sed -n "${line_index}p" $dir/$file
}
[ "$#" -eq 0 ] && echo " Usage:`basename $0` <number>" && exit
ti=()
i=1
while [ $i -le $1 ];do
	ti_tmp=$(TI)
	ti_len=`echo $ti_tmp|tr -s " "|tr -s "\t" |wc -c`
	[ $ti_len -ne 1 ] && ti[$i]="$ti_tmp" && let i++
done
for i in $(seq $1);do
	echo ${ti[$i]}
done
