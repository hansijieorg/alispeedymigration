---
title: "修改本地数据中心的数据"
chapter: false
weight: 81
---

## 修改本地数据中心的数据

本次实验，会在本地数据中心部署的Wordpress应用系统上进行操作，创建一篇新的博客。步骤如下：

1.在浏览器中输入http://阿里云wordpress应用服务器的公有IP地址/wordpress/

2.在Wordpress的主页上，找到并点击"登录"链接
![](/images/Failover/wphomepage.png)

输入用户名为：wpadmin

输入密码为：Initial-1

然后点击【登录】按钮，登录到Wordpress的管理页面。

3.在左边菜单中选择"文章"，在右边点击【写文章】按钮。
![](/images/Failover/addnewblog.png)

4.随意写些内容以后，点击【发布】按钮。并在主页上（http://SLB的公网IP地址/wordpress）能显示改新的文章。
![](/images/Failover/publishnewblog.png)

