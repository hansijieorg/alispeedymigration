---
title: "使用CloudEndure对应用服务器进行容灾"
chapter: false
weight: 40
---

## 使用CloudEndure对应用服务器进行容灾

对于数据中心的Wordpress应用服务器的容灾部署来说，可以使用CloudEndure进行在线容灾，其过程如下所示：
![](/images/SyncWithCloudEndure/CE-workflow.png)

以下我们通过AWS位于北京区域的workdpress应用服务器模拟数据中心的生产服务器，容灾的目标位于AWS 宁夏区域，来配置数据同步的过程。

本次实验分为两部分：

* 在本地数据中心的应用服务器上部署agent

* 配置CloudEndure，进行数据同步





