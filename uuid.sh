#!/bin/bash
nums=(0 1 2 3 4 5 6 7 8 9 a b c d e f)
function uuid(){
for((i=1;i<=$1;i++));do
    random=$[$RANDOM%16]
    echo -n ${nums[$random]}
done
}
echo "`uuid 8`-`uuid 4`-`uuid 4`-`uuid 4`-`uuid 12`"
