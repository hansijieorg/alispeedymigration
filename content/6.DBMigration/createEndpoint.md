---
title: "创建AWS DMS终端节点"
chapter: false
weight: 51
---

## 创建AWS DMS终端节点

创建AWS DMS终端节点的步骤如下：

1.打开宁夏region的DMS console：https://cn-northwest-1.console.amazonaws.cn/dms/v2/home?region=cn-northwest-1#replicationInstances

找到通过Landing Zone的CloudFormation脚本创建的DMS复制实例，如下图所示。
![](/images/DataSyncWithDMS/selectDMSInstance.png)

2.创建源终端节点：在左边菜单上选择【终端节点】菜单，然后在右边的界面上选择【创建终端节点】按钮。
![](/images/DataSyncWithDMS/selectCreateEndpoint.png)
在创建终端节点的界面上：

* 选择"源终端节点"

* "终端节点标识符"输入：source-db

* "源引擎"选择：mysql

* "服务器名称"输入之前所获得的阿里云RDS的连接字符串。

* "端口"输入：3306

* "用户名"输入：root

* "密码"输入：Initial-1

其他保留缺省值，然后选择【创建终端节点】按钮。
![](/images/DataSyncWithDMS/createSourceEndpoint1.png)

3.创建目标终端节点：在左边菜单上选择【终端节点】菜单，然后在右边的界面上选择【创建终端节点】按钮。
在创建终端节点的界面上：

* 选择"目标终端节点"

* 选择"选择 RDS 数据库实例"复选框

* 在"RDS 实例"下拉列表里选择：wordpress，有关该数据库的信息会自动填如相关字段

* "终端节点标识符"输入：target-db

* "密码"输入：Initial-1

其他保留缺省值，然后选择【创建终端节点】按钮。
![](/images/DataSyncWithDMS/createTargetEndpoint1.png)
![](/images/DataSyncWithDMS/createTargetEndpoint2.png)

4.测试终端节点是否能正常连接数据库：
选择source-db，在【操作】下拉框里选择【测试连接】
![](/images/DataSyncWithDMS/testSourceEndpoint1.png)
在界面上选择【运行测试】按钮，看到状态为successful以后，点击【返回】按钮
![](/images/DataSyncWithDMS/testSourceEndpoint2.png)

选择target-db，在【操作】下拉框里选择【测试连接】
![](/images/DataSyncWithDMS/testTargetEndpoint1.png)
在界面上选择【运行测试】按钮，看到状态为successful以后，点击【返回】按钮
![](/images/DataSyncWithDMS/testTargetEndpoint2.png)

