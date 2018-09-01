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

docker run \
--name mysql \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=123456 \
-v /data/apps/mysql:/var/lib/mysql \
-d mysql:5.7.23 \
--character-set-server=utf8mb4 \
--collation-server=utf8mb4_unicode_ci

# 连接 mysql 容器
docker exec -it mysql bash

# 挂在数据到本地
docker run --name mysql -p 12345:3306 \
-v $DOCKER_RUNTIME/mysql/data:/var/lib/mysql \
-v $DOCKER_RUNTIME/mysql/conf:/etc/mysql/conf.d \
-d imageId
```
