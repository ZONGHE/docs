Firewalld
---
For centos 7


### 常用
```sh
systemctl status firewalld
systemctl start firewalld
systemctl stop firewalld
systemctl restart firewalld



# 重载 · 保持用户连接状态
firewall-cmd --reload

# 重载 · 重置用户连接状态
firewall-cmd --complete-reload

# 状态查看
firewall-cmd --state

# 查看端口
firewall-cmd --list-ports

# 查看转发端口
firewall-cmd --list-forward-ports
```

### 增删端口
```sh
# 临时删除端口
firewall-cmd --remove-port=8056/tcp

# 永久开放端口
firewall-cmd --zone=public --add-port=3306/tcp --permanent

# 永久删除对外开放的端口
firewall-cmd --zone=public --remove-port=3306/tcp --permanent
```

### 端口转发
```sh
# 端口转发需要开启IP伪装功能
# 端口转发可以将指定地址访问指定的端口时，将流量转发至指定地址的指定端口。
# 转发的目的如果不指定ip的话就默认为本机，如果指定了ip却没指定端口，则默认使用来源端口。

firewall-cmd --query-masquerade  # 检查是否允许伪装IP
firewall-cmd --permanent --add-masquerade  # 允许防火墙伪装IP
firewall-cmd --permanent --remove-masquerade  # 禁止防火墙伪装IP

# 将80端口的流量转发至8080
firewall-cmd --permanent --add-forward-port=port=80:proto=tcp:toport=8080
# 将80端口的流量转发至
firewall-cmd --permanent --add-forward-port=port=80:proto=tcp:toaddr=192.168.1.0.1
# 将80端口的流量转发至192.168.0.1的8080端口
firewall-cmd --permanent --add-forward-port=port=80:proto=tcp:toaddr=192.168.0.1:toport=8080


### 批量转发
### 可以依靠此功能批量转发端口到docker容器
# 例 批量转发10000-20000到指定ip的10000-20
firewall-cmd --permanent --add-forward-port=port=10000-20000:proto=tcp:toaddr=172.17.0.1:toport=10000-20000
# 删除转发
firewall-cmd --permanent --remove-forward-port=port=10000-20000:proto=tcp:toaddr=172.17.0.1:toport=10000-20000


# 转发端口到指定ip的指定端口
# --zone=public 表示外网转发
firewall-cmd --permanent --zone=public --add-forward-port=port=8056:proto=tcp:toaddr=xxx.xx.xx.xxx:toport=3356

# 删除转发规则
firewall-cmd --permanent --zone=public --remove-forward-port=port=8056:proto=tcp:toaddr=xxx.xx.xx.xxx:toport=3356
```


### Docker
docker容器访问宿主机可能会被``firewall``封禁，单纯开启端口不能生效  
需要添加``172.17.0.0/16``网段白名单

```sh
firewall-cmd --permanent --zone=trusted --add-source=172.17.0.0/16
firewall-cmd --reload
```
[参考文档](https://blog.csdn.net/evandeng2009/article/details/88857813)

将虚拟网卡docker0添加到trusted模式下。但是完成后需要重启防火墙才可以生效。
```sh
firewall-cmd --permanent --add-interface=docker0 --zone=trusted
```