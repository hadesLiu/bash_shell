#!/usr/bin/env bash
# @Author  : hiro 
# @Mail    : hiroliu@yeah.net
# @Time    : 2019/2/20 5:30 PM


export IFS=","   # 更改换行符
today=`date +%Y%m%d`  # 定义监控日期变量
addr="http://域名地址/getSettleFlow?date=${today}"  # 定义访问地址
curlres=`curl -s ${addr}`  # 定义curl结果
var=$1  # 传入参数

if [[ $# -ne 1 ]]; then
	echo "Usage: bash $0 flow_status|flow_type"
	exit 1
fi

for word in ${curlres}; do
	echo ${word}
	if echo "${word}"|grep ${var} > /dev/null ; then
		echo "$word" | awk -F: '{print $2}'
    fi
done