PHPBrew* 尚未完成
---
[PHPBrew](https://github.com/phpbrew/phpbrew)  
[依赖参考文档](https://github.com/phpbrew/phpbrew/wiki/Requirement)  
[中文文档](https://github.com/phpbrew/phpbrew/blob/master/README.cn.md)  



### Install
依赖安装 centos
```sh
yum install make automake gcc gcc-c++ kernel-devel
yum install php php-devel php-pear bzip2-devel yum-utils bison re2c libmcrypt-devel libpqxx-devel libxslt-devel pcre-devel libcurl-devel libgsasl-devel openldap-devel
yum-builddep php

yum install httpd-devel

# CentOS/RHEL 7.x:
sudo rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# CentOS/RHEL 6.x:
sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

# If you don't have php
sudo yum install --enablerepo=webtatic php php-xml
wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
sudo rpm -Uvh rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
sudo yum install --enablerepo=rpmforge re2c libmhash
```
PHPBrew安装
```sh
curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew

# Move phpbrew to somewhere can be found by your $PATH
sudo mv phpbrew /usr/local/bin/phpbrew
```
