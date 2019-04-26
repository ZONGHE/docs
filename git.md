git
---
常用命令

```sh

git push origin -d BranchName  # 删除远程分支
```


#### git cherry-pick合并某个commit
把``B``分支的commit添加到``A``
```
git checkout A
git cherry-pick <B-commit-hash>
```


#### 批量清理无效远程分支
```sh
# 查看哪些本地远程分支会被清理
git remote prune origin --dry-run
# 执行清理本地无效的远程分支
git remote prune origin
```


#### 清空git仓库所有提交历史
[删除git项目所有提交历史，使其成为一个新仓库](https://blog.csdn.net/wkzd2016/article/details/80639539)

https://www.cnblogs.com/weilantiankong/p/9155026.html