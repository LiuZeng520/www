#!/bin/bash
s=`echo $*|awk -F"-s" '{print $2}'|awk '{print $1}'`
size=${s:=1G}
domain=`echo $*|awk -F"-d" '{print $2}'|awk '{print $1}'`
function muban_xml(){
mkdir /test/ 2> /dev/null
cat>/test/test_disk.xml<<EOF
<disk type='file' device='disk'>
  <driver name='qemu' type='qcow2'/>
  <source file='/kvm/disk/mini-clone.qcow2'/>
  <target dev='sdb' bus='scsi'/>
</disk>
EOF
}
function vars(){
	n=`virsh domblklist $domain|awk '/\.qcow2$/{print $1}'|tail -1|sed -nr 's/(..)(.)(.*)/\2/p'`
	dev_sd=({a..z})
	for i in ${!dev_sd[*]};do
		[ "${dev_sd[$i]}" == "$n" ] && let m=$i+1 && break
	done
	x=${dev_sd[$m]}
}
function add_disk(){
	cd /test/
	qemu-img create -f qcow2 /kvm/disk/$domain-$x.qcow2 $size
	cp /test/test_disk.xml /test/$domain-$x.xml
	sed -ri "/source/s/(.*\/)(.*)(.qcow2.*)/\1$domain-$x\3/" /test/$domain-$x.xml
	sed -ri "/target/s/sd./sd$x/" /test/$domain-$x.xml
	virsh attach-device $domain /test/$domain-$x.xml --persistent
}
function Help(){
	echo "帮助信息："
	echo "  [-s]  size"
	echo "  <-d>  domain"
}
if [ -n "$domain" ];then
	muban_xml && vars && add_disk
else
	Help
fi
