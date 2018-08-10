常用Linux命令
---
### 1.查看cpu 
```
more /proc/cpuinfo 
grep "model name" /proc/cpuinfo 

查看CPU位数(32 or 64) 
getconf LONG_BIT 
```
### 2.查看硬盘和分区 
```
df -h 
fdisk -l 
也可以查看分区 
du -sh 
可以看到全部占用的空间 
du -shc *
这命令能在最后显示一个Total大小，即当前目录的总大小
du /etc -sh 
可以看到这个目录的大小 
```
### 3.显示近期用户或终端的登录 last
```
last命令的作用是显示近期用户或终端的登录情况，它的使用权限是所有用户。通过last命令查看该程序的log，
管理员可以获知谁曾经或企图连接系统。

2.格式


1. 1ast[—n][－f file][－t tty] [—h 节点][－I —IP][—1][－y][1D]  
3.主要参数

1. －n：指定输出记录的条数。  
2. －f file：指定用文件file作为查询用的log文件。  
3. －t tty：只显示指定的虚拟控制台上登录情况。  
4. －h 节点：只显示指定的节点上的登录情况。  
5. －i IP：只显示指定的IP上登录的情况。  
6. －1：用IP来显示远端地址。  
7. －y：显示记录的年、月、日。  
8. －ID：知道查询的用户名。  
9. －x:显示系统关闭、用户登录和退出的历史。 
```

### 4.查看进程 ps
```
显示瞬间行程 (process) 的动态 

 
 ps [options] [--help]   
参数 
 
1. -A ：所有的进程均显示出来，与 -e 具有同样的效用；  
2. -a ： 显示现行终端机下的所有进程，包括其他用户的进程；  
3. -u ：以用户为主的进程状态 ；  
4. x ：通常与 a 这个参数一起使用，可列出较完整信息  
5. -e 显示所有进程,环境变量  
6. -au 显示较详细的资讯  
7. -aux 显示所有包含其他使用者的进程  
8. 输出格式规划：  
9. l ：较长、较详细的将该 PID 的的信息列出；  
10. j ：工作的格式 (jobs format)  
11. -f ：全格式  
```
### 5.显示执行中的程序进程 top
```
top [－] [d delay] [q] [c] [S] [s] [i] [n]  

主要参数

d：指定更新的间隔，以秒计算。  
1. q：没有任何延迟的更新。如果使用者有超级用户，则top命令将会以最高的优先序执行。  
2. c：显示进程完整的路径与名称。  
3. S：累积模式，会将己完成或消失的子行程的CPU时间累积起来。  
4. s：安全模式。  
5. i：不显示任何闲置(Idle)或无用(Zombie)的行程。  
6. n：显示更新的次数，完成后将会退出top。  
说明
top命令是Linux系统管理的一个主要命令，通过它可以获得许多信息
```

### 6.mount 命令挂载磁盘
Linux/UNIX 命令行的 mount 指令是告诉操作系统，对应的文件系统已经准备好，可以使用了，而该文件系统会对应
到一个特定的点（称为挂载点）。挂载好的文件、目录、设备以及特殊文件即可提供用户使用。
```
sudo mount
```
![](https://dn-anything-about-doc.qbox.me/linux_base/7-10.png/logoblackfont)

```
输出的结果中每一行表示一个设备或虚拟设备,每一行最前面是设备名，然后是 on 后面是挂载点，type 后面表示文件
系统类型，再后面是挂载选项（比如可以在挂载时设定以只读方式挂载等等）。
那么我们如何挂载真正的磁盘到目录树呢，mount命令的一般格式如下：
mount [options] [source] [directory]
一些常用操作：
mount [-o [操作选项]] [-t 文件系统类型] [-w|--rw|--ro] [文件系统源] [挂载点]
我们现在直接来挂载我们创建的虚拟磁盘镜像到/mnt目录：
$ mount -o loop -t ext4 virtual.img /mnt 
# 也可以省略挂载类型，很多时候 mount 会自动识别

# 以只读方式挂载
$ mount -o loop --ro virtual.img /mnt
# 或者mount -o loop,ro virtual.img /mnt
```
### 7.使用 umount 命令卸载已挂载磁盘
```
# 命令格式 sudo umount 已挂载设备名或者挂载点，如：
$ sudo umount /mnt
```

### 8.top 显示执行中的程序进程
```
top命令用来显示执行中的程序进程，使用权限是所有用户。

格式

top [－] [d delay] [q] [c] [S] [s] [i] [n]  

主要参数

d：指定更新的间隔，以秒计算。  
1. q：没有任何延迟的更新。如果使用者有超级用户，则top命令将会以最高的优先序执行。  
2. c：显示进程完整的路径与名称。  
3. S：累积模式，会将己完成或消失的子行程的CPU时间累积起来。  
4. s：安全模式。  
5. i：不显示任何闲置(Idle)或无用(Zombie)的行程。  
6. n：显示更新的次数，完成后将会退出top。  
4.说明
top命令是Linux系统管理的一个主要命令，通过它可以获得许多信息
```

### 9.free 显示内存的使用情况
```
使用权限是所有用户。

2.格式

free [－b|－k|－m] [－o] [－s delay] [－t] [－V]  

3.主要参数
－b －k －m：分别以字节（KB、MB）为单位显示内存使用情况。  
1. －s delay：显示每隔多少秒数来显示一次内存使用情况。  
2. －t：显示内存总和列。  
3. －o：不显示缓冲区调节列。  

常用命令：
 free -m -s 2
```
### 9.显示nginx配置文件路径
```
nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

### 10.查找并删除文件
```sh
# 删除文件, . 表示从当前目录开始查找
find ./ -name '.DS_Store' | xargs rm

# 删除文件夹
find ./ -name '.DS_Store' | xargs rm -rf
```