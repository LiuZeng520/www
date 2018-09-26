#!/bin/bash
for i in `cat "$1"`;do
	flag=0
	for j in `cat "$2"`;do
		[ "$i" == "$j" ] && flag=1 && continue
	done
	[ $flag -eq 0 ] && echo -n "$i,"
done #| sed "s/.$//"
#echo
