ssh auto login
---
设置机器 A 自动登陆机器 B

#### Step
```sh
# 1、
# -P表示密码，-P '' 就表示空密码，也可以不用-P参数，这样就要三车回车，用-P就一次回车。
# 该命令将在/root/.ssh目录下面产生一对密钥id_rsa和id_rsa.pub。
# id_rsa     私钥
# id_rsa.pub 公钥
ssh-keygen -t rsa -P ''

# 2、将 id_rsa.pub 上传到 B机器的 ~/.ssh目录下 然后登陆到 B机器
cd ~/.ssh
cat id_rsa.pub > authorized_keys
chmod 600 authorized_keys
```



### 禁止root远程登录
1、修改sshd_config文件
```sh
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
```

2、重启ssh服务
```sh
service sshd restart
```