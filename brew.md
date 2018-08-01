brew
---
[官方网站](https://brew.sh/)

### Install
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### 常用命令
```sh
brew -h
brew update  # 更新brew

brew info app               # 查询app
brew info app@version       # 查询指定版本的app
brew upgrade app            # 更新app
brew install app            # 安装app
brew install app@version    # 安装指定版本的app

brew services list          # 查看已安装服务列表
brew services start app
brew services stop app
brew services restart app
```


### 更新国内镜像
中科大
```sh
# 替换brew.git:
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

# 替换homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

# 替换Homebrew Bottles源
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
```



重置官方镜像
```sh
# 重置brew.git:
cd "$(brew --repo)"
git remote set-url origin https://github.com/Homebrew/brew.git

# 重置homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://github.com/Homebrew/homebrew-core.git
```

[参考文档](https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git)  
[参考文档](https://www.jianshu.com/p/6523d3eee50d)  
[参考文档](https://blog.csdn.net/lwplwf/article/details/79097565)  