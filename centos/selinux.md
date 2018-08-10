SELinux
---

Nginx、php-fpm 环境配置  出现dedecms无法配置写权限可能是selinux的原因，本地测试环境关闭即可解决，但selinux是非常重要的安全机制，所以生产环境不建议关闭


临时关闭selinux 
```sh
setenforce 0
```

永久关闭selinux 
```sh
vi /etc/selinux/config 
SELINUX=disabled
```

重启服务器