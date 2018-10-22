#!/bin/bash
domain=`echo $*|awk -F"--name" '{print $2}'|awk '{print $1}'`
dev=`echo $*|awk -F"--dev" '{print $2}'|awk '{print $1}'`
n=`echo $dev|sed -nr 's/sd//p'`
file_name="$domain-$n"
function del_disk(){
	ansible $domain -m shell -a "umount /dev/${dev}1"
	cd /test/
	virsh detach-device $domain /test/$file_name.xml
	read -p "是否删除源文件？(yes/no)" choise
	[ "$choise" != "yes" ]&&exit
	rm -rf /test/$file_name.xml
	rm -rf /kvm/disk/$file_name.qcow2
}
function Help(){
	echo "帮助信息："
	echo "	use: "
	echo "	$0 <--name> <domain>  <--dev> <dev>"
}
if [ -n "$domain" ]&&[ -n "$dev" ];then
	del_disk
else
	Help
fi
