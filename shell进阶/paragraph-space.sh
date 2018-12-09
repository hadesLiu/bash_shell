#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2018/12/6 7:33 PM

# 在无空行的文本文件的段落之间插入空行
# 像这样使用：$0 <FILENAME

MINLEN=60  # 可以试试修改这个值。它用来做判断。
# 假设一行的字符数小鱼 $MINLEN，并且以句点结束段落。

echo $2

while read -r line || [[ -n $line ]] # 当文件有很多行的时候
do
    echo "$line"  # 输出行本身
    len="${#line}"
    if [[ "${len}" -lt ${MINLEN} && "${line}" =~ [*{\.!?}]$ ]]
    then
        echo  # 在该行 以句点，问号，感叹号结束时，增加一行空行
    fi
done

exit
