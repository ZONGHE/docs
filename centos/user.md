Centos User
---

创建一个组，并指定组id
```sh
groupadd -g 888 gavinning
```

创建用户，指定HOME目录和用户id
```sh
useradd gavinning -d /home/gavinning -g wheel -u 888888
```

给已有的用户增加工作组
```sh
usermod -G groupname username
```

永久性删除用户账号
```
userdel peter
groupdel peter
usermod –G peter peter		#（强制删除该用户的主目录和主目录下的所有文件和子目录）
```


# 添加sudo用户
```sh
# 添加super用户
# 作为公共管理员帐户
useradd super -d /home/super -g wheel

# 编辑sudoers
visudo /etc/sudoers

# 添加sudo权限
root ALL=(ALL) ALL # 查找当前行
super ALL=(ALL) ALL # 新增当前行
```