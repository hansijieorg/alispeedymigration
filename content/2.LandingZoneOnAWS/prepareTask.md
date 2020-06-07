---
title: "部署Landing Zone前的准备工作"
chapter: false
weight: 21
---

## 部署Landing Zone前的准备工作

先进行如下的准备工作：

1.登录AWS控制台：https://console.amazonaws.cn/console/home?region=cn-north-1

把右侧滚动条拖到最底端，点击"English"链接，并选择"中文(简体)"选项。
![](/images/LandingZoneOfDRSite/enableChinese.png)

2.在宁夏region创建key pair。登录宁夏region的keypair控制台：https://console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#KeyPairs:

点击【Create key pair】
![](/images/LandingZoneOfDRSite/createKeyPair1.png)
在创建key pair界面上，指定"Name"为：target-ningxia-key，"File Format"为：pem。并点击【Create key pair】。
![](/images/LandingZoneOfDRSite/createKeyPair2.png)

在创建了key pair以后，会弹出下载key文件的窗口，把key pair文件下载到本地，并妥善保存。

{{% notice note %}}
key pair文件只有在第一次创建的时候才能下载，如果没有下载，则必须重新创建一个新的key paire文件。
{{% /notice  %}}

3.创建IAM用户。登录创建IAM用户的控制台：https://console.amazonaws.cn/iam/home?region=cn-northwest-1#/users$new?step=details

在"设置用户详细信息"页面上：

* 在"用户名"处输入：demouser

* 在"访问类型"处勾选"编程访问"
![](/images/LandingZoneOfDRSite/createUser1.png)

点击【下一步:权限】按钮。

在"设置权限"页面，选择"直接附加现有策略"，并在策略列表里勾选"AdministratorAccess"。
![](/images/LandingZoneOfDRSite/createUser2.png)

点击【下一步:标签】按钮。

在"添加标签 (可选)"页面，保留缺省值，点击【下一步:审核】按钮。
在"审核"页面，保留缺省值，点击【创建用户】按钮。
在用户创建完毕以后，点击【下载.csv】按钮，把该用户的access key和secret key下载下来。

{{% notice note %}}
包含IAM用户的access key和secret key的csv文件只有在第一次创建用户的时候才能下载，如果没有下载，则必须重新创建一个新的IAM用户。
{{% /notice  %}}

4.创建CloudFormation IAM role。进入创建IAM role的控制台：https://console.amazonaws.cn/iam/home?region=cn-northwest-1#/roles$new?step=type

选择"AWS产品"，在"或者选择一个服务以查看其使用案例"部分选择CloudFormation。点击【下一步:权限】按钮。
![](/images/LandingZoneOfDRSite/createCFRole1.png)

在"Attach权限策略"页面上，选择名为"AdministratorAccess"的策略。点击【下一步:标签】按钮。
![](/images/LandingZoneOfDRSite/createCFRole2.png)

在"添加标签 (可选)"页面上，保留缺省值，点击【下一步:审核】按钮。

在"创建角色"页面上，"角色名称"输入：Cloudformation-Role，点击【创建角色】按钮。
![](/images/LandingZoneOfDRSite/createCFRole3.png)

5.创建DMS IAM role。进入创建IAM role的控制台：https://console.amazonaws.cn/iam/home?region=cn-northwest-1#/roles$new?step=type

选择"AWS产品"，在"或者选择一个服务以查看其使用案例"部分选择DMS。点击【下一步:权限】按钮。
![](/images/LandingZoneOfDRSite/createDMSRole1.png)

在"Attach权限策略"页面上，选择名为"AmazonDMSVPCManagementRole"的策略。点击【下一步:标签】按钮。
![](/images/LandingZoneOfDRSite/createDMSRole2.png)

在"添加标签 (可选)"页面上，保留缺省值，点击【下一步:审核】按钮。

在"创建角色"页面上，"角色名称"输入：dms-vpc-role，点击【创建角色】按钮。
![](/images/LandingZoneOfDRSite/createDMSRole3.png)

