#!/bin/bash
# 此脚本目的为：
# 1、找出没有监控"tcp[*]"的主机
# 2、区分第一步找出的主机的agent版本

function if_fun() {
# 区分zabbix_agent的版本
ip="$1"
version=`zabbix_get -s $ip -p 10050 -k agent.version|awk -F"." '{print $1}'`
if [ $version -eq 3 ];then
    echo "$ip" >> /tmp/init.txt
elif [ $version -eq 4 ];then 
    echo "$ip" >> /tmp/service.txt
else
    echo "$ip" >> /tmp/other.txt
fi
}

# 需要预设所有资产ip到/tmp/all.txt
for i in `cat /tmp/all.txt|sed -rn '/^[0-9]+/p'`;do
    # 判断有没有监控该监控项
    str=`zabbix_get -s $i -p 10050 -k tcp[TIME_WAIT]`
    if ! grep -E '^[[:digit:]]+$' <<< "$str" &> /dev/null;then
        if_fun $i
    else
        echo "$i" >> /tmp/complete.txt
    fi
done
