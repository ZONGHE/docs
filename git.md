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
git cherry-pick <B:commit-hash>
```