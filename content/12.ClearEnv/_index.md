---
title: "清理环境 (可选)"
chapter: false
weight: 120
---

## 清理环境

完成所有实验以后，按照以下步骤清理环境：

1.清理DMS相关环境：

* 删除DMS任务，进入DMS任务控制台：https://cn-northwest-1.console.amazonaws.cn/dms/v2/home?region=cn-northwest-1#tasks

选中"ali-migration-task"，在【操作】下拉菜单里选择"删除"选项。并在弹出窗口中点击【删除】按钮。

* 删除终端节点，在DMS终端节点控制台：https://cn-northwest-1.console.amazonaws.cn/dms/v2/home?region=cn-northwest-1#endpointList

选中source-db和target-db，在【操作】下拉菜单里选择"删除"选项。并在弹出窗口中点击【删除】按钮。
![](/images/CleanUp/deleteEndpoints.png)

2.在CloudEndure里，在Machines里，选中Wordpress APP，然后在Machime action里，选中"Remove 1 Machine From This Console"
![](/images/CleanUp/removeMachineFromCE.png)
在PROJECT ACTION里，选择"Delete Current Project"选项，删除wp-dr项目。

3.进入宁夏region的EC2控制台：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances;sort=launchTime:search=WP-Server,CloudEndure;sort=launchTime

依次选择界面上显示的每一个EC2，然后在【操作】下拉菜单里，选择"实例状态"，以及"终止"选项，并在弹出的对话框中，勾选"释放弹性IP"复选框，从而终止这台EC2。

进入安全组控制台，并找到CloudEndure配置的安全组：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#SecurityGroups:search=CloudEndure
在右上角的"Actions"下拉菜单里选择"Delete security group"选项，在弹出的窗口上，点击【Delete】按钮，从而删除该安全组。

4.进入宁夏region的负载均衡器控制台：https://cn-northwest-1.console.amazonaws.cn/ec2/home?region=cn-northwest-1#LoadBalancers:search=LB-30;sort=loadBalancerName

删除LB-30开头的负载均衡器，以及对应的target group。

5.删除EKS实验中创建的负载均衡器以及target group。

6.登录到AWS的堡垒机，删除阿里云上的ECS和RDS：
```bash
##删除wordpress应用服务器
WP_INSTANCES=`aliyun ecs DescribeInstances \
--RegionId cn-zhangjiakou \
--InstanceName='*WP*你的姓名拼音' \
| jq .Instances \
| jq .Instance \
| jq .[0] \
| jq .InstanceId \
| sed 's/\"//g'`

aliyun ecs DeleteInstance \
--InstanceId $WP_INSTANCES \
--Force true

##删除VPN服务器
VPN_INSTANCES=`aliyun ecs DescribeInstances \
--RegionId cn-zhangjiakou \
--InstanceName='*VPN*你的姓名拼音' \
| jq .Instances \
| jq .Instance \
| jq .[0] \
| jq .InstanceId \
| sed 's/\"//g'`

aliyun ecs DeleteInstance \
--InstanceId $VPN_INSTANCES \
--Force true
```

使用下面的命令找到你创建的RDS的实例ID
```bash
aliyun rds DescribeDBInstanceByTags \
--RegionId cn-zhangjiakou \
| jq .Items \
| jq .DBInstanceTag
```

然后执行下面的命令删除RDS：
```bash
aliyun rds DeleteDBInstance \
--DBInstanceId 你的实例ID
```
执行下面的命令删除SLB：
```bash
SLBID=`aliyun slb DescribeLoadBalancers \
--RegionId cn-zhangjiakou \
--LoadBalancerName='wp-slb-你的姓名拼音' \
| jq .LoadBalancers \
| jq .LoadBalancer \
| jq .[0] \
| jq .LoadBalancerId \
| sed 's/\"//g'`

aliyun slb DeleteLoadBalancer \
--RegionId cn-zhangjiakou \
--LoadBalancerId $SLBID
```

6.删除EKS集群：
```bash
eksctl delete cluster --name=aliworkshop --wait
```

删除名为aliworkshop的ECR镜像仓库：
```bash
aws ecr delete-repository --repository-name aliworkshop --force
```

7.进入宁夏region的CloudFormation console：https://cn-northwest-1.console.amazonaws.cn/cloudformation/home?region=cn-northwest-1#/stacks?filteringText=&filteringStatus=active&viewNested=true&hideStacks=false

选中Flink-Env堆栈，并点击【删除】按钮。在弹出窗口中，点击【删除堆栈】按钮。
选中alimigration堆栈，并点击【删除】按钮。在弹出窗口中，点击【删除堆栈】按钮。

8.删除名为"velero-s3-bucket-xxx"的S3 bucket里的文件以后，再把该bucket删除。以及删除"cf-templates"开头的bucket。

9.删除Key Pair。进入Key Pair控制台：https://console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#KeyPairs:

选中"target-ningxia-key"，在【Actions】下拉菜单里，选择"Delete"选项，在弹出的窗口中，输入"delete"，并点击【Delete】按钮。

10.删除IAM用户：demouser。进入IAM user的控制台：https://console.amazonaws.cn/iam/home?region=cn-northwest-1#/users/demouser

点击【删除用户】按钮，并点击【是,删除】按钮。

11.删除IAM role：dms-vpc-role以及Cloudformation-Role角色。

12.删除多余的安全组：https://console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#SecurityGroups:

13.删除CloudEndure生成的EC2快照：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Snapshots:visibility=owned-by-me;search=cloudendure;sort=snapshotId

选中要删除的快照，并在"操作"菜单里选择"删除"选项，在弹出的窗口里点击【是,删除】按钮。

14.删除多余的RDS快照。进入自动备份界面：https://console.amazonaws.cn/rds/home?region=cn-northwest-1#automatedbackups:

点击"Retained" tab页，选中wordpress自动备份，在"Actions"下拉菜单里选择"Delete"选项。在弹出窗口中，输入"delete me"，点击【删除】按钮。
