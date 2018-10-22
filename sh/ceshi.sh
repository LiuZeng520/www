#!/bin/bash
j=`cat /etc/passwd | wc -l`
for ((i=1;i<=j;i++));do
	awk -F: 'NR=='$i'{print $1}' /etc/passwd
done
