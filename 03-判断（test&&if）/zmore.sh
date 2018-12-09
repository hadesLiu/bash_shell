#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/3 2:16 PM

# 使用筛选器'more'查看 gzipped 文件

# 错误状态码
E_NOARGS=85
E_NOTFOUND=86
E_NOTGZIP=87

# 判断参数个数是否正确
if [[ $# -eq 0 ]]
then
    echo "Usage: `basename $0` filename" >& 2
    exit ${E_NOARGS}
fi

filename=$1

# 判断文件是否存在
if [[ ! -f "${filename}" ]]
then
    echo "File ${filename} not found." >& 2
    exit ${E_NOTFOUND}
fi

# 判断文件为.gz 文件
# ${string%substring}	从变量$string结尾开始删除最短匹配$substring子串
if [[ ${filename##*.} != "gz" ]]
then
    echo "File $1 is not a gzipped file!"
    exit ${E_NOTGZIP}
fi

zcat $1 | less

