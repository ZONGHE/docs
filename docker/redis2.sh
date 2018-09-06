#!/bin/sh
#chkconfig: 2345 10 90
#description: Startup and stop script for Redis
#同时启动多个redis实例
 
PATH=/usr/local/bin:/sbin:/usr/bin:/bin

REDISPORT_1=6379
REDISPORT_2=6380
REDISPORTS=($REDISPORT_1 $REDISPORT_2)
 
EXEC=/usr/bin/redis-server
REDIS_CLI=/usr/bin/redis-cli
 
PIDFILE_1=/var/run/redis/redis_6379.pid
PIDFILE_2=/var/run/redis/redis_6380.pid
PIDFILES=($PIDFILE_1 $PIDFILE_2)

CONF_1=/etc/redis_6379.conf
CONF_2=/etc/redis_6380.conf
CONFS=($CONF_1 $CONF_2)

PASSWORD_1="gavinning1"
PASSWORD_2="gavinning2"
PASSWORDS=($PASSWORD_1 $PASSWORD_2)

case "$1" in
    start)
        i=0
        for PID in ${PIDFILES[@]}
        do
                if [ -e $PID ]
                then
                        echo "$PID has exist, process is running"
                else
                        echo "$PID Start ..."
                        $EXEC ${CONFS[i]} &
                fi
                if [ "$?" == "0" ]
                then
                        echo "$PID is running"
                else
                        echo "$PID is failed to start"
                fi
                let i++
        done
        ;;
 
    stop)
        i=0
        for PID in ${PIDFILES[@]}
        do
                if [ ! -e $PID ]
                then
                        echo "$PID does not exist, process is not running"
                else
                        echo "$PID Stoping ..."
                        $REDIS_CLI -a ${PASSWORDS[i]} -p ${REDISPORTS[i]} SHUTDOWN
                        sleep 2
                        while [ -e $PID ]
                        do
                            echo "Waiting for Redis to shutdown ..."
                            sleep 1
                        done
                        echo "$PID stopped"
                fi
                let i++
        done
        ;;
 
   restart)
        ${0} stop
        ${0} start
        ;;
  *)
    echo "Usage: /etc/init.d/redis {start|stop|restart}" >&2
        exit 1
esac