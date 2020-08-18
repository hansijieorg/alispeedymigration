---
title: "部署 DocumentDB 数据库"
chapter: false
weight: 111
---

## 部署 Amazon DocumentDB 数据库

在 AWS 上创建一个 Amazon MongoDB 数据库集群。步骤如下：

1. 登录AWS控制台：[https://console.amazonaws.cn/console/home?region=ap-south-1](https://console.amazonaws.cn/console/home?region=ap-south-1) 把右侧滚动条拖到最底端，点击”English”链接，并选择”中文(简体)“选项。
![](/images/MongoDB2DocDB/AWSLoginChinese.png)

2. 打开印度 Region 的 DocumentDB 控制台，从而创建子网组：[https://ap-south-1.console.aws.amazon.com/docdb/home?region=ap-south-1#subnetGroup-create](https://ap-south-1.console.aws.amazon.com/docdb/home?region=ap-south-1#subnetGroup-create)

* 名称：aliworkshop-<你的姓名拼音>

* 描述：aliworkshop

* “添加子网”的部分，VPC下拉列表里，选择你所创建的VPC。注意，这里可能会看到多个VPC，确保要选中你所创建的VPC。然后点击【添加与此VPC相关的所有子网】按钮。

* 点击【创建】按钮。

3. 打开印度 Region 的 DocumentDB 控制台，从而创建documentdb实例：[https://ap-south-1.console.aws.amazon.com/docdb/home?region=ap-south-1#clusters](https://ap-south-1.console.aws.amazon.com/docdb/home?region=ap-south-1#clusters)

4. 点击【创建】按钮
    
    * 在创建 Amazon DocumentDB 集群界面上
        
        * “集群标识符”输入：`aws-docdb`
        
        * “实例的数量”选择：`1`
        
        * “主用户名”输入：`root`
        
        * “主密码”和“确认主密码”输入：`Initial-1`

        * 点击“显示高级设置”，在“网络设置”中：
        
            * 在Virtual Private Cloud (VPC)部分的下拉列表中，选择“ALIMIGRATIONVPC”
        
            * 在“VPC 安全组”下拉列表里选择SG-DMS。
        
        
        * 其他保留缺省值

        * 点击【创建集群】按钮

5. 点击创建好的集群，记录下 DocumentDB 的连接信息
    
    ![](/images/MongoDB2DocDB/ChooseDocdb.png)

    ![](/images/MongoDB2DocDB/DocdbConnectInfo.png)

