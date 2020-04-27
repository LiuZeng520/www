#!/bin/bash
corpid=$1
corpsecret=$2
agentid=$3
toparty=$4
msg=$5
title=$6
url=$7
if [ $# != 7 ];then
    echo "用法：$0 <corpid> <corpsecret> <agentid> <toparty> <msg> <title> <url>"
    exit
fi

gurl="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$corpid&corpsecret=$corpsecret"
json_get=`curl -s -X GET $gurl`
token=`echo $json_get|jq -r .access_token`

purl="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=$token"
json_post="{\"toparty\": $toparty, \"agentid\": $agentid, \"msgtype\" : \"textcard\", \"textcard\": {\"title\": \"$title\", \"description\": \"$msg\", \"url\": \"$url\", \"btntxt\": \"更多\"}}"
#echo $json_post
#exit

curl -s -o /dev/null -X POST "$purl" -H "Content-Type: application/json;charset=utf-8" -d "$json_post"
