https
---
Nginx in centos7


```nginx.conf
server {
    listen 443 ssl http2 default_server;
    server_name ilinco.com;
    access_log /data/logs/nginx/ilinco.com.log access;
    error_log /data/logs/nginx/ilinco.com.error.log info;

    ssl_certificate "/etc/nginx/conf.d/keys/ilinco.com.crt";
    ssl_certificate_key "/etc/nginx/conf.d/keys/ilinco.com.key";

    location / {
        proxy_pass http://localhost:10045;
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Referer $http_referer;
    }
}

server {
    listen 80;
    server_name ilinco.com;
    rewrite ^(.*)$  https://$host$1 permanent;
}
```