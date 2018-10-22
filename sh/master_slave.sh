#!/bin/bash

function lqsym(){
yum install mariadb-server -y && \
echo -e "[mysqld]\nlog-bin=binlog\nserver=$i" > /etc/my.cnf && \
systemctl start mariadb && \
mysql -e "grant replication slave on *.* to 'lz'@'%' identified by ''"
}

function evals(){
mysql -e "stop slave" &>/dev/null
a=`tail -2 /tmp/ms.txt | head -1` 
b=`tail -1 /tmp/ms.txt` 
mysql -e "CHANGE MASTER TO MASTER_HOST='master',MASTER_USER='lz',MASTER_PASSWORD='',MASTER_PORT=3306,MASTER_LOG_FILE='$a',MASTER_LOG_POS=$b,MASTER_CONNECT_RETRY=10;" 
mysql -e "start slave" 
a1=`mysql -e "show slave status\G" 2>/dev/null | sed -nr '/Slave_IO_Running/s/(.*)(: )(.*)/\3/p'`
a2=`mysql -e "show slave status\G" 2>/dev/null | sed -nr '/Slave_SQL_Running/s/(.*)(: )(.*)/\3/p'`
if [ "$a1" == "Yes" ]&&[ "$a2" == "Yes" ];then
	echo "从库配置成功"
else
	echo "从库配置失败"
fi
}

function retsam(){
mysql -e "show master status\G" | sed -nr '2s/(.*)(: )(.*)/\3/p' >> /tmp/ms.txt
mysql -e "show master status\G" | sed -nr '3s/(.*)(: )(.*)/\3/p' >> /tmp/ms.txt
scp /tmp/ms.txt slave:/tmp/
[ -f /tmp/ms.txt ]&&echo "主库配置成功"||echo "主库配置失败"
}

hsname=`hostname | awk -F. '{print $1}'`
case $hsname in
        master)
        i=1
		lqsym
		retsam
        ;;
        slave)
        i=2
        lqsym
		evals
        ;;
        *)
        echo "哦豁"
        ;;
esac
