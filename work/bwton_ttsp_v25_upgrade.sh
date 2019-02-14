#!/usr/bin/env bash
# @Author  : hiro,
# @Mail    : hiroliu@yeah.net
# @Time    : 2019/1/16 2:06 PM
# @Decription : start|stop|restart|deploy|rollback app


APPDIR=$2  # 应用所在目录 /opt/app
APPNAME=$3  # 应用名称 ttsp-admin-dubbo-22991
TARSOURCE=$4  # 应用压缩包存放目录 /opt/package
TARSUFFIX=$5  # 应用压缩包后缀 .tar
LOGDIR=$6  # 应用日志目录 /opt/logs
BAKDIR=$7   # 应用备份目录 /opt/backup
SERVER_PORT=$8  # 应用启动端口 22991
BINDIR=${APPDIR}/${APPNAME}/bin  # 应用执行脚本目录
#CONF_DIR=${APPDIR}/${APPNAME}/conf  # 应用配置文件目录
DEPLOY_DIR=${APPDIR}/${APPNAME}  # 应用文件所在目录
PARAMNUM=$#  # 脚本传入参数个数
SCRIPTNAME=$0  # 脚本名称


# usage function
function usage() {
    [[ ${PARAMNUM} -ne 8 ]] && {
        echo "usage: $0 start|stop|restart|publish|rollback APPDIR APPNAME TARSOURCE TARSUFFIX LOGDIR BAKDIR SERVER_PORT"
        exit 1
    }
}


# start function
function start() {

    PIDS=`ps -ef | grep java | grep "${DEPLOY_DIR}" |awk '{print $2}'`

    # 判断应用是否已经启动
    if [[ -n "$PIDS" ]]; then
        echo "ERROR: The ${APPNAME} already started!"
        echo "PID: $PIDS"
        return 1
    fi

    # 判断应用端口是否被占用
    SERVER_PORT_COUNT=`netstat -tln | grep ${SERVER_PORT} | wc -l`
    if [[ ${SERVER_PORT_COUNT} -gt 0 ]]; then
        echo "ERROR: The ${APPNAME} port ${SERVER_PORT} already used!"
        return 2
    fi

    # 执行启动脚本
    echo -e "Starting the ${APPNAME} ...\c"
    source /etc/profile && cd ${BINDIR} && bash ${BINDIR}/start.sh

    # 判断应用是否启动成功
    COUNT=0
    while [[ ${COUNT} -lt 1 ]]; do
        echo -e ".\c"  # 等同于 echo -n "."
        sleep 1
        if [[ -n "${SERVER_PORT}" ]]; then
            COUNT=`netstat -ant | grep ${SERVER_PORT} | wc -l`
        else
            COUNT=`ps -f | grep java | grep "${DEPLOY_DIR}" | awk '{print $2}' | wc -l`
        fi
        if [[ ${COUNT} -gt 0 ]]; then
            break
        fi
    done

    # 输出启动成功信息
    echo "OK!"
    PIDS=`ps -f | grep java | grep "${DEPLOY_DIR}" | awk '{print $2}'`
    echo "Start ${APPNAME} Success, PID: $PIDS"

}


# stop function
function stop() {

    PIDS=`ps -ef | grep java | grep "${DEPLOY_DIR}" |awk '{print $2}'`

    # 判断应用是否已经停止
    if [[ -z "$PIDS" ]]; then
        echo "ERROR: The ${APPNAME} does not started!"
        return 4
    fi

    # 停止应用进程
    echo -e "Stopping the ${APPNAME} ...\c"
    for PID in ${PIDS} ; do
        kill ${PID} > /dev/null 2>&1
    done

    # 判断应用是否停止成功，等待时间15s
    COUNT=0
    while [[ ${COUNT} -lt 15 ]]; do
        echo -e ".\c"
        sleep 1
        COUNT=$[${COUNT}+1]
    done

    # 停止进程超过15s，直接kill -9
    PIDS_EXIST=`ps -ef | grep java | grep "${DEPLOY_DIR}" |awk '{print $2}'`
    echo ${PIDS_EXIST}
    if [[ -n "${PIDS_EXIST}" ]]; then
        for PID in ${PIDS_EXIST} ; do
            kill -9 ${PID} > /dev/null 2>&1
        done
    fi

    # 输出停止成功信息
    echo "OK!"
    echo "Stop ${APPNAME} Success, PID: $PIDS"

}


# backup function
function backup() {

    # 判断应用目录是否存在
    cd ${APPDIR}
    if [[ ! -d ${APPNAME} ]]; then
        echo "ERROR: ${DEPLOY_DIR} is not existed."
        return 5
    fi

    # 判断是否是 tomcat 应用
    if echo "${APPNAME}" | grep tomcat ; then
        mv ${APPNAME}/webapps ${BAKDIR}/${APPNAME}_webapps_`date +%F_%T`
    else
        mv ${APPNAME} ${BAKDIR}/${APPNAME}_`date +%F_%T`
    fi

    # 判断是否备份成功
    if [[ $? -eq 0 ]]; then
        echo "Backup ${APPNAME} success!"
    else
        echo "Backup ${APPNAME} failed!"
        exit 6
    fi
}


# deploy function
function deploy() {

    # 解压需要更新的应用包到应用目录
    cd ${APPDIR}
    tar xf ${TARSOURCE}/${APPNAME}${TARSUFFIX} -C ${APPDIR}

    # 判断是否是 tomcat 应用，修改启动脚本start.sh
    if echo "${APPNAME}" | grep tomcat ; then
        sed -i 's#sh ./startup.sh#nohup sh ./startup.sh \&#g' ${DEPLOY_DIR}/bin/start.sh
    fi

    # 判断应用日志文件夹是否存在
    if [[ ! -d ${LOGDIR}/${APPNAME} ]]; then
        mkdir -p ${LOGDIR}/${APPNAME}
    fi

    # 判断应用目录日志文件夹是否是软连接
    if [[ ! -L ${APPNAME}/logs ]]; then
        # 判断应用目录日志文件夹是否是文件夹
        if [[ -d ${APPNAME}/logs ]]; then
            mv ${APPNAME}/logs/* ${LOGDIR}/${APPNAME}
            rmdir ${APPNAME}/logs
        fi
        ln -s ${LOGDIR}/${APPNAME} ${APPDIR}/${APPNAME}/logs
    else
        echo "日志文件夹已经是软链接"
    fi

    # 输出应用更新成功信息
    echo "Deploy ${APPNAME} success!"
}


# rollback function
function rollback() {
    cd ${APPDIR}

    # 判断是否是 tomcat 应用
    if echo "${APPNAME}" | grep tomcat ; then
        [[ -d ${APPNAME} ]] && rm -fr ${APPNAME}/webapps
        mv ${BAKDIR}/`ls -rht ${BAKDIR}|grep ${APPNAME}|tail -1` ${APPNAME}/webapps
    else
        [[ -d ${APPNAME} ]] && rm -fr ${APPNAME}
        mv ${BAKDIR}/`ls -rht ${BAKDIR}|grep ${APPNAME}|tail -1` ${APPNAME}
    fi

    # 判断应用日志文件夹是否存在
    if [[ ! -d ${LOGDIR}/${APPNAME} ]]; then
        mkdir -p ${LOGDIR}/${APPNAME}
    fi

    # 判断应用目录日志文件夹是否是软连接
    if [[ ! -L ${APPNAME}/logs ]]; then
        # 判断应用目录日志文件夹是否是文件夹
        if [[ -d ${APPNAME}/logs ]]; then
            mv ${APPNAME}/logs/* ${LOGDIR}/${APPNAME}
            rmdir ${APPNAME}/logs
        fi
        ln -s ${LOGDIR}/${APPNAME} ${APPDIR}/${APPNAME}/logs
    else
        echo "日志文件夹已经是软链接"
    fi

    # 输出应用回滚成功信息
    echo "Rollback ${APPNAME} success!"
}

usage

case $1 in
    start )
        start
        ;;
    stop )
        stop
        ;;
    restart )
        stop
        start
        ;;
    publish )
        stop
        backup
        deploy
        start
        ;;
    rollback )
        stop
        rollback
        start
        ;;
esac