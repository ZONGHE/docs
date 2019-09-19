Start
---

### 创建个人容器
```sh
# 1、主机配置docker映射目录
mkdir /data/apps
mkdir /data/logs
mkdir /data/apps/<username>
mkdir /data/logs/<username>

mkdir /data/apps/<username>/app
mkdir /data/apps/<username>/mysql
mkdir /data/apps/<username>/redis
mkdir /data/apps/<username>/redis2
mkdir /data/apps/<username>/mongo

mkdir /data/logs/<username>/app
mkdir /data/logs/<username>/mysql
mkdir /data/logs/<username>/redis
mkdir /data/logs/<username>/mongo

touch /data/logs/<username>/mysql/mysqld.log

# 2、启动docker实例
# 3、进入docker配置权限
cd /data/apps
chown -R mysql:mysql mysql
chown -R redis:redis redis
chown -R redis:redis redis2
chown -R mongod:mongod mongo

cd /data/logs
chown -R mysql:mysql mysql
chown -R redis:redis redis
chown -R mongod:mongod mongo

# 4、启动 fast-deploy
docker exec -it <your-cid> zsh
cd ~
cd lib/fast-deploy
npm start

# 5、设置数据库
# 5.1、mongodb创建用户
# 5.2、mysql允许远程连接
# 5.3、redis都在配置中，所以无需单独设置

SET PASSWORD FOR 'root'@'localhost' = PASSWORD('Lincoapp@2018');

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Lincoapp@2018' WITH GRANT OPTION;
FLUSH PRIVILEGES;

use admin
db.createUser({
    user: 'root',
    pwd: 'lincoapp#018',
    roles: [
        {
            role: 'root',
            db: 'admin'
        }
    ]
})
db.auth('root','lincoapp#018')

# 更新密码
# db.updateUser('root', {pwd: 'yourpassword'})


### Nginx解析
```

### 修改
```sh
# 启动源 所有环境更新都在这里进行
docker run -d --privileged \
--name gavinning2 \
-p 9800:8585 \
-p 9801:3306 \
-p 9802:6379 \
-p 9803:27017 \
-p 9804:6380 \
-p 9805:9097 \
-p 9806:8081 \
-p 9807:9807 \
-p 9808:9808 \
-p 9809:9809 \
-v /data/apps/gavinning2:/data/apps \
-v /data/logs/gavinning2:/data/logs \
--restart unless-stopped \
98c569ae8caa \
/usr/sbin/init

docker exec -it <cid> zsh
```

### 张中原
```sh
docker run -d --privileged \
--name zzy \
-p 10000:8585 \
-p 10001:3306 \
-p 10002:6379 \
-p 10003:27017 \
-p 10004:6380 \
-p 10005:9097 \
-p 10006:8081 \
-p 10007:10007 \
-p 10008:10008 \
-p 10009:10009 \
-v /data/apps/zzy:/data/apps \
-v /data/logs/zzy:/data/logs \
--restart unless-stopped \
30b3bb1458fc \
/usr/sbin/init
```
### 黄凌鹏
```sh
docker run -d --privileged \
--name lemon \
-p 10010:8585 \
-p 10011:3306 \
-p 10012:6379 \
-p 10013:27017 \
-p 10014:6380 \
-p 10015:9097 \
-p 10016:8081 \
-p 10017:10017 \
-p 10018:10018 \
-p 10019:10019 \
-v /data/apps/lemon:/data/apps \
-v /data/logs/lemon:/data/logs \
--restart unless-stopped \
98c569ae8caa \
/usr/sbin/init

### 智能分享图定时任务 推荐按需添加
*/5 * * * * NODE_ENV=development /root/n/bin/node /data/apps/app/share-service/crontab/weightRunner.js >> /data/logs/app/share-service-weight-runner.log 2>&1
```

### 毛超博
```sh
docker run -d --privileged \
--name mcb \
-p 10020:8585 \
-p 10021:3306 \
-p 10022:6379 \
-p 10023:27017 \
-p 10024:6380 \
-p 10025:9097 \
-p 10026:8081 \
-p 10027:10027 \
-p 10028:10028 \
-p 10029:10029 \
-v /data/apps/mcb:/data/apps \
-v /data/logs/mcb:/data/logs \
--restart unless-stopped \
da9c1c119f69 \
/usr/sbin/init
```


### 郑昊泽
```sh
docker run -d --privileged \
--name tiger \
-p 10030:8585 \
-p 10031:3306 \
-p 10032:6379 \
-p 10033:27017 \
-p 10034:6380 \
-p 10035:9097 \
-p 10036:8081 \
-p 10037:10037 \
-p 10038:10038 \
-p 10039:10039 \
-v /data/apps/tiger:/data/apps \
-v /data/logs/tiger:/data/logs \
--restart unless-stopped \
98c569ae8caa \
/usr/sbin/init
```


### 大白
```sh
docker run -d --privileged \
--name dabai \
-p 10040:8585 \
-p 10041:3306 \
-p 10042:6379 \
-p 10043:27017 \
-p 10044:6380 \
-p 10045:9099 \
-p 10046:10046 \
-p 10047:10047 \
-p 10048:10048 \
-p 10049:10049 \
-v /data/apps/dabai:/data/apps \
-v /data/logs/dabai:/data/logs \
--restart unless-stopped \
98c569ae8caa \
/usr/sbin/init
```


### test1 ~ 20010-20019
```sh
docker run -d --privileged \
--name test1 \
-p 20010:8585 \
-p 20011:3306 \
-p 20012:6379 \
-p 20013:27017 \
-p 20014:6380 \
-p 20015:9097 \
-p 20016:8081 \
-p 20017:20017 \
-p 20018:20018 \
-p 20019:20019 \
-v /data/apps/test1:/data/apps \
-v /data/logs/test1:/data/logs \
--restart unless-stopped \
98c569ae8caa \
/usr/sbin/init
```

### test2 ~ 20020-20029
```sh
docker run -d --privileged \
--name test2 \
-p 20020:8585 \
-p 20021:3306 \
-p 20022:6379 \
-p 20023:27017 \
-p 20024:6380 \
-p 20025:9097 \
-p 20026:8081 \
-p 20027:20027 \
-p 20028:20028 \
-p 20029:20029 \
-v /data/apps/test2:/data/apps \
-v /data/logs/test2:/data/logs \
--restart unless-stopped \
98c569ae8caa \
/usr/sbin/init
```

### test3 ~ 20030-20039
```sh
docker run -d --privileged \
--name test3 \
-p 20030:8585 \
-p 20031:3306 \
-p 20032:6379 \
-p 20033:27017 \
-p 20034:6380 \
-p 20035:9097 \
-p 20036:8081 \
-p 20037:20037 \
-p 20038:20038 \
-p 20039:20039 \
-v /data/apps/test3:/data/apps \
-v /data/logs/test3:/data/logs \
--restart unless-stopped \
98c569ae8caa \
/usr/sbin/init
```


### 自定义 docker ps 模板
```sh
docker ps --format "table {{.ID}}        {{.Image}}        {{.Status}}          {{.Names}}"
```

### 启动个人docker环境
```sh
docker run -d --privileged \
--name <username> \
-p 10000:8081 \
-p 10001:3306 \
-p 10002:6379 \
-p 10003:27017 \
-v /data:/data
-v /home/work/apps/<username>:/root/app
--restart unless-stopped \
<imageId> \
/usr/sbin/init
```

### 存活测试
```sh
curl 127.0.0.1:10000 -I
curl 127.0.0.1:10001 -I
curl 127.0.0.1:10002 -I
curl 127.0.0.1:10003 -I
```

### 远程连接测试
```sh
# redis
redis-cli -h gavinning.share.imissmiss.cn -p 9702

# mysql
mysql -h 10.211.55.4 -P 10001 -uroot -p

# mongodb
mongo 10.211.55.4:10003
```


### 主机与docker目录对应关系
```sh
-v /data/apps/<username>:/data/apps
-v /data/logs/<username>:/data/logs
```