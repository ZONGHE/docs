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
yum localinstall mysql-community-release-el6-5.noarch.rpm
yum repolist all | grep mysql
yum-config-manager --disable mysql55-community
yum-config-manager --disable mysql56-community
yum-config-manager --enable mysql57-community-dmr
yum repolist enabled | grep mysql
```

**Step4:安装mysql 服务器命令：**
```sh
yum install mysql-community-server
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

### 修改密码

```sh
mysql -u root
mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpass');
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
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION;
```
操作完后切记执行以下命令刷新权限 
```mysql
FLUSH PRIVILEGES 
```