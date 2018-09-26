#!/bin/bash
echo "________________________________________"
echo "|   1.输入出生年份,就能得到您的年龄喔   |"
echo "|---------------------------------------|"
echo "|   2.查看根分区的使用情况              |"
echo "|---------------------------------------|"
echo "|   3.查看某个分区的使用情况            |"
echo "|_______________________________________|"
echo -n "请选择您要查看的内容："
read num
if [ $num == 1 ];then
	echo -n "Please enter your year of birth :"
	read birth
	if [ -z "$birth" ];then
    		echo -e "\e[31mInput can not be empty !!!\e[0m"
	elif [[ $birth == *[!0-9]* ]];then
    		echo -e "\e[31mInvalid year !!!\e[0m"
	else
    		age=$[ `date +%Y` - $birth ]
    		echo "Your age is $age"
	fi
elif [ $num == 2 ];then
	space=`df -h | awk -F" +|%" '/\/$/{print$5}'`
	random=$[ 100 - $space ]
	if [ $random -ge 50 ];then
	    echo "根分区的使用正常，剩余空间为$random%"
	elif [ $random -le 30 ]&&[ $random -gt 15 ];then
	    echo "根分区空间不多,剩余空间为$random%,请及时清理"
	elif [ $random -le 15 ];then
	    echo "根分区空间告急,剩余空间为$random%,请立即清理"
	else
	    echo "根分区剩余空间为$random%"
	fi
elif [ $num == 3 ];then
	echo -n "请输入您要查询的分区："
	read part
	if [ -n "${part}" ]&&[ "${part}" != "--help" ];then
	space=`df -h ${part} 2>/dev/null| awk -F" +|%" '/^[/a-zA-Z]/{print$5}'`
	        if [ -n "$space" ];then
	        random=$[ 100 - $space ]
	        fi
	fi
	if [ -z "${part}" ];then
	        cat /root/space_help.txt
	elif [ "${part}" == "--help" ];then
	      cat /root/space_help.txt
	elif [[ $space == *[0-9]* ]];then
	    if [ $random -ge 50 ];then
	        echo "${part}分区的使用正常，剩余空间为$random%"
	    elif [ $random -le 30 ]&&[ $random -gt 15 ];then
	        echo -e "\e[33m${part}分区空间不多,剩余空间为$random%,请及时清理\e[0m"
	    elif [ $random -le 15 ];then
	        echo -e "\e[31m${part}分区空间告急,剩余空间为$random%,请立即清理\e[0m"
	    else
	        echo "${part}分区剩余空间为$random%"
	    fi
	else
	        echo -e "\e[31m参数错误：只能是有效分区!!!\e[0m"
	fi
else
	echo "请输入有效的数字！"
fi
