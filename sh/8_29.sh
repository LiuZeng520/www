#!/bin/bash
function ti1(){
rm -rf /haowan &>/dev/null
mkdir /haowan
for i in {1..10};do
	b=({a..z})
	name=
	for j in {1..10};do
		a=$[$RANDOM%26]
		name=$name${b[a]}
	done
	touch /haowan/$name.html
done
}
function ti2(){
cd /haowan
for i in `ls`;do
	name=`ls $i |sed -nr "s/(.*)(\.html)/\1/p"`
	mv ${name}.html ${name}.HTML &> /dev/null
done
}
function ti3(){
for i in `cat zone.list`;do
	if ! grep $i master.conf &> /dev/null;then
		#echo -e "zone \"$i.com\" IN {\n\ttype master;\n\tfile \"$i.com.zone\";\n};" >> master.conf
		cat temp.conf | sed -r "/google/s/(.*)(google[0-9]+)(.*)/\1$i\3/" >> master.conf
	fi
done
}
if [ $1 -eq 1 ] &> /dev/null;then
	ti1
elif [ $1 -eq 2 ] &> /dev/null;then
	ti2
elif [ $1 -eq 3 ] &> /dev/null;then
	ti3
else
	echo "参数错误，再见......"
fi
