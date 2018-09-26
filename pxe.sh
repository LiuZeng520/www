#!/bin/bash
function NETWORK(){
ip=`ip a | grep inet |awk '/brd/{print $2}'|sed -rn 's/(.*)(\/)(.*)/\1/p'|sed -r '/\.1$/d'`
prefix=`ip a | grep inet |awk '/brd/{print $2}'|sed -r '/\.1\/[0-9]+$/d'|sed -rn 's/(.*)(\/)(.*)/\3/p'`
if [ $prefix -eq 24 ];then
	network_segment=`echo $ip | awk -F. '{print $1"."$2"."$3"."0}'`
	netmask="255.255.255.0"
elif [ $prefix -eq 16 ];then
	network_segment=`echo $ip | awk -F. '{print $1"."$2"."0"."0}'`
	netmask="255.255.0.0"
elif [ $prefix -eq 8 ];then
	network_segment=`echo $ip | awk -F. '{print $1"."0"."0"."0}'`
	netmask="255.0.0.0"
else
	echo "未识别的IP"
fi
network_segment_id=`echo $network_segment | sed -nr 's/(.*)(\.0)(.*)/\1/p'`
}

function CHECK_NETWORK(){
NETWORK
echo -e "ip\tprefix\tnetwork_segment\tnetmask\tnetwork_segment_id"
echo -e "$ip\t$prefix\t$network_segment\t$netmask\t$network_segment_id"
}

function DHCP(){
yum install -y dhcp &> /dev/null &&\
echo -e "subnet $network_segment netmask $netmask {" > /etc/dhcp/dhcpd.conf
	if [ $prefix -eq 24 ];then
		echo -e "range $network_segment_id.101 $network_segment_id.200;" >> /etc/dhcp/dhcpd.conf
	else
		echo "未支持的网段..."
		exit 100
	fi
echo -e "next-server $ip;" >> /etc/dhcp/dhcpd.conf
echo -e "filename \"pxelinux.0\";" >> /etc/dhcp/dhcpd.conf
echo -e "}" >> /etc/dhcp/dhcpd.conf
systemctl start dhcpd
netstat -uanp |grep dhcpd &> /dev/null || exit 101
}

function TFTP(){
yum install tftp-server -y &> /dev/bull &&\
sed -ri '/disable/s/yes/no/' /etc/xinetd.d/tftp
systemctl start tftp || exit 102
yum install syslinux -y &> /dev/null &&\
cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
[ -d /mnt/cdrom ] || mkdir /mnt/cdrom
mount /dev/sr0 /mnt/cdrom
cp /mnt/cdrom/isolinux/initrd.img /var/lib/tftpboot/
cp /mnt/cdrom/isolinux/vmlinuz /var/lib/tftpboot/
[ -d /var/lib/tftpboot/pxelinux.cfg ] || mkdir /var/lib/tftpboot/pxelinux.cfg
[ -f /var/lib/tftpboot/pxelinux.cfg/default ] && rm -rf /var/lib/tftpboot/pxelinux.cfg/default
cp /mnt/cdrom/isolinux/isolinux.cfg  /var/lib/tftpboot/pxelinux.cfg/default
sed -ri '1s/(.*default\ )(.*)/\1linux/' /var/lib/tftpboot/pxelinux.cfg/default
sed -ri "64s/(.*append\ initrd=initrd\.img\ )(.*)/\1ks\=http\:\/\/$ip\/ks\/ks\.cfg/" /var/lib/tftpboot/pxelinux.cfg/default
}

function HTTP(){
yum install httpd -y &> /dev/null &&\
[ -d /var/www/html/iso ] || mkdir /var/www/html/iso
[ -d /var/www/html/ks ] || mkdir /var/www/html/ks
mount /dev/sr0  /var/www/html/iso/
systemctl start httpd || exit 103
}

function FILE_KS(){
echo "install">/var/www/html/ks/ks.cfg
echo "keyboard 'us'">>/var/www/html/ks/ks.cfg
echo 'rootpw --iscrypted $1$dD2Sri.N$y.xYOjaVCV5uwLk7h.UpX.'>>/var/www/html/ks/ks.cfg
echo -e "url --url=\"http://$ip/iso\"">>/var/www/html/ks/ks.cfg
echo "lang zh_CN">>/var/www/html/ks/ks.cfg
echo "firewall --disabled">>/var/www/html/ks/ks.cfg
echo "auth  --useshadow  --passalgo=sha512">>/var/www/html/ks/ks.cfg
echo "graphical">>/var/www/html/ks/ks.cfg
echo "firstboot --disable">>/var/www/html/ks/ks.cfg
echo "selinux --disabled">>/var/www/html/ks/ks.cfg
echo "">>/var/www/html/ks/ks.cfg
echo "network  --bootproto=dhcp --device=ens33">>/var/www/html/ks/ks.cfg
echo "reboot">>/var/www/html/ks/ks.cfg
echo "timezone Asia/Shanghai">>/var/www/html/ks/ks.cfg
echo "bootloader --location=mbr">>/var/www/html/ks/ks.cfg
echo "zerombr">>/var/www/html/ks/ks.cfg
echo "clearpart --all --initlabel">>/var/www/html/ks/ks.cfg
echo "part /boot --fstype="xfs" --size=200">>/var/www/html/ks/ks.cfg
echo "part swap --fstype="swap" --size=1000">>/var/www/html/ks/ks.cfg
echo "part / --fstype="xfs" --grow --size=1">>/var/www/html/ks/ks.cfg
echo >>/var/www/html/ks/ks.cfg
echo "%packages">>/var/www/html/ks/ks.cfg
echo "@base">>/var/www/html/ks/ks.cfg
echo "">>/var/www/html/ks/ks.cfg
echo "%end">>/var/www/html/ks/ks.cfg
}

NETWORK && DHCP && TFTP && HTTP && FILE_KS && echo -e "\n完成！！！"
