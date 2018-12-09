#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/3 3:59 PM
# @Comment : greatest common divisor

#gcd.sh: 最大公约数
#使用欧几里得算法
#两个整数的最大公约数（gcd）
#是两数能同时整除的最大数
#欧几里得算法使用辗转相除法
#In each pass,
	#	dividend <---	divisor
	#	divisor  <---	remainder
#until remainder = 0.
#The gcd = dividend, on the final pass.
#关于欧几里得算法更详细的讨论，可以查看:
#Jim Loy's site, http://www.jimloy.com/number/euclids.htm.
#wiki: https://zh.wikipedia.org/wiki/%E8%BC%BE%E8%BD%89%E7%9B%B8%E9%99%A4%E6%B3%95

ARGS=2
E_BADARGS=85
E_NOTINT=86

# 判断 传入参数的个数是否为正确
if [ $# -ne "${ARGS}" ]
then
    echo "Usage: `basename $0` first-number second-number"
    exit ${E_BADARGS}
fi

# 判断 传入参数为整数
expr $1 + 0 &> /dev/null
RETVAL1=$?
expr $2 + 0 &> /dev/null
RETVAL2=$?

test ${RETVAL1} -eq 0 -a ${RETVAL2} -eq 0 || {
    echo "Plz input int number."
    exit ${E_NOTINT}
}

# 最大公约数的函数
gcd(){

    dividend=$1
    divisor=$2

    remainder=1

    until [ "${remainder}" -eq 0 ]
    do
        let "remainder = ${dividend} % ${divisor}"
        dividend=${divisor}
        divisor=${remainder}
    done
}

gcd $1 $2

echo; echo "GCD of $1 and $2 = ${dividend}"; echo





