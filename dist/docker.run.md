```sh

docker run -d --privileged \
--name ssr \
-p 8888:8888 \
-p 10000:10000 \
-p 10001:10001 \
-p 10002:10002 \
-p 10003:10003 \
-p 10004:10004 \
-p 10005:10005 \
76fdd9a55ca9 \
/usr/sbin/init


docker run -d --privileged \
--name vps \
-p 888:888 \
-p 8888:8888 \
-p 1025:1025 \
-p 10000:10000 \
-p 10001:10001 \
-p 10002:10002 \
-p 10003:10003 \
-p 10004:10004 \
-p 10005:10005 \
34c5fd57c40c \
/usr/sbin/init


```