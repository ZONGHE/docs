Mysql
---
mysql in docker


### Install
```sh
docker pull hub.c.163.com/library/mysql:latest
```

### Usage
```sh
# 启动mysql
docker run --name mysql -p 12345:3306 -e MYSQL_ROOT_PASSWORD=password -d imageId

# 连接 mysql 容器
docker exec -it mysql bash

# 挂在数据到本地
docker run --name mysql -p 12345:3306 \
-v $DOCKER_RUNTIME/mysql/data:/var/lib/mysql \
-v $DOCKER_RUNTIME/mysql/conf:/etc/mysql/conf.d \
-d imageId
```