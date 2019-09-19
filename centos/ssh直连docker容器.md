ssh直连容器
---
[参考文档](https://www.jianshu.com/p/426f0d8e6cbf)
[参考文档](https://blog.csdn.net/luvzhan/article/details/40827201)


容器ssh配置
```sh
# 1
# 进入个人容器-打开ssh配置文件
vim /etc/ssh/sshd_config

# 2
# 搜索Port 22，注释掉
# 新增一行 Port your-port
# 例如
Port 9097 # 此处端口号填写分给自己容器里的最后一个端口号，替换掉9097

# 3
# 开启ssh下列选项
PermitRootLogin yes
PubkeyAuthentication yes
AuthorizedKeysFile      .ssh/authorized_keys

# 4
# 保存退出 重启sshd
systemctl restart sshd

# 5
# 切换到自己的主机
cat ~/.ssh/id_rsa.pub
# 复制内容到个人容器 ~/.ssh/authorized_keys 文件内，保存并退出

# 6
# 切换到主机
ssh root@domain -p port

# 7
# 快捷登陆设置
vim /usr/local/bin/j2
# =>
ssh root@domain -p port
# :wq

# 8
# 命令行输入j2命令即可快捷登陆到容器环境
j2


# 常见问题 oh-my-zsh
# 9
# the last
# 修改zsh配置文件
vim ~/.zshrc
# 新增以下内容 =>
export LC_ALL="en_US.UTF-8"
# or
export LC_ALL="en_US.UTF-8" 
export LANG="en_US.UTF-8" 
export LANGUAGE="en_US.UTF-8" 

# 保存并退出
source ~/.zshrc
# done
```