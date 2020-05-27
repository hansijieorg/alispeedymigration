---
title: "配置CloudEndure"
chapter: false
weight: 42
---

## agent部署完毕后在CloudEndure上的配置

CloudEndure agent部署完毕以后，会发起初次全同步，可以在Console主界面的Machines里面查看数据同步的进程。
在CloudEndure的控制台上，点击左侧的Machine菜单选项，在右侧会看到名称为"WordPress APP"的服务器出现，
同时看到"DATA REPLICATION PROGRESS"不断推进，这说明数据正在复制中，该复制过程可能会持续几分钟，最终会显示Continuous Data Protection的状态。
![](/images/SyncWithCloudEndure/CEReplicationProgress.png)

同时，在AWS宁夏区域里会出现一台名称为"CloudEndure Replication Server"开头的复制服务器实例。
https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances:search=Cloud;sort=launchTime

在等待CloudEndure完成初次全同步的过程中，可以同步继续进行后面的实验。
