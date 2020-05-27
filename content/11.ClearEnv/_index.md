---
title: "清理环境 (可选)"
chapter: false
weight: 110
---

## 清理环境

完成所有实验以后，按照以下步骤清理环境：

1.清理DMS相关环境：

* 删除DMS任务，进入DMS任务控制台：https://cn-northwest-1.console.amazonaws.cn/dms/v2/home?region=cn-northwest-1#tasks

选中"dr-task"，在【操作】下拉菜单里选择"删除"选项。并在弹出窗口中点击【删除】按钮。

* 删除终端节点，在DMS终端节点控制台：https://cn-northwest-1.console.amazonaws.cn/dms/v2/home?region=cn-northwest-1#endpointList

选中source-db和target-db，在【操作】下拉菜单里选择"删除"选项。并在弹出窗口中点击【删除】按钮。
![](/images/CleanUp/deleteEndpoints.png)

2.删除Storage Gateway：

* 在xshell里，分别双击"local-idc-env"和"remote-aws-env"，从而进入本地数据中心的虚拟机以及AWS的容灾端的虚拟机里，执行下面的命令：
```bash
cd ~/
sudo umount /mnt
```

* 进入storage gateway的文件共享控制台：https://console.amazonaws.cn/storagegateway/home/file-shares?region=cn-north-1

选中文件共享，并在"操作"下拉菜单里选择"删除文件共享"。选中"勾选此框以确认删除以下资源"复选框，点击【删除】按钮。

* 进入storage gateway的网关控制台：https://console.amazonaws.cn/storagegateway/home/gateways?region=cn-north-1

选中名为"backup-filegw"的网关，在【操作】下拉菜单里选择"删除网关"选项。选中"勾选此框以确认删除以下资源"复选框，点击【删除】按钮。

* 进入EC2的控制台，找到Filegateway的EC2实例：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#Instances:search=Filegateway;sort=launchTime

在【操作】下拉菜单里选择"实例状态"选项，并选择"终止"选项。并在弹出窗口中选择【是,请终止】按钮。
![](/images/CleanUp/deleteStorageGWEC2.png)

然后找到该实例对应的安全组，其名称为"Filegateway-EC2"：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#SecurityGroups:search=Filegateway-EC2;sort=group-id

在右上角的"Actions"下拉菜单里，选择"Delete security group"选项，并在弹出的窗口上，点击【Delete】按钮，从而删除该安全组。
![](/images/CleanUp/deleteFileGW-SG.png)

* 删除Storage Gateway所使用的Endpoint。进入VPC终端节点控制台：https://console.amazonaws.cn/vpc/home?region=cn-north-1#Endpoints:sort=vpcEndpointId

依次选中每个VPC终端节点，在"操作"下拉菜单里选择"删除终端节点"选项，并在弹出的窗口里点击【是,删除】按钮。
![](/images/CleanUp/deleteVPCEndpoint1.png)

然后删除storage gateway endpoint所使用的安全组，通过控制台找到对应的安全组：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#SecurityGroups:search=storagegateway

选中该名称为"storagegateway-VPC-Endpoint"的安全组，在"Actions"下来菜单里，选择"Delete security group"选项，并在弹出的窗口上，点击【Delete】按钮，删除该安全组。

2.删除VPC对等连接：vpc-peering。进入北京region的VPC Peering控制台：https://console.amazonaws.cn/vpc/home?region=cn-north-1#PeeringConnections:sort=vpcPeeringConnectionId

选中VPC Peering，然后在【操作】下拉菜单里，选择"删除VPC对等连接"选项。
在弹出的窗口中，选择"删除相关路由表条目"复选框，然后点击【是,删除】按钮。
![](/images/CleanUp/deleteVPCPeering1.png)

然后进入宁夏region的VPC Peering控制台：https://cn-northwest-1.console.amazonaws.cn/vpc/home?region=cn-northwest-1#RouteTables:sort=routeTableId

选中"显式关联对象"列为"2个子网"的路由表
![](/images/CleanUp/deleteVPCPeering2.png)

并编辑该路由表，把标记为"blackhole"的路由条目删除，然后点击【保存路由】按钮。
![](/images/CleanUp/deleteVPCPeering3.png)

3.在CloudEndure里，在Machines里，选中Wordpress APP，然后在Machime action里，选中"Remove 1 Machine From This Console"
![](/images/CleanUp/removeMachineFromCE.png)
在PROJECT ACTION里，选择"Delete Current Project"选项，删除wp-dr项目。

4.进入宁夏region的EC2控制台：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances;sort=launchTime:instanceState=running;sort=launchTime

依次选择界面上显示的每一个EC2，然后在【操作】下拉菜单里，选择"实例状态"，以及"终止"选项，并在弹出的对话框中，勾选"释放弹性IP"复选框，从而终止这台EC2。

进入安全组控制台，并找到CloudEndure配置的安全组：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#SecurityGroups:search=CloudEndure
在右上角的"Actions"下拉菜单里选择"Delete security group"选项，在弹出的窗口上，点击【Delete】按钮，从而删除该安全组。

5.进入宁夏region的CloudFormation console：https://cn-northwest-1.console.amazonaws.cn/cloudformation/home?region=cn-northwest-1#/stacks?filteringText=&filteringStatus=active&viewNested=true&hideStacks=false

选中dr-site堆栈，并点击【删除】按钮。在弹出窗口中，点击【删除堆栈】按钮。

6.进入北京region的CloudFormation console：https://console.amazonaws.cn/cloudformation/home?region=cn-north-1#/stacks?filteringText=&filteringStatus=active&viewNested=true&hideStacks=false

选中local-idc-env堆栈，并点击【删除】按钮。在弹出窗口中，点击【删除堆栈】按钮。

7.删除名为"storagegateway-coldbackup-xxx"的S3 bucket里的文件以后，再把该bucket删除。以及删除"cf-templates"开头的bucket。

8.删除Key Pair。进入Key Pair控制台：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#KeyPairs:

选中"local-idc-key"，在【Actions】下拉菜单里，选择"Delete"选项，在弹出的窗口中，输入"delete"，并点击【Delete】按钮。

9.删除IAM用户：demouser。进入IAM user的控制台：https://console.amazonaws.cn/iam/home?region=cn-northwest-1#/users/demouser

点击【删除用户】按钮，并点击【是,删除】按钮。

10.删除IAM role：dms-vpc-role、Cloudformation-Role以及StorageGateway开头的角色。

11.删除多余的EBS卷：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#Volumes:sort=desc:createTime

选中Filegateway产生的卷，在"操作"菜单下，选中"删除卷"，在弹出的窗口中点击【是,删除】按钮。

12.删除多余的安全组：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#SecurityGroups:

13.删除EC2的快照：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Snapshots:sort=snapshotId

选中所有的快照，并在"操作"菜单里选择"删除"选项，在弹出的窗口里点击【是,删除】按钮。

14.删除多余的策略：https://console.amazonaws.cn/iam/home?region=cn-northwest-1#/policies

在"筛选策略"里输入"allowstorage"，如以下截图示例：
![](/images/CleanUp/deletePolicy.png)

依次选中每个策略，在"策略操作"下拉菜单里，选中"删除"按钮，并在弹出窗口里点击【删除】按钮。

15.删除多余的RDS快照。进入自动备份界面：https://console.amazonaws.cn/rds/home?region=cn-north-1#automatedbackups:

点击"Retained" tab页，选中wordpress自动备份，在"Actions"下拉菜单里选择"Delete"选项。在弹出窗口中，输入"delete me"，点击【删除】按钮。
