---
title: "部署容灾环境的Landing Zone"
chapter: false
weight: 20
---

## 部署容灾环境的Landing Zone

本次实验会在AWS宁夏region部署容灾环境的基础架构，部署过程中，会在AWS Landing Zone的理念下，以符合AWS最佳实践的方式部署基础架构。本次实验包括两部分：

* 通过Cloudformation脚本部署相关资源。

* 把本地数据中心的网络和容灾环境的网络打通。

先进行如下的准备工作：

1.创建DMS IAM role。进入创建IAM role的控制台：https://console.amazonaws.cn/iam/home?region=cn-northwest-1#/roles$new?step=type

选择"AWS产品"，在"或者选择一个服务以查看其使用案例"部分选择DMS。点击【下一步:权限】按钮。
![](/images/LandingZoneOfDRSite/createDMSRole1.png)

在"Attach权限策略"页面上，选择名为"AmazonDMSVPCManagementRole"的策略。点击【下一步:标签】按钮。
![](/images/LandingZoneOfDRSite/createDMSRole2.png)

在"添加标签 (可选)"页面上，保留缺省值，点击【下一步:审核】按钮。

在"创建角色"页面上，"角色名称"输入：dms-vpc-role，点击【创建角色】按钮。
![](/images/LandingZoneOfDRSite/createDMSRole3.png)


