Service in docker
---

### Basic
```sh
yum update -y

# base
yum install zsh wget tree git docker lrzsz unzip vim -y
yum install zsh git docker lrzsz unzip vim -y

yum install zsh wget tree git lrzsz unzip vim -y


# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh 推荐使用主题
# [user@hostname dirname]$ ...
# oh-my-zsh-theme: pygmalion
# line 9: replace('|', ' ')
# line 10: replace('=>', '➜')
# source ~/.zshrc
vim ~/.oh-my-zsh/themes/pygmalion.zsh-theme
:9s/|/ /
:10s/⇒/➜/
:wq

vim ~/.zshrc
:11s/ZSH_THEME="robbyrussell"/ZSH_THEME="pygmalion"
:wq

source ~/.zshrc



# config docker
../docker/readme.md

# 下载centos镜像
docker pull centos

# 启动centos镜像
docker run -d --privileged --name <name> -p <port:port> <imageId> /usr/sbin/init

# 安装 service
yum list | grep initscripts  # 显示可安装软件的yum源版本
yum install -y initscripts  

yum provides '*/applydeltarpm'  
yum install deltarpm -y

```


### Docker.centos
```sh
yum install zsh wget tree git lrzsz openssh-server unzip vim -y

# install oh-my-zsh and set theme: gianu
```
[Mysql](../centos/mysql)  
[Redis](../centos/redis)  
[Mongodb](../centos/Mongodb)  