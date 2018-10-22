#!/bin/bash
function clone(){
#qemu-img create -f qcow2 -b /kvm/disk/$qfile /kvm/disk/$dname.qcow2
for i in $qfile;do
    qemu-img create -f qcow2 -b $i $(echo $i|sed -nr "s/$sname/$dname/p") > /dev/null ||exit
done
cp /etc/libvirt/qemu/$xfile /etc/libvirt/qemu/$dname.xml
sed -ri "/$sname/s/$sname/$dname/" /etc/libvirt/qemu/$dname.xml
sed -ri "/uuid/s/(.*)(.{4})(..uuid.)/\1$si\3/" /etc/libvirt/qemu/$dname.xml
sed -ri "/source file/s/$sname/$dname/" /etc/libvirt/qemu/$dname.xml
sed -ri "/mac address/s/(.*\:)(..)(.*)/\1$mi\3/" /etc/libvirt/qemu/$dname.xml
virsh define /etc/libvirt/qemu/$dname.xml
virsh start $dname
}
function uuid(){
n=`echo {0..9} {a..f}`
nums=($n)
for((i=1;i<=$1;i++));do
    random=$[$RANDOM%16]
    echo -n ${nums[$random]}
done
}
function clone_help(){
echo "./clone.sh <options> <domain> ..."
echo "options:"
echo "  -h"
echo "  -s \"src name\""
echo "  -d \"dest name\""
}
sname=`echo $*|awk -F"-s" '{print $2}'|awk '{print $1}'`
dname=`echo $*|awk -F"-d" '{print $2}'|awk '{print $1}'`
si=`uuid 4`
mi=`uuid 2`
qfile=$(virsh domblklist $sname|awk '/qcow2$/{print $2}')
xfile="$sname.xml"
if [ -n "$sname" ]&&[ -n "$dname" ];then
	clone
elif [ "$1" == "-h" ];then
	clone_help
else
	echo "请正确使用！"
	clone_help
fi
