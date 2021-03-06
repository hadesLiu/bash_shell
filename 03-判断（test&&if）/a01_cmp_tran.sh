#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/2 11:38 PM

#综合例：
#开发shell脚本，分别实现以定义变量，脚本传参以及read读入的方式比较两个整数的大小。
#   用条件表达式(禁用if)进行判断，并以屏幕输出的方式提醒用户比较结果。
#注意：一共是开发3个脚本。当用脚本传参以及read读入的方式需要对变量是否为数字进行判断。

a=$1
b=$2

# 判断 输入参数的个数
[[ $# -eq 2 ]] || {
    echo "Usage: $0 Num1 Num2"
    exit 1
}

# 判断 输入是否为整数
expr ${a} + 0 &> /dev/null
RETVAL1=$?
expr ${b} + 0 &> /dev/null
RETVAL2=$?
#test ${RETVAL1} -eq 0 -a ${RETVAL2} -eq 0 || {
#    echo "Plz input two int number. "
#    exit 2
#}
test ${RETVAL1} -ne 0 -o ${RETVAL2} -ne 0 && {
    echo "Plz input two int number. "
    exit 2
}

# 比较大小
[[ ${a} -lt ${b} ]] && {
    echo "${a} < ${b}"
    exit 0
}

[[ ${a} -eq ${b} ]] && {
    echo "${a} = ${b}"
    exit 0
}

[[ ${a} -gt ${b} ]] && {
    echo "${a} > ${b}"
    exit 0
}

#if [[ ${a} -lt ${b} ]]
#then
#    echo "${a} is less than ${b}"
#elif [[ ${a} -gt ${b} ]]
#then
#    echo "${a} is greater than ${b}"
#else
#    echo "${a} is equal to ${b}"
#fi