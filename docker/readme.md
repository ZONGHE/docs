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


2、firewalld影响docker启动
```sh
# 报错结果如下
ERROR: for docker-php_redis_1  Cannot start service redis: driver failed programming external connectivity on endpoint docker-php_redis_1 (85374c46684140ff5cb45cc4452058570942242121b12ee84e00c12a0bbb9e12):  (iptables failed: iptables --wait -t nat -A DOCKER -p tcp -d 0/0 --dport 6380 -j DNAT --to-destination 192.168.48.4:6379 ! -i br-88fd6ade0ba7: iptables: No chain/target/match by that name
```
**字面意思：**  
由字面意思看，是因为docker之前加载了宿主机的iptables。  
**分析原因：**  
因切防火墙策略导致docker加载iptables失败。因本身是docker间通信，所以不需要配置iptables，则在启动docker的时候关闭iptables  
**解决方案：**  
修改/etc/sysconfig/docker里的OPTIONS增加``--iptables=false``，重启docker服务，再启动redis，顺利开启。  


#### docker清理
清理没有使用的镜像和已经停止运行的容器
```sh
dcleanup(){
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}
```
[参考文档](https://codeday.me/bug/20170424/12279.html)