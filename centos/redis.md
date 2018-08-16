redis
---
redis in centos


### Install
```sh
yum info redis  # 查看是否有redis源
yum install epel-release -y  # 如果没有则下载fedora的epel仓库
yum install redis -y
systemctl start redis.service
systemctl status redis.service
systemctl enable redis.service
```


### Usage
默认端口：6379
```sh
redis-cli  # 进入redis命令行
redis-cli shutdown  # 关闭服务
```

redis 修改配置文件 设置远程连接
```sh
1注释掉bind 127.0.0.1;在地址前面加个#；

# 2设置密码，在#requirepass foobared去掉#号变requirepass foobared;foobared是密码;
requirepass yourpassword

# protected-mode 设置成no;修改后是protected-mode no;
protected-mode no

# 修改daemonize no 为 daemonize yes 添加后台运行
daemonize yes
```
默认目录迁移
```sh
# 数据目录
dir /var/lib/redis
# =>
dir /data/apps/redis

# 日志目录
logfile /var/log/redis/redis.log
# =>
logfile /data/logs/redis/redis.log
```