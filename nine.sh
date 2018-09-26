#!/bin/bash
for i in {1..9};do
	for ((j=1;j<=i;j++));do
		echo -n -e "$j*$i=$[ i * j ]\t"
	done
	echo ""
done
