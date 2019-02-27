#!/usr/bin/env bash
# @Author  : hiro 
# @Mail    : hiroliu@yeah.net
# @Time    : 2019/2/20 5:30 PM


today=`date +%Y%m%d`  # 定义监控日期变量
addr="http://域名地址/getSettleFlow?date=${today}"  # 定义访问地址
curlres=`curl -s ${addr}`  # 定义curl结果
args1=$1

if [[ $# -ne 1 ]]; then
	echo "Usage: bash $0 flow_status|flow_type"
	exit 1
fi

res=`echo ${curlres} | awk 'BEGIN {RS=","} {print $0}'`

for line in ${res}; do
    echo ${line} | awk -F: '$1~/'"$args1"'/ {print $2}'
done

