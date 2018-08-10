Google authenticator
---
OTP二次身份认证 For Centos6.x


### 1、安装依赖
```sh
yum install gcc git pam-devel libpng-devel libtool
```

### 2、安装 google authenticator
```sh
cd /opt
git clone https://github.com/google/google-authenticator-libpam.git
cd google-authenticator-libpam
./bootstrap.sh
./configure
make
[sudo] make install

# 安装时可能不会自动复制，需要手动执行以下命令
cp /usr/local/lib/security/pam_google_authenticator.so /lib64/security/
```

### 3、配置 SSH
```sh
vim /etc/pam.d/sshd
```
在第一行添加如下代码, SSH调用Google authenticator
```
# Google authenticator
auth required pam_google_authenticator.so no_increment_hotp
```

接下来再修改ssh的配置文件
```sh
vim /etc/ssh/sshd_config
```
找到
```
UsePAM no
ChallengeResponseAuthentication no
```
修改为
```
UsePAM yes
ChallengeResponseAuthentication yes
```

重启SSH服务
```sh
service sshd restart
```

### 4、使用 google authenticator
为某个用户新增google authenticator双重认证的时候需要首先切换到该用户
```sh
# 切换到用户liming 为liming启用google authenticator双重认证
su liming    
```
运行``google-authenticator``生成google-authenticator配置
```sh
# 执行命令 生成google-authenticator配置
google-authenticator 

# 是否开始使用
Do you want authentication tokens to be time-based (y/n) y

# 打开此网址可以获得需要扫描的二维码，扫这个二维码绑定手机端身份认证app
https://www.google.com/chart?chs=200x200&chld=M|0&cht=qr&chl=otpauth://totp/AD2C2SY4Y2BK7EIJ%3Fsecret%3D7RX6O7Q7AXYPJNHO

# 或者手动输入这个key
Your new secret key is: 7RX6O7Q7AXYPJNHO
Your verification code is 093599

# 备用密匙，每个只能使用一次，谨慎保管
Your emergency scratch codes are:
  97632952
  24402162
  85433022
  49344079
  65373589

# 是否将密匙信息存储到下面路径文件中
Do you want me to update your "/root/.google_authenticator" file (y/n) y

# 是否禁止一个口令多次使用
Do you want to disallow multiple uses of the same authentication
token? This restricts you to one login about every 30s, but it increases
your chances to notice or even prevent man-in-the-middle attacks (y/n) y

# 由于服务器与客户端时间误差，是否允许口令有效期为4分钟
By default, tokens are good for 30 seconds and in order to compensate for
possible time-skew between the client and the server, we allow an extra
token before and after the current time. If you experience problems with poor
time synchronization, you can increase the window from its default
size of 1:30min to about 4min. Do you want to do so (y/n) n

# 为了安全是否只允许重试3次
If the computer that you are logging into isn't hardened against brute-force
login attempts, you can enable rate-limiting for the authentication module.
By default, this limits attackers to no more than 3 login attempts every 30s.
Do you want to enable rate-limiting (y/n) y
```


### 手机客户端下载
iOS
```
https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8
```
Android
```
https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2
```

### github
```
https://github.com/google/google-authenticator.git
https://github.com/google/google-authenticator-libpam.git
```
