---
title: "在阿里云上部署 MongoDB"
chapter: false
weight: 111
---

## 在阿里云上部署 MongoDB

本次实验会创建一个阿里云 MongoDB 数据库实例并写入测试数据。步骤如下：

1. 登录阿里云控制台：[https://signin.aliyun.com/login.htm](https://signin.aliyun.com/login.htm)

2. 新建阿里云托管 MongoDB
    
    * 打开印度 Region 的阿里云 MongoDB 购买链接：[https://common-buy.aliyun.com/dds/postpay?regionId=ap-south-1#/buy](https://common-buy.aliyun.com/dds/postpay?regionId=ap-south-1#/buy)
    
    * 在购买页面上：
               
        * “密码设置”选择“立即设置”输入密码：`Aliyun123`

        * 其他保留缺省值
        ![](/images/MongoDB2DocDB/CreateMongoDB1.png)
        
        * 点击【立即购买】按钮
        
        * 勾选 “云数据库MongoDB版服务协议”，点击【去开通】按钮
        ![](/images/MongoDB2DocDB/CreateMongoDB2.png)

        * 打开MongoDB控制台：[https://mongodb.console.aliyun.com/replicate/ap-south-1/instances](https://mongodb.console.aliyun.com/replicate/ap-south-1/instances)
        等实例运行状态变为“运行中”后，再继续下面的配置
        ![](/images/MongoDB2DocDB/MongoDBReady.png)

{{% notice note %}}
该环境准备的时间需要至少15分钟，为了节省时间，可以同步进行后续的实验。
{{% /notice  %}}

3.  配置 MongoDB 网络白名单
    
    * 打开 MongoDB 控制台：[https://mongodb.console.aliyun.com/replicate/ap-south-1/instances](https://mongodb.console.aliyun.com/replicate/ap-south-1/instances)  
    
    * 选择新建的实例
    ![](/images/MongoDB2DocDB/SelectMongoDB.png)
    
    * 点击左侧【数据安全 - 白名单设置】菜单，点击【添加白名单分组】按钮
        
        * “分组名”输入：`lab`
        
        * “允许访问IP名单”输入：`0.0.0.0/0`
        
        * 点击【确定】按钮
        ![](/images/MongoDB2DocDB/MongoDBWhitelist.png)

4.  配置 MongoDB 开启公网连接

    * 点击左侧【数据库连接】选项，在 公网连接 处点击【申请公网地址】按钮，点击【确定】按钮
    ![](/images/MongoDB2DocDB/MongoDBPublicApply.png)
    
    * 等公网连接创建完成后（需要几分钟时间），记录下 Primary 节点的地址
    ![](/images/MongoDB2DocDB/MongoDBPublicAccess.png)

5. 写入测试数据

    * 点击 数据库连接 右上角的【登录数据库】按钮，并选择 Primary
    ![](/images/MongoDB2DocDB/MongoDBConnect.png)
    
    * 在新的页面里，填入 MongoDB 登录信息，点击【登录】按钮
        
        * “数据库用户名”输入：`root`
        
        * “数据库名称”输入：`admin`
        
        * “密码”输入：`Aliyun123`
    ![](/images/MongoDB2DocDB/MongoDBLogin.png)

    * 登录后，在左侧菜单栏选择 数据库 - 系统库- admin，在【集合】处右键选择【创建集合】
    ![](/images/MongoDB2DocDB/MongoDBCollection1.png)

    * 创建集合页面，数据库名保持缺省的 admin，集合名输入: `aws`
    ![](/images/MongoDB2DocDB/MongoDBCollection2.png)

    * 创建完成后，会看到 admin 数据库下新增了一个 aws 的集合
    ![](/images/MongoDB2DocDB/MongoDBCollection3.png)
