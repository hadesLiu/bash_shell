#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/2 8:49 PM

a=$1
b=$2

if [[ ${a} -lt ${b} ]]
then
    echo "${a} is less than ${b}"
elif [[ ${a} -gt ${b} ]]
then
    echo "${a} is greater than ${b}"
else
    echo "${a} is equal to ${b}"
fi

#stringZ=abcABC123ABCabc
#
#echo ${stringZ%b*c}
#echo ${stringZ%%b*c}

#echo ${stringZ#a*C}
#echo ${stringZ##a*C}

#echo ${stringZ:0}
#echo ${stringZ:1}
#echo ${stringZ:7}
#
#echo ${stringZ:7:3}
#echo ${stringZ:(-4)} # 括号或者增加空格都可以"转义"位置参数
#echo ${stringZ: -4}

#echo `expr index "$stringZ" C12`

#echo `expr match "$stringZ" 'abc[A-Z]*.2'`
#echo `expr "$stringZ" : 'abc[A-Z]*.2'`
#echo ${#stringZ}
#echo `expr length $stringZ`
#echo `expr "$stringZ" : '.*'`
#
#echo ${#stringZ}
#echo `expr length $stringZ`
#echo `expr "$stringZ" : '.*'`

#n=1; let --n && echo "True" || echo "False"
#n=1; let n++ && echo "True" || echo "False"
#
#echo

#echo  "1.5 + 1.3" | bc

# 使变量自增1，10种不同的方法实现

#n=1; echo -n "${n} "
#
##let "n = $n + 1"
#let "n = n + 1"
#echo -n "${n} "
#
#: $(( n = $n + 1 ))
#echo -n "${n} "
#
#(( n = n + 1 ))
#echo -n "${n} "
#
#n=$(($n + 1))
#echo -n "${n} "
#
#: $[ n = $n + 1 ]
#echo -n "${n} "
#
#n=$[ $n + 1 ]
#echo -n "${n} "
#
#let "n++"
#echo -n "${n} "
#
#(( n++ ))
#echo -n "${n} "
#
#: $(( n++ ))
#echo -n "${n} "
#
#: $[ n++ ]
#echo -n "${n} "
#
#echo

#dirName=/Users/hiro/PycharmProjects/bash_shell
#fileName=f3.sh
#
## 判断目录是否存在
#if [[ ! -d ${dirName} ]]
#then
#    mkdir ${dirName}
#    echo "${dirName} is not exist, already created it."
#fi
#
## 判断文件是否存在
#if [[ ! -f ${dirName}/${fileName} ]]
#then
#    touch ${dirName}/${fileName}
#    echo "${dirName}/${fileName} is not exist, already created it."
#    exit
#fi
#
## 列出文件
#echo "ls -l ${dirName}/${fileName}"
#ls -l ${dirName}/${fileName}

#read -p "Plz input two number: " a b
#
#if [[ ${a} -lt ${b} ]]
#then
#    echo "${a} is less than ${b}"
#    exit
#fi
#
#if [[ ${a} -eq ${b} ]]
#then
#    echo "${a} and ${b} is equal"
#    exit
#fi
#
#if [[ ${a} -gt ${b} ]]
#then
#    echo "${a} is greater than ${b}"
#    exit
#fi

#if [[ "${string1}" = "${string2}" ]]
#then
#    echo "equal"
#fi

#a=3

#if [[ "${a}" -gt 0 ]]
#then
#    if [[ "${a}" -lt 5 ]]
#    then
#        echo "The value of \"a\" lies somewhere between 0 and 5."
#    fi
#fi

#if [[ "${a}" -gt 0 ]] && [[ "${a}" -lt 5 ]]
#then
#    echo "The value of \"a\" lies somewhere between 0 and 5."
#fi

#[ 1 -eq 1 ] && [ -n "`echo true 1>&2`" ]  # 真
#[ 1 -eq 2 ] && [ -n "`echo true 1>&2`" ]  # 没有输出
#
#[ 1 -eq 2 -a -n "`echo true 1>&2`" ]  # 真
#
#[[ 1 -eq 2 && -n "`echo true 1>&2`" ]]  # 没有输出


#expr1=1 -eq 0
#expr2=1 -eq 1
#
#if [ "${expr1}" -a "${expr2}" ]
#then
#    echo "Both expr1 and expr2 are true."
#else
#    echo "Either expr1 or expr2 is false."
#fi


#if [[ -n "${string1}" ]]
#then
#    echo "String \"string1\" is not null."
#else
#    echo "String \"string1\" is null."
#fi

#a=4
#b=5
#
#echo
#
#if [[ ${a} -ne ${b} ]]
#then
#    echo "${a} is not equal to ${b}."
#    echo "(arithmetic comparision)"
#fi
#
#if [[ ${a} != ${b} ]]
#then
#    echo "${a} is not equal to ${b}."
#    echo "(string comparision)"
#fi
#
#echo

#var1=5
#var2=4
#
#if [ ${var1} = ${var2} ]
#then
#    echo "等于"
#else
#    echo "不等于"
#fi

#if [[ ${var1} -gt ${var2} ]]
#if (( var1 > var2 ))
#then
#    echo "${var1} is greater than ${var2}"
#else
#    echo "${var1} is less than ${var2}"
#fi

#read -p "Plz input two number: " a b
#echo ${a} ${b}

# 判断 输入是否为空
#[[ -z ${a} ]] || [[ -z ${b} ]] && {
#    echo "Plz input two number again. "
#    exit 1
#}

#test -z ${a} || test -z ${b} && {
#    echo "Plz input two number again. "
#    exit 1
#}

#expr ${a} + 0 &> /dev/null
#RETVAL1=$?
#expr ${b} + 0 &> /dev/null
#RETVAL2=$?

#[[ ${RETVAL1} -ne 0 ]] || [[ ${RETVAL2} -ne 0 ]] && {
#    echo "Plz input two int numbers again."
#	exit 2
#}

#[ ${RETVAL1} -ne 0 -o ${RETVAL2} -ne 0 ] && {
#    echo "Plz input two int numbers again."
#	exit 2
#}

#test ${RETVAL1} -ne 0 -o ${RETVAL2} -ne 0  && {
#    echo "Plz input two int numbers again."
#	exit 2
#}

#[[ ${RETVAL1} -eq 0 ]] && [[ ${RETVAL2} -eq 0 ]] || {
#    echo "Plz input two int numbers again."
#	exit 2
#}

#[ ${RETVAL1} -eq 0 -a ${RETVAL2} -eq 0 ] || {
#    echo "Plz input two int numbers again."
#	exit 2
#}

#test ${RETVAL1} -eq 0 -a ${RETVAL2} -eq 0 || {
#    echo "Plz input two int numbers again."
#	exit 2
#}