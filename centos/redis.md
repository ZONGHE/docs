redis
---
redis in centos


### Install
```sh
yum info redis  # 查看是否有redis源
yum install epel-release  # 如果没有则下载fedora的epel仓库
yum install redis -y
systemctl start redis.service
systemctl enable redis.service
```


### Usage
默认端口：6379
```sh
redis-cli  # 进入redis命令行
redis-cli shutdown  # 关闭服务
```