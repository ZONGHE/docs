docker
---
centos 7  
[入门](https://blog.csdn.net/S_gy_Zetrov/article/details/78161154)  
[官方文档](https://docs.docker.com/get-started/)  
[Docker创建镜像](https://blog.csdn.net/shiqiangdexin/article/details/52472195)  


### Install
```sh
[sudo] yum install docker
```


### 修改国内镜像
```sh
vi /etc/docker/daemon.json
```
```json
{
    "registry-mirrors": [
        "https://registry.docker-cn.com"
    ]
}
```
重启
```sh
[sudo] systemctl restart docker.service
```
[参考文档](https://blog.csdn.net/antma/article/details/80134863)  
[参考文档](https://blog.csdn.net/zzy1078689276/article/details/77371782)  



### 创建docker用户组 避免docker命令需要sudo
```sh
# 查看用户组中有没有docker组
sudo cat /etc/group | grep docker  

# 创建docker用户组
sudo groupadd docker  
# 添加当前用户到docker组 当前用户需有sudo权限
sudo usermod -aG docker gavinning  
sudo usermod -aG dockerroot gavinning  

cat /etc/group

# 退出当前用户登陆状态，然后重新登录，以便让权限生效
# 或重启docker-daemon
sudo systemctl restart docker

# 测试权限
docker info

# 如果提示get ......dial unix /var/run/docker.sock权限不够
# 则修改/var/run/docker.sock权限
sudo chmod a+rw /var/run/docker.sock
```



### 常用命令
```sh
docker -h
docker -v
docker version
docker ps
docker ps -a
docker images

# 保存镜像
docker commit -m "commit message" -a gavinning <cid> gavinning/name:tag
```

### 清理
```sh
docker ps -a  # 查询所有容器
docker rm docker ps -a|grep Exited|awk '{print $1}'  # 查询所有未运行的容器
docker rm $(sudo docker ps -a -q)  # 删除所有未运行的容器
docker rm $(sudo docker ps -qf status=exited)  # 删除状态为 exited 的容器

sudo docker container prune  # 1.13版本之后 删除所有未运行容器

# docker container 自动重启 run的时候添加参数
docker run --restart unless-stopped
```
[docker容器自动重启](https://blog.csdn.net/wennuanddianbo/article/details/77592401)




### 常见问题
1、Docker宿主机agetty进程cpu占用率100% 问题
```sh
# 引起原因 是在使用"docker run"运行容器时使用了 "/sbin/init"和"--privileged"参数

# 解决方案
systemctl stop getty@tty1.service
systemctl mask getty@tty1.service
```
[参考文档](https://blog.csdn.net/bobpen/article/details/78559263)