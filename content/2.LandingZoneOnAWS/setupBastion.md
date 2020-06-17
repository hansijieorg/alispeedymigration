---
title: "对堡垒机进行配置"
chapter: false
weight: 23
---

## 对堡垒机进行配置

在Landing Zone的CloudFormation脚本执行完毕以后，需要对堡垒机进行如下的配置：

1.进入EC2控制台：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances:search=BastionInstance;sort=launchTime

在界面上，找到名称为：BastionInstance的EC2，并找到其对应的公网ip地址。

2.使用准备阶段创建的target-ningxia-key密钥，SSH登录到该堡垒机，并运行下面的命令配置demouser的Access Key和Access Secret Key。
```bash
aws configure
```

输入以下内容：
AWS Access Key ID [None]: demouser的Access Key

AWS Secret Access Key [None]: demouser的Secret Key

Default region name [None]: cn-northwest-1

Default output format [None]: 

3.继续在堡垒机上，执行下面的命令配置阿里云RAM用户的Access Key和Secret Key：

```bash
aliyun configure
```

输入以下内容：

Access Key Id []: 分配给你的RAM用户的Access Key

Access Key Secret []: 分配给你的RAM用户的Secret Key

Default Region Id []: cn-zhangjiakou

Default Output Format [json]: json (Only support json))

Default Language [zh|en] en: en 


