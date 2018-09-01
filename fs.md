文件操作
---


### 分包压缩及解压
linux大文件分包压缩和批量解压命令tar
```sh
# 分包压缩 source 可以是文件也可以是目录，单位：b、k、m
tar czf - source | split -b 1024m - target.tar.gz_

# 解压分包
cat target.tar.gz_* | tar zvxf -
# or
cat target.tar.gz_* > target.tar.gz
tar zvxf target.tar.gz
```
[参考文档](https://blog.csdn.net/a5nan/article/details/51275631)

### 大文件分块
linux文件分割（将大的日志文件分割成小的）
```sh
# 分割文件
split -l 300 source.txt new_file_prefix

# 合并文件
cat small_files* > large_file
```
[参考文档](https://www.cnblogs.com/waynechen/archive/2010/07/26/1785097.html)
