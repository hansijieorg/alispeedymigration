---
title: "通过Cloudformation脚本部署相关资源"
chapter: false
weight: 21
---

## 通过Cloudformation脚本部署相关资源

本次实验通过Cloudformation脚本部署整个Landing Zone的环境，该脚本会创建VPC、子网、安全组、RDS实例、以及DMS复制实例。
VPC和子网的信息如下：

VPC CIDR: 192.168.0.0/24

subnet CIDR: 

192.168.0.0/26   -->   公有子网

192.168.0.64/26  -->   私有子网

调用该脚本的过程如下：

1.下载CloudFormation脚本到本地电脑。
{{%attachments title="下载链接:" /%}}

2.进入宁夏region的Cloudformation界面：https://cn-northwest-1.console.amazonaws.cn/cloudformation/home?region=cn-northwest-1

3.点击【创建堆栈】按钮
![](/images/LandingZoneOfDRSite/CreateStack.png)

4.在"指定模板"部分的"模板源"处，指定为"上传模板文件"，点击【选择文件】按钮，然后选中之前下载的workshop_target.yaml文件。点击【下一步】。
![](/images/LandingZoneOfDRSite/createStackStep1.png)

5.在堆栈详细信息处输入如下信息，点击【下一步】

* 堆栈名称输入：dr-site

* DBName输入：wordpressdb

* DBPassword输入：Initial-1

* DBUser输入：root

* SubnetCidr1保留缺省值：192.168.0.0/26

* SubnetCidr1保留缺省值：192.168.0.64/26

* VpcCidr保留缺省值：192.168.0.0/24
![](/images/LandingZoneOfDRSite/createStackStep2.png)

6.在"配置堆栈选项"的权限部分，"IAM角色名称"处，在下拉列表里选择角色：Cloudformation-Role。其他保留缺省值，点击【下一步】。
![](/images/LandingZoneOfDRSite/createStackStep3.png)

7.在"审核"页面中，保留缺省值，点击【创建堆栈】。等待堆栈创建完毕。整个过程大约需要10分钟。

