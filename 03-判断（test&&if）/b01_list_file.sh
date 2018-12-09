#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/6 4:51 PM


dirName=/Users/hiro/PycharmProjects/bash_shell
fileName=f3.sh

# 判断目录是否存在
if [[ ! -d ${dirName} ]]
then
    mkdir ${dirName}
    echo "${dirName} is not exist, already created it."
fi

# 判断文件是否存在
if [[ ! -f ${dirName}/${fileName} ]]
then
    touch ${dirName}/${fileName}
    echo "${dirName}/${fileName} is not exist, already created it."
    exit
fi

# 列出文件
echo "ls -l ${dirName}/${fileName}"
ls -l ${dirName}/${fileName}