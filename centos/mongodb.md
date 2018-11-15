Mongodb
---
mongo in centos


### Install
yum安装老失败 索性转为手动安装
```sh
# 下载需要的版本
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.2.20.tgz

tar -zxvf mongodb-linux-x86_64-rhel70-3.2.20.tgz

# 移动到安装位置
mv mongodb-linux-x86_64-rhel70-3.2.20 /usr/local/lib/mongodb

# 设置环境变量
export PATH=$PATH:/usr/local/lib/mongodb/bin

# 创建mongodb用户
adduser mongodb
```


### mongod.service
手动安装需要自己写service配置文件
```sh
vim /usr/lib/systemd/system/mongod.service
```
=>
```service
[Unit]
Description=Mongodb
After=network.target remote-fs.target nss-lookup.target

[Install]
WantedBy=multi-user.target

[Service]
User=mongodb
Group=mongodb

Type=forking

PIDFile=/var/run/mongod/mongod.pid

TimeoutSec=0

ExecStart=/usr/local/lib/mongodb/bin/mongod --config /etc/mongod.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/usr/local/lib/mongodb/bin/mongod --shutdown --config /etc/mongod.conf

Restart=on-failure

PrivateTmp=false

[Install]
WantedBy=multi-user.target
```
[参考文档](http://www.ruanyifeng.com/blog/2016/03/node-systemd-tutorial.html)  

### /etc/mongod.conf
```sh
# 创建配置文件
vim /etc/mongod.conf
chown mongodb:mongodb /etc/mongod.conf

# 创建进程文件夹
mkdir /var/run/mongod
chown mongodb:mongodb /var/run/mongod

# 创建统一的数据文件夹
mkdir /data
mkdir /data/logs
mkdir /data/mongodb
```
=>
```sh
port = 27017
dbpath = /data/mongodb
logpath = /data/logs/mongodb.log
logappend = true
fork = true

bind_ip = 0.0.0.0
auth = true
```

### 创建用户
```sh
# 创建超级用户
use admin
db.createUser({
    user: 'root',
    pwd: 'password',
    roles: [
        {
            role: 'root',
            db: 'admin'
        }
    ]
})
```
```sh
# 开启登陆验证
vim /etc/mongo.conf

security:
  authorization: enabled
```

先连接再认证
```sh
db.auth('username','password')
```

连接时认证
```sh
mongo -u root -p root --authenticationDatabase 'admin'
```

[创建用户参考文档](https://www.cnblogs.com/xiaoqian1993/p/5944039.html)






### 通过阿里云镜像安装
[mongo](https://mirrors.aliyun.com/mongodb/)
[mongo 3.2.20](https://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.2/x86_64/RPMS/)
```sh
# 首先安装4个依赖
wget https://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.2/x86_64/RPMS/mongodb-org-mongos-3.2.20-1.el7.x86_64.rpm
wget https://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.2/x86_64/RPMS/mongodb-org-server-3.2.20-1.el7.x86_64.rpm
wget https://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.2/x86_64/RPMS/mongodb-org-tools-3.2.20-1.el7.x86_64.rpm
wget https://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.2/x86_64/RPMS/mongodb-org-shell-3.2.20-1.el7.x86_64.rpm

yum localinstall -y mongodb-org-mongos-3.2.20-1.el7.x86_64.rpm
yum localinstall -y mongodb-org-server-3.2.20-1.el7.x86_64.rpm
yum localinstall -y mongodb-org-tools-3.2.20-1.el7.x86_64.rpm
yum localinstall -y mongodb-org-shell-3.2.20-1.el7.x86_64.rpm

# 最后安装mongo主体
wget https://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.2/x86_64/RPMS/mongodb-org-3.2.20-1.el7.x86_64.rpm

yum localinstall -y https://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.2/x86_64/RPMS/mongodb-org-3.2.20-1.el7.x86_64.rpm
```


### 遇到的问题
1、docker容器环境里数据挂载到host目录，因为用户名是创建在数据库里
所以当新起容器之后，新创建的数据库是没有用户名和密码的