#!/usr/bin/python2.7
# -*- coding: UTF-8 -*-
import json
import requests
import sys
# 微信公众号上应用的CropID和Secret
corpid = 'ww54757ee4b3281421'
corpsecret = 'PYvdsedggyuMsIBQT5MlyzSZkAKRo684auu1yroj0vo'
def getToken(corpid,corpsecret):
# 获取access_token
GURL = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%s&corpsecret=%s" % (corpid, corpsecret)
# 使用requests.get 函数请求，并把结果转化为json形式，获取token
token = requests.get(GURL).json()['access_token']
return token
def sendMsg(title,message):
# 获取access_token
access_token = getToken(corpid,corpsecret)
# 消息发送接口
Purl = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s" % access_token
# 要发送的消息
weixin_msg = {
"toparty": '3', # 部门ID
"agentid": '1000002', # 企业应用的id
"msgtype" : "textcard",
"textcard": {
"title": title,
"description": message,
"url": "www.wzlinux.com",
"btntxt": "更多"
}
}
# 向消息接口发送消息
print(requests.post(Purl,data = json.dumps(weixin_msg),headers={'Content-Type': 'application/json;charset=utf-8'}).content)
if __name__ == '__main__':
# 向脚本传参title和message
title = sys.argv[1]
message = sys.argv[2]
sendMsg(title,message)