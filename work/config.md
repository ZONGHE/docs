### Mysql
```sh
# 配置mysql
mysql --host 127.0.0.1 -uroot

use mysql
# 查询是否已设置远程连接账户
select host, user, password from user;

# 设置允许远程连接账户
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

### Mongo
```sh
mongo

use admin
show dbs
show users
db.createUser({
    user: 'root',
    pwd: 'password',
    roles: [
        {
            role: 'root',
            db: 'admin'
        }
    ]
})
db.auth('root','password')

use test
db.createUser({
    user: 'root',
    pwd: 'password',
    roles: [
        {
            role: 'root',
            db: 'admin'
        }
    ]
})

exit
```


### Fast-deploy
```
cd ~/lib/fast-deploy
npm start
```