#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/2 8:49 PM

var1=5
var2=4

#if [[ ${var1} -gt ${var2} ]]
if (( var1 > var2 ))
then
    echo "${var1} is greater than ${var2}"
else
    echo "${var1} is less than ${var2}"
fi

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