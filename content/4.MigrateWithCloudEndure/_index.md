---
title: "使用CloudEndure对应用服务器进行迁移"
chapter: false
weight: 40
---

## 使用CloudEndure对应用服务器进行迁移

对于从阿里云迁移到AWS 宁夏区域来说，可以通过使用CloudEndure 容灾的方式，其过程如下所示：
![](/images/SyncWithCloudEndure/CE-workflow-ali.png)

以下我们通过AWS位于北京区域的workdpress应用服务器模拟阿里云的生产服务器，容灾的目标位于AWS 宁夏区域，来配置数据同步的过程。

本次实验中，我们会进行如下的操作：

* 在模拟的阿里云应用服务器上部署agent

* 配置CloudEndure并启动数据同步，目标为AWS 宁夏区域。





