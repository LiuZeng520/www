#!/usr/bin/python2.7
# -*- coding: UTF-8 -*-
import json
import requests
import sys
# ΢�Ź��ں���Ӧ�õ�CropID��Secret
corpid = 'ww54757ee4b3281421'
corpsecret = 'PYvdsedggyuMsIBQT5MlyzSZkAKRo684auu1yroj0vo'
def getToken(corpid,corpsecret):
# ��ȡaccess_token
GURL = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%s&corpsecret=%s" % (corpid, corpsecret)
# ʹ��requests.get �������󣬲��ѽ��ת��Ϊjson��ʽ����ȡtoken
token = requests.get(GURL).json()['access_token']
return token
def sendMsg(title,message):
# ��ȡaccess_token
access_token = getToken(corpid,corpsecret)
# ��Ϣ���ͽӿ�
Purl = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s" % access_token
# Ҫ���͵���Ϣ
weixin_msg = {
"toparty": '3', # ����ID
"agentid": '1000002', # ��ҵӦ�õ�id
"msgtype" : "textcard",
"textcard": {
"title": title,
"description": message,
"url": "www.wzlinux.com",
"btntxt": "����"
}
}
# ����Ϣ�ӿڷ�����Ϣ
print(requests.post(Purl,data = json.dumps(weixin_msg),headers={'Content-Type': 'application/json;charset=utf-8'}).content)
if __name__ == '__main__':
# ��ű�����title��message
title = sys.argv[1]
message = sys.argv[2]
sendMsg(title,message)