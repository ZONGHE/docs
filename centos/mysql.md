Mysql
---

#### 安装 Mysql
**Step1: 检测系统是否自带安装mysql**
```sh
yum list installed | grep mysql
```

**Step2: 删除系统自带的mysql及其依赖命令：**
```sh
yum -y remove mysql-libs.x86_64
```

**Step3: 给CentOS添加rpm源，并且选择较新的源命令：**  
如果要选择5.6，可以将5.6设置为``enable`` 5.7设置为``disable``
```sh
wget dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum localinstall mysql-community-release-el6-5.noarch.rpm -y
yum repolist all | grep mysql
yum-config-manager --disable mysql55-community
yum-config-manager --disable mysql56-community
yum-config-manager --enable mysql57-community-dmr
yum repolist enabled | grep mysql
```

**Step4:安装mysql 服务器命令：**
```sh
yum install mysql-community-server -y
```

**Step5: 启动mysql命令:**
```sh
service mysqld start
```

**Step6:创建快捷方式，修改``zsh``配置文件``~/.zshrc``**
```
alias mysqld="service mysqld"
```
```sh
mysqld start
mysqld stop
```

**Step:6 查看mysql是否自启动,并且设置开启自启动命令:**
```sh
chkconfig --list | grep mysqld
hkconfig mysqld on
```
  
  
---

### Mysql 5.7 查看初始密码
```sh
grep 'temporary password' /var/log/mysqld.log
# or
cat /root/.mysql_secret
```

### 修改密码

```sh
mysql -u root
mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpass');
# or
mysql> alter user root@localhost identified by 'newpass';
```

---

### 允许远程用户登录访问mysql的方法

需要手动增加可以远程访问数据库的用户。  
方法一、本地登入mysql，更改 "mysql" 数据库里的 "user" 表里的 "host" 项，将"localhost"改为"%"
```sh
mysql -u root -proot
mysql>use mysql;
mysql>update user set host = '%' where user = 'root';
mysql>select host, user from user;
```

方法二、直接授权(推荐)  
从任何主机上使用root用户，密码：youpassword（你的root密码）连接到mysql服务器：
```sh
mysql -u root -proot 
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION;

```
操作完后切记执行以下命令刷新权限 
```mysql
FLUSH PRIVILEGES 
```



### 常见问题
CentOS7yum安装mysql+需要：libsasl2.so.2()(64bit)
[参考文档](https://blog.csdn.net/qq_38417808/article/details/81291588)
[参考文档](http://blog.51cto.com/13155409/1969558)



### Mysql目录迁移
```sh
# 停止mysql
mysqladmin -u root -p shutdown

# 假设要迁移的目标位置是：<target dirname>: /data/apps/mysql

# 移动数据到目标目录
# 转移完数据之后记得检查文件及目录所有权，需设置为mysql:mysql 否则服务无法启动
mv /var/lib/mysql /data/apps/

# 修改配置文件 /etc/my.cnf || /usr/share/mysql/*.cnf
vim /etc/my.cnf

# 1. 修改 datadir 目录位置为 <target dirname>
# 2. 修改 socket 位置为 <target dirname>/mysql.sock
# 3. 修改 log-error 位置
# 4. 可选修改 pid-file 位置

# 5. 最后，最重要的是一定要检查上述目录的所有权是 mysql:mysql
# 6. 重启服务，如果服务无法启动，检查启动失败说明，检查mysql错误日志
```
[Mysql位置迁移参考文档](https://blog.csdn.net/qq_36040184/article/details/53889856)




### 常见问题
1、
```log
# in docker
Version: '5.6.41'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MySQL Community Server (GPL)
2018-08-17 08:13:33 437 [Note] Plugin 'FEDERATED' is disabled.
/usr/sbin/mysqld: Table storage engine for 'plugin' doesn't have this option
2018-08-17 08:13:33 437 [ERROR] Can't open the mysql.plugin table. Please run mysql_upgrade to create it.
```
解决方案
```sh
find /var/lib/mysql -type f -exec touch {} \; && service mysql start
```
[参考文档](https://github.com/docker/for-linux/issues/72)

2、
```err
Host '**.***.**.***' is not allowed to connect to this MySQL server.
```
原因：回滚等操作可能会引起配置恢复，导致远程连接设置丢失
解决方案：重新设置远程连接权限
```sh
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```