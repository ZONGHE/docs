centos
---
centos in docker


### Install
```sh
docker pull hub.c.163.com/library/centos:latest
```

### Usage
```sh
# 启动centos
docker run --name centos -p 80:80 -dit <imageId>

# 进入docker环境
docker attach <containerId>
```

```sh
docker run --name centos -d --privileged [IMAGE ID] /usr/sbin/init
docker ps
docker exec -it [CONTAINER ID] /bin/bash
```


### 常见问题
1、x509
```
Get https://registry-1.docker.io/v2/: x509: certificate has expired or is not yet valid
```
原因：本地系统时间错误导致证书过期
解决：修正本地系统时间
```sh
date  # 查看本地系统时间
ntpdate cn.pool.ntp.org  # 同步时间
```

2、找不到service命令
```sh
bash: service: command not found
```
解决：
```sh
yum list | grep initscripts  # 显示可安装软件的yum源版本
yum install -y initscripts  
```
[参考文档](https://blog.csdn.net/lcrxxoo/article/details/80683791)  

3、systemctl不可用
```sh
Redirecting to /bin/systemctl start mysqld.service
Failed to get D-Bus connection: Operation not permitted
```
解决：
```sh
docker run -d --privileged [IMAGE ID] /usr/sbin/init
docker ps
docker exec -it [CONTAINER ID] /bin/bash
```
[参考文档](https://blog.csdn.net/qq_29755359/article/details/80589472)  

4、
```sh
Delta RPMs disabled because /usr/bin/applydeltarpm not installed
```
解决：
```sh
yum provides '*/applydeltarpm'  
yum install deltarpm -y
```
[参考文档](https://shipengliang.com/software-exp/delta-rpms-disabled-because-usr-bin-applydeltarpm-not-installed-%E8%A7%A3%E5%86%B3%E5%8A%9E%E6%B3%95.html)  

