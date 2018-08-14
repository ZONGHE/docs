centos
---
通用文档

常用命令
```sh
# 查看系统版本
cat /etc/os-release

# centos关机命令
halt  #立马关机
shutdown -h 10  #1分钟后自动关机
poweroff  # 立刻关机,并且电源也会断掉
shutdown -h now  # 立刻关机(root用户使用)
# 如果是通过shutdown命令设置关机的话，可以用shutdown -c命令取消重启


# 查看端口占用情况
netstat -lnp | grep 80
lsof -i tcp:80
# 列出所有端口
netstat -ntlp
# 查看进程
ps pid


# 开启端口（以80端口为例）
/sbin/iptables -I INPUT -p tcp –dport 80 -j ACCEPT   # 写入修改
/etc/init.d/iptables save   # 保存修改
service iptables restart    # 重启防火墙，修改生效


# 查看远程端口是否开放
nmap ip  # 查看指定ip开放的端口
nmap ip port  # 查看指定ip指定端口是否开放
telnet ip port  # 根据返回值查看指定ip指定端口是否开放


# 开机器启动
chkconfig nginx on
chkconfig redis on
chkconfig mysql on
chkconfig docker on

systemctl enable redis.service
systemctl enable nginx.service
systemctl enable mysqls.service
systemctl enable docker.service

# 开启守护进程
systemctl start redis.service
systemctl start nginx.service
systemctl start mysqls.service
systemctl start docker.service
```
[chkconfig](http://man.linuxde.net/chkconfig)  
[systemctl](http://man.linuxde.net/systemctl)  


---
CENTOS 6.x lab
---

### 1 更新系统
```sh
yum update
```

#### 1.1 修改 hostname
**Step1:修改/etc/hosts**
```sh
# localhost.localdomain => yourhostname
vim /etc/hosts
```

**Step2:修改/etc/sysconfig/network**
```sh
# 修改hostname的值 => yourhostname
vim /etc/sysconfig/network
```

**Step2:重启生效**
```sh
reboot
```

#### 1.2 禁止root用户远程登录，修改ssh登录默认端口
**Step1:禁止root用户远程登录**
```sh
vim /etc/ssh/sshd_config
# 找到 PermitRootLogin yes 改成 no 并去掉行前注释使其生效
```

**Step2:修改ssh登录默认端口**
```sh
vim /etc/ssh/sshd_config
# 找到 #Port 22，这里是标识默认使用22端口，修改为如下：
```
```
Port 22
Port 10086
```

**Step3:重启ssh服务使其生效**
```sh
/etc/init.d/sshd restart
```

**Step4:编辑防火墙配置，启用10086端口**
```sh
vi /etc/sysconfig/iptables

# 找到下面一行
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT

# 在下面添加一行
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 10086 -j ACCEPT

/etc/init.d/iptables restart  # 重启防火墙
```

**Step4:测试10086端口是否可以正常服务**
```sh
# 如果可以正常连接，则删除 Port 22 的配置项
# 前面不删除22端口是因为要保证新的端口10086可以正常访问方可删除，防止意外情况发生
# done
```

#### 1.3 禁止某些帐户ssh远程登录，例如 git
**Step1:打开sshd的配置文件**
```sh
vim /etc/ssh/sshd_config
```

**Step2:修改该配置文件，增加或修改如下行**
```sh
# 禁止用户git登陆，多个空格分隔
DenyUsers git
# 禁止用户组git的所有用户登录，多个空格分隔
DenyGroups git
```

**Step3:保存配置后，重启sshd**
```sh
service sshd restart
# or
/etc/rc.d/init.d/sshd restart
```

#### 1.4 配置sudo
```sh
visudo -f /etc/sudoers
# 找到
root ALL=(ALL) ALL
# 在其下面添加用户，例如
tom ALL=(ALL) ALL
# 保存退出则生效
```

#### 1.5 更新yum源的方法，网易源为例
**Step1:下载repo文件**
```sh
wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
```

**Step2:备份并替换系统的repo文件**
```sh
cd /etc/yum.repos.d/
mv CentOS-Base.repo CentOS-Base.repo.bak
mv CentOS6-Base-163.repo CentOS-Base.repo
```

**Step3:执行yum源更新**
```sh
yum clean all
yum makecache
yum update
```
[参考文档](https://blog.csdn.net/u013850277/article/details/79240695)

### 2 安装基本环境
```sh
yum install zsh
yum install git
```
#### 2.1 安装 oh-my-zsh
via curl
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
via wget
```sh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

修改``~/.zshrc``配置文件
```sh
alias cd..="cd .."
alias cd...="cd ..."
alias sub.="sub ."
alias atom.="atom ."
alias tmp="cd ~/tmp"

alias g="git"
alias gcm="g cm"
alias gbr="g br"
alias gdf="g df"
alias gst="g st"
alias gpm="g push origin master"
alias gpd="g push origin dev"
alias gad="g add --all"
alias gadd="g add --all"
alias gast="g add --all & g st"

alias mysqld="service mysqld"
```

#### 2.2 安装 Nginx
**Step1:创建源配置文件 nginx.repo**
```sh
ps.提权：chmod 700 yum.repos.d
root权限：su,更改root密码:sudo passwd
cd /etc/yum.repos.d/
vim nginx.repo
```

**Step2:填充下面内容，并保存退出**
```sh
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
```

**Step3:执行安装**
```sh
yum install nginx -y
```

**Step4:命令及配置文件位置**
```sh
/etc/init.d/nginx start # 启动Nginx服务
/etc/init.d/nginx stop # 停止Nginx服务
/etc/nginx/nginx.conf # Nginx配置文件位置
/usr/share/nginx/html # Nginx默认服务器目录
```

如果还无法访问，则需配置一下Linux防火墙。
```sh
iptables -I INPUT 5 -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

service iptables save
service iptables restart
```

如果更改了Nginx默认网站目录，需要给予新的目录配置权限
```sh
chown -R nginx:nginx TargetFolder
```

**Step5:创建快捷访问方式**
```sh
cd /usr/local/bin
ln -s /etc/init.d/nginx ng
```
以后便可以使用以下方式快捷访问nginx
```sh
ng start
ng stop
```

开机启动nginx
```sh
chkconfig --level 345 nginx on  
```


#### 2.3 安装 Mysql
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


#### 2.4 安装 Nodejs
v6.x
```sh
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
```

v7.x
```sh
curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
```

Install Nodejs
```sh
yum -y install nodejs
```

Install cnpm
```sh
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

Install pm2
```sh
cnpm i pm2 -g

cd /usr/local/bin
ln -s ../lib/node_modules/pm2/bin/pm2 pm
pm -v
pm ls
```
