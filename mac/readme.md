Mac
---

#### 安装开发环境
```sh
xcode-select --install
```

#### 查看80端口是否被占用
```sh
lsof -i tcp:80
```


#### 安装 nginx
```sh
# Install
brew install nginx
# Start
brew services start nginx
# Stop
brew services stop nginx
# Restart
brew services restart nginx

# 查看所有 brew 服务列表
brew services list

# brew启动nginx默认只能启动非80端口，80端口需要用sudo启动，也就是用root用户才能启动
# 启动80端口服务前，要把普通用户进程的nginx服务停掉
brew services stop nginx
sudo brew services start nginx
```

#### PHP
Mac OSX 10.9以后的系统自带了PHP、php-fpm，省去了安装php-fpm的麻烦。 这里需要简单地修改下php-fpm的配置，否则运行php-fpm会报错。
```sh
sudo cp /etc/php-fpm.conf.default /etc/php-fpm.conf
vim /etc/php-fpm.conf
# 修改php-fpm.conf文件中的error_log项，默认该项被注释掉，这里需要去注释并且修改为error_log = /usr/local/var/log/php-fpm/error.log。如果不修改该值，运行php-fpm的时候会提示log文件输出路径不存在的错误。
# /usr/local/var/log/php-fpm/error.log 该路径请自行创建
```
```sh
#测试php-fpm配置
php-fpm -t
php-fpm -c /usr/local/etc/php/5.5/php.ini -y /usr/local/etc/php/5.5/php-fpm.conf -t

#启动php-fpm
php-fpm -D
php-fpm -c /usr/local/etc/php/5.5/php.ini -y /usr/local/etc/php/5.5/php-fpm.conf -D

#关闭php-fpm
kill -INT `cat /usr/local/var/run/php-fpm.pid`

#重启php-fpm
kill -USR2 `cat /usr/local/var/run/php-fpm.pid`
```


#### Mysql 5.7 修改密码
```sh
mysql -uroot -p
use mysql
update user set authentication_string = password('root'), password_expired = 'N', password_last_changed = now() where user = 'root';
```


### Install ip command
```sh
brew install iproute2mac
```