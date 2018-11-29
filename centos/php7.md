php7
---
[参考文档](https://blog.csdn.net/weixin_37939964/article/details/78966326)  

没有安装EPEL的话，先执行，如果安装就跳过。
```sh
yum install epel-release -y
```
rpm 安装 Php7 相应的 yum源
```sh
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
```
卸载原有的php
```sh
yum remove php* php-common
```
直接yum安装php7
```sh
yum install php70w php70w-fpm php70w-mysql php70w-mbstring php70w-mcrypt php70w-gd php70w-imap php70w-ldap php70w-odbc php70w-pear php70w-xml php70w-xmlrpc php70w-pdo
# or
yum install php72w php72w-fpm php72w-mysql php72w-mbstring php72w-mcrypt php72w-gd php72w-imap php72w-ldap php72w-odbc php72w-pear php72w-xml php72w-xmlrpc php72w-pdo
```
查看php安装了那些拓展模块
```sh
php -m
```
安装其他你需要的拓展模块
```sh
yum -y install php70w-xxx
```