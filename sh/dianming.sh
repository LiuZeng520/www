#!/bin/bash
names=(`cat name`)
num=${#names[*]}
index=$[RANDOM%num]
echo ${names[index]}
