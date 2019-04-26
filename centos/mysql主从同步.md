[参考文档](https://www.cnblogs.com/baiyb/p/9306632.html)  
[参考文档](https://www.cnblogs.com/eleven24/p/7350000.html)  



数据库主从配置

Master: 172.17.0.7
Slave:  172.17.0.10



grant FILE on *.* to 'root'@'172.17.0.10' identified by 'yourpass';
grant replication slave on *.* to 'root'@'172.17.0.10' identified by 'yourpass';
flush privileges;

systemctl restart mysqld

show master status; 






log-bin=mysql-bin
server-id=2
replicate-ignore-db=information_schema
replicate-ignore-db=performance_schema
replicate-ignore-db=sys
replicate-ignore-db=mysql
replicate-do-db=test
log-slave-updates
slave-skip-errors=all
slave-net-timeout=60


change master to master_host='172.17.0.7', master_user='root',master_password='yourpass',master_file_log='log.000002',master_log_pos='154';
change master to master_host='172.17.0.7',master_user='root',master_password='yourpass',master_log_file='log.000003', master_log_pos=17125;