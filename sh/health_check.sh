#!/bin/bash
ip=$1
port=$2

which jq &> /dev/null || yum install -y jq &> /dev/null

json_html=`curl -s http://${ip}:${port}/health`

if [ "${json_html}" == "" ];then
    json_html=`curl -s http://${ip}:${port}/api/emdm/health`
fi

Stat=`echo $json_html | jq -r .status`

if [ "$Stat" == "UP" ];then
    echo $Stat
else
    # vlue=`echo $Stat | sed -rn '/\$ref/s/(.*:.{3})(.*)(".*)/\2/p'`
    # stat=`echo $json_html | jq -r $vlue.code`
    stat=`echo $json_html | jq -r .details.discoveryComposite.details.discoveryClient.status.code`
    if [ "$stat" == "UP" ];then
        echo $stat
    else
        echo "NOT"
    fi
fi
