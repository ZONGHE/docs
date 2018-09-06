#!/bin/sh
#chkconfig: 2345 10 90
#description: Startup and stop script for Redis
#同时启动多个redis实例
 
PATH=/usr/local/bin:/sbin:/usr/bin:/bin

REDISPORT_1=6379
REDISPORT_2=6380
REDISPORT_3=6381
REDISPORT_4=6382
REDISPORT_5=6383
REDISPORT_6=6384
REDISPORT_7=6385
REDISPORT_8=6386
REDISPORT_9=6387
REDISPORT_10=6388
REDISPORT_11=6389
REDISPORT_12=6398
REDISPORT_13=6399


REDISPORTS=($REDISPORT_1 $REDISPORT_2 $REDISPORT_3 $REDISPORT_4 $REDISPORT_5 $REDISPORT_6 $REDISPORT_7 $REDISPORT_8 $REDISPORT_9 $REDISPORT_10 $REDISPORT_11 $REDISPORT_12 $REDISPORT_13)
 
EXEC=/usr/bin/redis-server
REDIS_CLI=/usr/bin/redis-cli
 
PIDFILE_1=/var/run/redis/redis_6379.pid
PIDFILE_2=/var/run/redis/redis_6380.pid
PIDFILE_3=/var/run/redis/redis_6381.pid
PIDFILE_4=/var/run/redis/redis_6382.pid
PIDFILE_5=/var/run/redis/redis_6383.pid
PIDFILE_6=/var/run/redis/redis_6384.pid
PIDFILE_7=/var/run/redis/redis_6385.pid
PIDFILE_8=/var/run/redis/redis_6386.pid
PIDFILE_9=/var/run/redis/redis_6387.pid
PIDFILE_10=/var/run/redis/redis_6388.pid
PIDFILE_11=/var/run/redis/redis_6389.pid
PIDFILE_12=/var/run/redis/redis_6398.pid
PIDFILE_13=/var/run/redis/redis_6399.pid
PIDFILES=($PIDFILE_1 $PIDFILE_2 $PIDFILE_3 $PIDFILE_4 $PIDFILE_5 $PIDFILE_6 $PIDFILE_7 $PIDFILE_8 $PIDFILE_9 $PIDFILE_10 $PIDFILE_11 $PIDFILE_12 $PIDFILE_13)
CONF_1=/etc/redis_6379.conf
CONF_2=/etc/redis_6380.conf
CONF_3=/etc/redis_6381.conf
CONF_4=/etc/redis_6382.conf
CONF_5=/etc/redis_6383.conf
CONF_6=/etc/redis_6384.conf
CONF_7=/etc/redis_6385.conf
CONF_8=/etc/redis_6386.conf
CONF_9=/etc/redis_6387.conf
CONF_10=/etc/redis_6388.conf
CONF_11=/etc/redis_6389.conf
CONF_12=/etc/redis_6398.conf
CONF_13=/etc/redis_6399.conf
CONFS=($CONF_1 $CONF_2 $CONF_3 $CONF_4 $CONF_5 $CONF_6 $CONF_7 $CONF_8 $CONF_9 $CONF_10 $CONF_11 $CONF_12 $CONF_13)

PASSWORD_1="liujiaqi"
PASSWORD_2="luxingmin"
PASSWORD_3="liujianmin"
PASSWORD_4="fenglipeng"
PASSWORD_5="limao"
PASSWORD_6="xuchunhong"
PASSWORD_7="huangxiongyi"
PASSWORD_8="wangwenyu"
PASSWORD_9="hezhiqiang"
PASSWORD_10="7ujm8ik,"
PASSWORD_11="7ujm8ik,"
PASSWORD_12="7ujm8ik,"
PASSWORD_13="7ujm8ik,"
PASSWORDS=($PASSWORD_1 $PASSWORD_2 $PASSWORD_3 $PASSWORD_4 $PASSWORD_5 $PASSWORD_6 $PASSWORD_7 $PASSWORD_8 $PASSWORD_9 $PASSWORD_10 $PASSWORD_11 $PASSWORD_12 $PASSWORD_13)
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