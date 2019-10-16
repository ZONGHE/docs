在Ubuntu中安装完系统后，可以直接使用apt-get install build-essential命令安装常用的开发编译工具包。在诸如CentOS这样的使用Yum包管理的系统中，其实也有类似的实现方法。解决方案是使用如下命令：

yum groupinstall "Development Tools"