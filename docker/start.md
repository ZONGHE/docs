```sh
docker run -d --privileged \
--name demo \
-p 10000-20000:10000-20000 \
-v /data/apps/test1:/data/apps \
-v /data/logs/test1:/data/logs \
--restart unless-stopped \
98c569ae8caa \
/usr/sbin/init
```

docker run -d --privileged \
--name centos \
-p 10000-10100:10000-10100 \
--restart unless-stopped \
5182e96772bf \
/usr/sbin/init






<!-- Only for test -->
docker run -d --privileged \
--name centos \
--restart unless-stopped \
0cb4fb73950e \
/usr/sbin/init

docker run -di --name pinyougou_mysql -p 33306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql
