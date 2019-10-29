#!/bin/bash
function storage_unit_conversion() {
    kib=$1
    n=0
    while [ $kib -ge 1024 ];do
        kib=`echo "$kib"/1024 | bc`
        let n=$n+1
    done
    if [ $n -eq 0 ];then
        unit="K"
    elif [ $n -eq 1 ];then
        unit="M"
    elif [ $n -eq 2 ];then
        unit="G"
    elif [ $n -eq 3 ];then
        unit="T"
    elif [ $n -eq 4 ];then
        unit="P"
    else
        unit=""
    fi
    echo "$kib$unit"
}
function vmstat_cmd() {
    option=$1
    num=`vmstat|tail -2|head -1|awk '{print NF}'`
    declare -A vmstat
    cmd_sesult_head=`vmstat|tail -2|head -1`
    cmd_sesult_tail=`vmstat 1 2|tail -1`
    for ((i=1;i<=$num;i++));do
        index=`echo $cmd_sesult_head|awk '{print $'$i'}'`
        value=`echo $cmd_sesult_tail|awk '{print $'$i'}'`
        if [ $index == "swpd" ]||[ $index == "free" ]||\
           [ $index == "buff" ]||[ $index == "cache" ];then
            kib=$value
            mib=`echo ${kib}/1024|bc`
            value=$mib
            #value=`storage_unit_conversion $kib`
        fi
        vmstat[${index}]=$value
    done
    if [ $option == "useage" ];then
        vmstat[useage]=`echo "100-${vmstat[id]}"|bc`
    fi
    echo ${vmstat[$option]}
    #for i in ${!vmstat[@]};do
    #    echo $i : ${vmstat[$i]}
    #done
}


function df_cmd() {
    i=`echo $1|awk -F"-" '{print $1}'`
    if [ $i == "vda1" ];then
        i=`df -h|awk -F" +|/" '/^\/dev/{print $3}'|head -1`
    elif [ $i == "vdb1" ];then
        i=`df -h|awk -F" +|/" '/^\/dev/{print $3}'|head -2|tail -1`
    fi
    option=`echo $1|awk -F"-" '{print $2}'`
    info=`df -h |awk -F" +|%" '/\/dev\/'$i'/{print $2,$3,$5,$7}'`
    case $option in 
        "max")
        echo $info|awk '{print $1}'|sed -rn 's/[A-Z]+//p'
        ;;
        "use")
        echo $info|awk '{print $2}'|sed -rn 's/[A-Z]+//p'
        ;;
        "useage")
        echo $info|awk '{print $3}'
        ;;
        "partition")
        echo $info|awk '{print $4}'
        ;;
        *)
        exit
        ;;
    esac
    #    echo "$partition 分区的容量为 $max ,以使用 $use ,已使用 $useage%"
}



function free_cmd() {
    option=$1
    case $option in
        "total")
        free -m|awk '/^Mem/{print $2}'
        ;;
        "used")
        free -m|awk '/^Mem/{print $3}'
        ;;
        "free")
        free -m|awk '/^Mem/{print $4}'
        ;;
        "shared")
        free -m|awk '/^Mem/{print $5}'
        ;;
        "buff")
        vmstat_cmd buff
        ;;
        "cache")
        vmstat_cmd cache
        ;;
        "available")
        free -m|awk '/^Mem/{print $7}'
        ;;
        *)
        exit
        ;;
    esac
}


if [ -z $1 ]||[ -z $2 ];then
    echo "请输入要查询的参数"
    exit
fi

case $1 in
    "vm")
    vmstat_cmd $2
    ;;
    "df")
    df_cmd $2
    ;;
    "free")
    free_cmd $2
    ;;
    *)
    exit
    ;;
esac
