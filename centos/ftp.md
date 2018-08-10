配置FTP
---
[参考文档](http://www.centoscn.com/CentosServer/ftp/2015/0803/5953.html)


安装
```sh
yum -y install vsftpd
chkconfig vsftpd on
```

修改配置文件
```sh
vim /etc/vsftpd/vsftpd.conf

local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES      #这行可能需自己写
pam_service_name=vsftpd
userlist_enable=YES
```

启动
```sh
service vsftpd start
```

添加FTP账号
```sh
useradd -d /home/网站目录 -s /sbin/nologin 用户名
passwd 用户名
```

设置防火墙
```sh
vi /etc/sysconfig/iptables-config
# 添加一行
IPTABLES_MODULES="ip_conntrack_ftp"

vi /etc/sysconfig/iptables
# 允许21端口
-A INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT

service iptables restart
```

到此，应该是可以了，若软件测试连接过程中，在用户验证的时候出现了错误503，应该是selinux设置的问题：可以用下面的命令检查
```sh
[root@localhost ~]#getsebool -a |grep ftp

allow_ftpd_anon_write --> off
allow_ftpd_full_access --> off
allow_ftpd_use_cifs --> off
allow_ftpd_use_nfs --> off
allow_tftp_anon_write --> off
ftp_home_dir --> off
ftpd_connect_db --> off
ftpd_disable_trans --> off
ftpd_is_daemon --> on
httpd_enable_ftp_server --> off
```

这是selinux的问题，我们只要打开ftp_home_dir的值开启为on：，allow_ftpd_full_access也一同开启即可。
```sh
[root@localhost ~]#setsebool -P ftp_home_dir 1
[root@localhost ~]#setsebool -P allow_ftpd_full_access 1
```
