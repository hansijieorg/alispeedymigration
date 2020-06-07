---
title: "对堡垒机进行配置"
chapter: false
weight: 23
---

## 对堡垒机进行配置

在Landing Zone的CloudFormation脚本执行完毕以后，需要对堡垒机进行如下的配置：

1.进入EC2控制台：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances:search=BastionInstance;sort=launchTime

在界面上，找到名称为：BastionInstance的EC2，并找到其对应的公网ip地址。

2.SSH登录到该堡垒机，并配置demouser的Access Key和Access Secret Key。

