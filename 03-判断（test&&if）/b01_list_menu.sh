#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/3 8:29 AM

# sh menu.sh
# 1. [install lamp]
# 2. [install lnmp]
# 3. [exit]
# Plz input the num you want:
# 输入1时，输出"installing lamp"，输入2时，输出"installing lnmp"，输入3时，退出脚本

#echo "1. [install lamp]"
#echo "2. [install lnmp]"
#echo "3. [exit]"

E_NOTNUM=85

menu() {
cat << EOF
    1. [install lamp]
    2. [install lnmp]
    3. [exit]
    Plz input the num you want:
EOF
}

menu

read -t 15 num

[ ${num} -ne 1 -o ${num} -ne 2 -o ${num} -ne 3 ] && {
    echo "Plz input the num you want again"
    exit ${E_NOTNUM}
}

[[ num -eq 1 ]] && {
    echo "installing lamp"
    sleep 3
    echo "lamp is installed"
    exit 0
}

[[ num -eq 2 ]] && {
    echo "installing lnmp"
    sleep 3
    echo "lnmp is installed"
    exit 0
}

[[ num -eq 3 ]] && {
    echo "exit"
    exit 0
}

#[ ${num} -ne 1 -o ${num} -ne 2 -o ${num} -ne 3 ] && {
#    echo "Plz input the num you want again"
#    exit ${E_NOTNUM}
#}