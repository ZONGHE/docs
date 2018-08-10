Nginx
---

#### Nginx禁止IP直接访问服务器设置
建议新建配置文件``aaa.conf``拦截所有默认访问  
返回500
```nginx
server { 
	listen 80 default; 
	server_name _; 
	return 500; 
}
```
或者收集流量跳转到指定的网站
```nginx
server { 
	listen 80 dufault; 
	server_name _; 
	rewrite ^(.*) http://www.aitushuo.com permanent; 
}
```
[参考文档](http://www.jb51.net/article/93756.htm)