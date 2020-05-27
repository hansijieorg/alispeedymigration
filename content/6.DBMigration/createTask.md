---
title: "创建AWS DMS复制任务"
chapter: false
weight: 52
---

## 创建AWS DMS复制任务

创建AWS DMS复制任务的步骤如下：

1. 创建迁移任务：在左边菜单上选择【数据库迁移任务】菜单，然后在右边的界面上选择【创建任务】按钮。
![](/images/DataSyncWithDMS/createTask1.png)
在创建任务的界面上：

* "任务标识符"输入：dr-task

* "复制实例"下拉列表里选择：bcdrdms-vpc开头的实例

* "源数据库终端节点"下拉列表里选择：source-db

* "目标数据库终端节点"下拉列表里选择：target-db

* "迁移类型"下拉列表里选择：迁移现有数据并复制持续更改

* "表映像"里，点击"添加新选择规则"按钮：

  * 在"架构"下拉列表里选择：输入架构

  * 架构名称输入：wordpress

  * 其他保留缺省值

* 点击【创建任务】按钮

![](/images/DataSyncWithDMS/createTask2.png)
![](/images/DataSyncWithDMS/createTask3.png)

2.过一会，会看到该任务正常启动并复制数据。
![](/images/DataSyncWithDMS/createTask4.png)







