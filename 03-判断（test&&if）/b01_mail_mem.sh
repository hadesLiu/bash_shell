#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/7 8:47 AM

# 开发脚本判断系统剩余内存大小，如果低于100M就报警

# 1. 获取当前剩余内存  free -m |grep Mem |awk '{print $7}'
free_Mem=`free -m |awk 'NR==2 {print $7}'`

# 2. 判断内存大小，并发送邮件

if [[ ${free_Mem} -lt 100 ]]
then
    echo "Memory is not enough, free memory is ${free_Mem}"
    echo "Memory is not enough, free memory is ${free_Mem}" | mail -s "mem warning $(data +%F)" 813981811@qq.com
fi