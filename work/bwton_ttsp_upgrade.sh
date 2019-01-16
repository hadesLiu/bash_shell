#!/usr/bin/env bash
# @Author  : hiro, 
# @Mail    : hiroliu@yeah.net
# @Time    : 2019/1/16 2:06 PM
# @Decription : start|stop|restart|deploy|rollback app


APPDIR=$2  # /opt/app
APPNAME=$3  # ttsp-admin-dubbo-22991
TARSOURCE=$4  # /opt/package
TARSUFFIX=$5  # .tar
LOGDIR=$6  # /opt/logs
BAKDIR=$7   # /opt/backup
SERVER_PORT=$8 # 22991
BINDIR=${APPDIR}/${APPNAME}/bin
CONF_DIR=${APPDIR}/${APPNAME}/conf
PARAMNUM=$#
SCRIPTNAME=$0


# usage function
function usage() {
	[[ ${PARAMNUM} -ne 8 ]] && {
		echo "usage: $0 start|stop|restart|publish|rollback APPDIR APPNAME TARSOURCE TARSUFFIX LOGDIR BAKDIR SERVER_PORT"
		exit 1
	}
}


# start function
function start() {

    PIDS=`ps -ef | grep java | grep "$CONF_DIR" |awk '{print $2}'`

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


    echo -e "Starting the ${APPNAME} ...\c"
    bash ${BINDIR}/start.sh

    # 判断应用是否启动成功
    COUNT=0
    while [[ ${COUNT} -lt 1 ]]; do
        echo -e ".\c"
        sleep 1
        if [[ -n "${SERVER_PORT}" ]]; then
            COUNT=`netstat -ant | grep ${SERVER_PORT} | wc -l`
        else
            COUNT=`ps -f | grep java | grep "${CONF_DIR}" | awk '{print $2}' | wc -l`
        fi
        if [[ ${COUNT} -gt 0 ]]; then
            break
        fi
    done

    echo "OK!"
    PIDS=`ps -f | grep java | grep "${CONF_DIR}" | awk '{print $2}'`
    echo "Start ${APPNAME} Success, PID: $PIDS"

}


# stop function
function stop() {

    PIDS=`ps -ef | grep java | grep "$CONF_DIR" |awk '{print $2}'`

    # 判断应用是否已经停止
    if [[ -z "$PIDS" ]]; then
        echo "ERROR: The ${APPNAME} does not started!"
        return 1
    fi

    echo -e "Stopping the ${APPNAME} ...\c"
    for PID in ${PIDS} ; do
        kill ${PID} > /dev/null 2>&1
    done

    # 判断应用是否停止成功
    COUNT=0
    while [[ ${COUNT} -lt 1 ]]; do
        echo -e ".\c"
        sleep 1
        COUNT=1
        for PID in ${PIDS} ; do
            PID_EXIST=`ps -f -p ${PID} | grep java`
            if [[ -n "${PID_EXIST}" ]]; then
                COUNT=0
                break
            fi
        done
    done

    echo "OK!"
    echo "Stop ${APPNAME} Success, PID: $PIDS"

}


# backup function
function backup() {
	cd ${APPDIR}
	[[ ! -d ${APPNAME} ]] && return 2
	mv -r ${APPNAME} ${BAKDIR}/${APPNAME}_`date +%F_%T`
	if [[ $? -eq 0 ]]; then
	    echo "Backup ${APPNAME} success!"
	else
	    echo "Backup ${APPNAME} failed!"
	    exit 1
	fi
}


# deploy function
function deploy() {
    cd ${APPDIR}
	tar xf ${TARSOURCE}/${APPNAME}${TARSUFFIX} -C ${APPDIR}
	[[ ! -d ${LOGDIR}/${APPNAME} ]] && mkdir -p ${LOGDIR}/${APPNAME}
	[[ -d ${APPNAME}/logs ]] && mv ${APPNAME}/logs/* ${LOGDIR}/${APPNAME} && rmdir ${APPNAME}/logs
	[[ ! -L ${APPNAME}/logs ]] && ln -s ${LOGDIR}/${APPNAME} ${APPDIR}/${APPNAME}/logs
	echo "Deploy ${APPNAME} success!"
}


# rollback function
function rollback() {
	cd ${APPDIR}
	[[ -d ${APPNAME} ]] && rm -fr ${APPNAME}
	mv -r ${BAKDIR}/`ls -rht ${BAKDIR}|grep ${APPNAME}|tail -1` ${APPNAME}
	[[ ! -d ${LOGDIR}/${APPNAME} ]] && mkdir -p ${LOGDIR}/${APPNAME}
	[[ -d ${APPNAME}/logs ]] && mv ${APPNAME}/logs/* ${LOGDIR}/${APPNAME} && rmdir ${APPNAME}/logs
	[[ ! -L ${APPNAME}/logs ]] && ln -s ${LOGDIR}/${APPNAME} ${APPDIR}/${APPNAME}/logs
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


