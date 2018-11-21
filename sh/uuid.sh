#!/bin/bash
nums=({0..9} {a..f})
function uuid(){
for((i=1;i<=$1;i++));do
    random=$[$RANDOM%16]
    echo -n ${nums[$random]}
done
}
echo "`uuid 8`-`uuid 4`-`uuid 4`-`uuid 4`-`uuid 12`"
