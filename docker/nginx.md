```sh
docker pull nginx:1.15.6-alpine

# start
docker run \
--rm \
--name nginx \
-p 80:80 \
-v /home/gavinning/nginx:/etc/nginx \
-v /home/gavinning/html:/usr/share/nginx/html \
-dit d3dcc25e0dc4 ash


docker run \
--rm \
--name nginx \
-p 80:80 \
-v /root/html:/usr/share/nginx/html \
-d nginx
```




docker run \
--name nginx \
-d -p 80:80 \
-v /root/html:/usr/share/nginx/html \
-v /root/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
-v /root/nginx/conf.d:/etc/nginx/conf.d \
nginx
