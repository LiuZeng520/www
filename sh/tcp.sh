#!/bin/bash

HOST=`/sbin/ifconfig eth0 | sed -rn '/inet /s/(.*inet )(.*)( net.*)/\2/p'`
# Functions to return nginx stats
# 检测nginx进程是否存在
function ping {
/sbin/pidof nginx | wc -l
}
function ESTABLISHED {
netstat -tan | grep ESTABLISHED|wc -l
}
function FIN_WAIT1 {
netstat -tan|grep FIN_WAIT1|wc -l
}
function FIN_WAIT2 {
netstat -tan|grep FIN_WAIT2|wc -l
}
function TIME_WAIT {
netstat -tan|grep TIME_WAIT|wc -l
}
function CLOSING {
netstat -tan|grep CLOSING|wc -l
}
function CLOSE_WAIT {
netstat -tan|grep CLOSE_WAIT|wc -l
}
function LAST_ACK {
netstat -tan|grep LAST_ACK|wc -l
}
# Run the requested function
$1
