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

cat << EOF
    1. [install lamp]
    2. [install lnmp]
    3. [exit]
EOF

read -p "Plz input the num you want: " num

[[ num -eq 1 ]] && {
    echo "installing lamp"
    exit 0
}

[[ num -eq 2 ]] && {
    echo "installing lnmp"
    exit 0
}

[[ num -eq 3 ]] && {
    echo "exiting"
    exit 0
}