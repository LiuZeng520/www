#!/bin/bash
if [ -n "${1}" ]&&[ "${1}" != "--help" ];then
space=`df -h ${1} 2>/dev/null| awk -F" +|%" '/^[/a-zA-Z]/{print$5}'`
	if [ -n "$space" ];then
	random=$[ 100 - $space ]
	fi
fi
if [ -z "${1}" ];then
	cat /root/space_help.txt
elif [ "${1}" == "--help" ];then
      cat /root/space_help.txt
elif [[ $space == *[0-9]* ]];then
    if [ $random -ge 50 ];then
        echo "${1}分区的使用正常，剩余空间为$random%"
    elif [ $random -le 30 ]&[ $random -gt 15 ];then
        echo -e "\e[33m${1}分区空间不多,剩余空间为$random%,请及时清理\e[0m"
    elif [ $random -le 15 ];then
        echo -e "\e[31m${1}分区空间告急,剩余空间为$random%,请立即清理\e[0m"
    else
        echo "${1}分区剩余空间为$random%"
    fi
else
        echo -e "\e[31m参数错误：只能是有效分区!!!\e[0m"
fi
