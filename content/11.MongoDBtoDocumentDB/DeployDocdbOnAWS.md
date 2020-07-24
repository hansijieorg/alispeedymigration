---
title: "部署 DocumentDB 数据库"
chapter: false
weight: 112
---

## 部署 Amazon DocumentDB 数据库

在 AWS 上创建一个 Amazon MongoDB 数据库集群。步骤如下：

1. 登录AWS控制台：[https://console.amazonaws.cn/console/home?region=ap-south-1](https://console.amazonaws.cn/console/home?region=ap-south-1) 把右侧滚动条拖到最底端，点击”English”链接，并选择”中文(简体)“选项。
![](/images/MongoDB2DocDB/AWSLoginChinese.png)

2. 打开印度 Region 的 DocumentDB 控制台：[https://ap-south-1.console.aws.amazon.com/docdb/home?region=ap-south-1#clusters](https://ap-south-1.console.aws.amazon.com/docdb/home?region=ap-south-1#clusters)

2. 点击【创建】按钮
    
    * 在创建 Amazon DocumentDB 集群界面上
        
        * “集群标识符”输入：`aws-docdb`
        
        * “实例的数量”选择：`1`
        
        * “主用户名”输入：`root`
        
        * “主密码”和“确认主密码”输入：`Awsaws123`

        * 其他保留缺省值
        ![](/images/MongoDB2DocDB/CreateDocdb.png)

        * 点击【创建集群】按钮

2. 点击创建好的集群，记录下 DocumentDB 的连接信息
    
    ![](/images/MongoDB2DocDB/ChooseDocdb.png)

    ![](/images/MongoDB2DocDB/DocdbConnectInfo.png)

