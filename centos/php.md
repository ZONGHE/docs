PHP
---
[参考文档](http://blog.csdn.net/seanchan/article/details/7680354)

### Install php
```sh
yum install php php-devel
yum install php-gd php-mysql php-mbstring php-xml php-mcrypt
```

### Nginx
Nginx的安装 参考 readme.md

配置Nginx与PHP-FPM协作，像下面这样编辑取消注释
```sh
...  
location / {  
    root   /usr/share/nginx/html;  
    index  index.html index.htm index.php;  
}  
...  
location ~ \.php$ {  
    root           /usr/share/nginx/html;  # 替换为你的路径
    fastcgi_pass   127.0.0.1:9000;  
    fastcgi_index  index.php;  
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;  
    include        fastcgi_params;  
}  
...  
```


### Install php-fpm
```sh
yum search php-fpm
yum install php-fpm.x86_64
```

```sh
/etc/init.d/php-fpm restart  
```

开机启动php-fpm
```sh
chkconfig --level 345 php-fpm on  
```

现在在document root目录下建立下列PHP文件
```sh
vim /usr/share/nginx/html/info.php  
```
文件内容如下：
```php
<?php  
phpinfo();  
?>
```
