mysql
---
centos

对数据库的更改
---

#### ALL
```sql
-- 查看命令
show columns from dede_archives;

-- 修改缩略图字段数据类型，解决OSS路径超长的问题
alter table dede_archives modify column litpic text;


-- 修改标题字段字段长度，解决标题过长时显示不完整的问题
alter table dede_archives modify column title varchar(255);
```

[参考文档](https://www.cnblogs.com/chinesern/p/8440206.html)