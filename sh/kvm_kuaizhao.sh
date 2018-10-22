#!/bin/bash
domain=`echo $*|awk -F"-n" '{print $2}'|awk '{print $1}'`
sname=`echo $*|awk -F"-s" '{print $2}'|awk '{print $1}'`
option=`echo $*|awk -F"-o" '{print $2}'|awk '{print $1}'`
function create(){
	virsh snapshot-create-as $domain $domain-`date "+%Y-%m-%d-%X"`.snap
}
function list(){
	virsh snapshot-list $domain
}
function revert(){
	virsh destroy $domain
	virsh snapshot-revert $domain $sname && echo "已恢复到$sname"&&echo -e "\n"
	virsh start $domain
}
function delete(){
	virsh destroy $domain
	virsh snapshot-delete $domain $sname
	virsh start $domain
}
function Help(){
	echo "帮助信息："
	echo "	Usage: $0 <-o> option <-n> domain [-s] \"snapshot name\""
	echo "	-n  domain"
	echo "	-s  snapshot name"
	echo "	-o  options:"
	echo "		create  \"create snapshot\""
	echo "		list  \"list snapshot\""
	echo "		revert  \"revert snapshot\""
	echo "		delete \"delete snapshot\""
}
function kuaizhao(){
	case $option in
		create)
		create
		;;
		list)
		list
		;;
		revert)
		revert
		;;
		delete)
		delete
		;;
		*)
		Help
		;;
	esac
}
if [ -n $domain ]&&[ -n $option ];then
	kuaizhao
else
	Help
fi
