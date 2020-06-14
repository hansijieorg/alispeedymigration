---
title: "使用CloudEndure对应用服务器进行迁移"
chapter: false
weight: 50
---

## 使用CloudEndure对应用服务器进行迁移

对于从阿里云迁移到AWS 宁夏区域来说，可以通过使用CloudEndure完成迁移，其过程如下所示：
![](/images/SyncWithCloudEndure/CE-workflow-ali.png)

我们在阿里云上部署了wordpress应用，模拟需要迁移的应用服务器，容灾的目标位于AWS 宁夏区域，来配置应用服务器迁移的过程。

本次实验中，我们会进行如下的操作：

* 在阿里云应用服务器上部署agent

* 配置CloudEndure并启动数据同步，目标为AWS宁夏区域。





