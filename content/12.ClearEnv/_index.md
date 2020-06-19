---
title: "清理环境 (可选)"
chapter: false
weight: 120
---

## 清理环境

完成所有实验以后，按照以下步骤清理环境：

1.清理DMS相关环境：

* 删除DMS任务，进入DMS任务控制台：https://cn-northwest-1.console.amazonaws.cn/dms/v2/home?region=cn-northwest-1#tasks

选中"dr-task"，在【操作】下拉菜单里选择"删除"选项。并在弹出窗口中点击【删除】按钮。

* 删除终端节点，在DMS终端节点控制台：https://cn-northwest-1.console.amazonaws.cn/dms/v2/home?region=cn-northwest-1#endpointList

选中source-db和target-db，在【操作】下拉菜单里选择"删除"选项。并在弹出窗口中点击【删除】按钮。
![](/images/CleanUp/deleteEndpoints.png)

2.在CloudEndure里，在Machines里，选中Wordpress APP，然后在Machime action里，选中"Remove 1 Machine From This Console"
![](/images/CleanUp/removeMachineFromCE.png)
在PROJECT ACTION里，选择"Delete Current Project"选项，删除wp-dr项目。

3.进入宁夏region的EC2控制台：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances;sort=launchTime:instanceState=running;sort=launchTime

依次选择界面上显示的每一个EC2，然后在【操作】下拉菜单里，选择"实例状态"，以及"终止"选项，并在弹出的对话框中，勾选"释放弹性IP"复选框，从而终止这台EC2。

进入安全组控制台，并找到CloudEndure配置的安全组：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#SecurityGroups:search=CloudEndure
在右上角的"Actions"下拉菜单里选择"Delete security group"选项，在弹出的窗口上，点击【Delete】按钮，从而删除该安全组。

5.进入宁夏region的CloudFormation console：https://cn-northwest-1.console.amazonaws.cn/cloudformation/home?region=cn-northwest-1#/stacks?filteringText=&filteringStatus=active&viewNested=true&hideStacks=false

选中alimigration堆栈，并点击【删除】按钮。在弹出窗口中，点击【删除堆栈】按钮。

6.删除名为"velero-s3-bucket-xxx"的S3 bucket里的文件以后，再把该bucket删除。以及删除"cf-templates"开头的bucket。

7.删除Key Pair。进入Key Pair控制台：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#KeyPairs:

选中"local-idc-key"，在【Actions】下拉菜单里，选择"Delete"选项，在弹出的窗口中，输入"delete"，并点击【Delete】按钮。

8.删除IAM用户：demouser。进入IAM user的控制台：https://console.amazonaws.cn/iam/home?region=cn-northwest-1#/users/demouser

点击【删除用户】按钮，并点击【是,删除】按钮。

9.删除IAM role：dms-vpc-role以及Cloudformation-Role角色。

10.删除多余的安全组：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#SecurityGroups:

11.删除EC2的快照：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Snapshots:sort=snapshotId

选中所有的快照，并在"操作"菜单里选择"删除"选项，在弹出的窗口里点击【是,删除】按钮。

12.删除多余的RDS快照。进入自动备份界面：https://console.amazonaws.cn/rds/home?region=cn-north-1#automatedbackups:

点击"Retained" tab页，选中wordpress自动备份，在"Actions"下拉菜单里选择"Delete"选项。在弹出窗口中，输入"delete me"，点击【删除】按钮。

13.进入宁夏region的CloudFormation console：https://cn-northwest-1.console.amazonaws.cn/cloudformation/home?region=cn-northwest-1#/stacks?filteringText=&filteringStatus=active&viewNested=true&hideStacks=false

选中Flink-Env堆栈，并点击【删除】按钮。在弹出窗口中，点击【删除堆栈】按钮。

14.进入宁夏region的EKS控制台，删除名为aliworkshop的集群。