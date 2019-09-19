centos初始化配置
---

### Basic
```sh
yum update -y

# base
yum install zsh git lrzsz vim -y
yum install zsh wget tree git docker lrzsz unzip vim -y


# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh 推荐使用主题
# [user@hostname dirname]$ ...
# oh-my-zsh-theme: pygmalion
# line 9: replace('|', ' ')
# line 10: replace('=>', '➜')
# source ~/.zshrc
vim ~/.oh-my-zsh/themes/pygmalion.zsh-theme
:9s/|/ /
:10s/⇒/➜/
:wq

vim ~/.zshrc
:11s/ZSH_THEME="robbyrussell"/ZSH_THEME="pygmalion"
:wq

source ~/.zshrc