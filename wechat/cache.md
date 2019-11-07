
禁止微信浏览器缓存网页
---
```
Cache-Control: no-cache：这个很容易让人产生误解，使人误以为是响应不被缓存。实际上Cache-Control: no-cache是会被缓存的，只不过每次在向客户端（浏览器）提供响应数据时，缓存都要向服务器评估缓存响应的有效性。

Cache-Control: no-store：这个才是响应不被缓存的意思。

Pragma: no-cache：跟Cache-Control: no-cache相同，Pragma: no-cache兼容http 1.0 ，Cache-Control: no-cache是http 1.1提供的。因此，Pragma: no-cache可以应用到http 1.0 和http 1.1,而Cache-Control: no-cache只能应用于http 1.1
```
[参考文档](https://blog.csdn.net/u010407050/article/details/43524057?utm_source=blogxgwz6)  
[参考文档](https://blog.csdn.net/zhang_zhenwei/article/details/90717864)  
[参考文档](https://blog.csdn.net/x356982611/article/details/81085980)  
