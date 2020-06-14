---
title: "通过Cloudformation脚本部署相关资源"
chapter: false
weight: 22
---

## 通过Cloudformation脚本部署相关资源

本次实验通过Cloudformation脚本部署整个Landing Zone的环境，该脚本会创建VPC、子网、安全组、RDS实例、以及DMS复制实例。

### 阿里云的VPC 
VPC CIDR: 192.168.0.0/16

### VPC和子网的信息如下

{{% notice note %}}
这里因为不同的用户，使用的是同一套阿里云上的源环境，因此迁移的目标环境的网段需要区分开。
所以不同的用户，会被分配一个不同的编号，比如0，1，2，3等。下面的"x"就是分配给你的编号。
{{% /notice  %}}


VPC CIDR: 10.x.0.0/16

subnet CIDR: 

10.x.0.0/24    -->   公有子网1

10.x.32.0/24   -->   公有子网2

10.x.64.0/24   -->   私有子网1

10.x.96.0/24   -->   私有子网2

### 安全组：

安全组一：
1. Ingress all 10.x.0.0/16
2. Ingress all 192.168.0.0/16 - 阿里云的内网网段

安全组二：
1. Ingress 3389 0.0.0.0/0

安全组三：数据库
1. Ingress 3389 192.168.0.0/16

安全组四：SGBastionVPN
1. Ingress 22 0.0.0.0/0
2. Ingress udp 500 0.0.0.0/0
2. Ingress udp 4500 0.0.0.0/0


### DMS Replication Instance

### Database

1. RDS Mysql
2. utf8 编码
3. 安全组三

### 堡垒机兼工作服务器

1. 内网IP：10.x.0.5
2. cloudformation创建时指定keypair
3. 需要设置它的安全组，绑定阿里云的openvpn ecs的公网IP
4. 查询EC2的public IP：aws ec2 describe-instances --filters Name=tag:Name,Values=BastionVPNInstance --query 'Reservations[].Instances[].PublicIpAddress'


## 调用该脚本的过程如下：

1.下载CloudFormation脚本到本地电脑。
{{%attachments title="下载链接:" /%}}

2.进入宁夏region的Cloudformation界面：https://cn-northwest-1.console.amazonaws.cn/cloudformation/home?region=cn-northwest-1

3.点击【创建堆栈】按钮
![](/images/LandingZoneOfDRSite/CreateStack.png)

4.在"指定模板"部分的"模板源"处，指定为"上传模板文件"，点击【选择文件】按钮，然后选中之前下载的workshop_target.yaml文件。点击【下一步】。
![](/images/LandingZoneOfDRSite/createStackStep1.png)

5.在堆栈详细信息处输入如下信息，点击【下一步】

* 堆栈名称输入：alimigration

* DBName输入：wordpressdb

* DBPassword输入：Initial-1

* DBUser输入：root

* SubnetCidr1：把缺省值中的第二个0换成对应你的编号（10.x.0.0/24）

* SubnetCidr1：把缺省值中的第二个0换成对应你的编号（10.x.64.0/24）

* VpcCidr：把缺省值中的第二个0换成对应你的编号（10.x.0.0/16）

* Keypair：选择预先创建的Keypair：target-ningxia-key

* EC2InstancePrivateIP: EC2堡垒机实例的私有IP地址，把缺省值中的第二个0换成对应你的编号（10.x.0.5）

![](/images/LandingZoneOfDRSite/createStackStep2.png)

6.在"配置堆栈选项"的权限部分，"IAM角色名称"处，在下拉列表里选择角色：Cloudformation-Role。其他保留缺省值，点击【下一步】。
![](/images/LandingZoneOfDRSite/createStackStep3.png)

7.在"审核"页面中，保留缺省值，点击【创建堆栈】。等待堆栈创建完毕。整个过程大约需要11分钟。

{{% notice note %}}
如果要进行应用系统从Blink迁移到Flink的实验，因为该环境准备的时间需要至少15分钟，为了节省时间，建议先进行[Blink的开发环境准备]({{< ref "10.BlinkToFlink/1.preparation.md" >}})，
然后在CloudFormation脚本部署Blink开发环境的过程中，可以同步进行后续的实验。
{{% /notice  %}}
