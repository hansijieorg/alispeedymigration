---
title: "配置CloudEndure并启动数据传输"
chapter: false
weight: 52
---

## 在CloudEndure上配置蓝图(Blueprint)

CloudEndure agent部署完毕以后，会发起初次全同步，可以在Console主界面的Machines里面查看数据同步的进程。 在CloudEndure的控制台上，点击左侧的Machine菜单选项，在右侧会看到服务器被发现， 同时看到"DATA REPLICATION PROGRESS"不断推进，这说明数据正在复制中，该复制过程可能会持续几分钟，最终会显示Continuous Data Protection的状态。
![](/images/SyncWithCloudEndure/installAgent3.png)

1.单击该虚拟机的名字，即可进入详情界面，进行Blueprint的设置。
也就是为该实例在AWS上的EC2实例配置信息，如实例类型、网络配置等等。对我们这里的项目来说，该EC2实例部署在名称包含ALIMIGRATIONPrivateSubnet的子网中，并指定实例类型为c5.large，磁盘为gp2。

Blueprint详细可配置的参数如下:

* Machine Type：启动后的主机类型，选择c5.large

* Launch Type：On-Demand

* Subnet：子网选择名称包含ALIMIGRATIONPrivateSubnet1的子网（注意可能会有多个名称包含ALIMIGRATIONPrivateSubnet1的子网，确保其对应的VPC ID是你创建的VPC）。

* Security Group：选择名称包含SG-WebServer的安全组

* Private IP：重新生成内网 IP，选 Create New

* Elastic IP：弹性 IP，选择 None

* Public IP：选择"According to subnet configuration"

* Placement Group：放置组，不是 HPC 等特殊应用无需调整，选择 None 即可

* IAM Role：为 EC2 挂载 IAM 角色，没有使用这个功能选 None 即可

* Use Existing Instance ID：留空

* Initial Target Status：迁移完毕拉起后是启动状态

* Tag：标签，设置 EC2 标签，如果要设置名称，注意首字母 Name 是大写N

* 磁盘类型，页面上默认是 io1，如果希望希望节约成本，选择其为 SSD 即可，代表 gp2 类型

确定以后，选择保存。如下图所示：
![](/images/SyncWithCloudEndure/blueprint1.png)
至此对蓝图配置完成。

2.等待一段时间后，当被复制的虚拟机的复制数据的进度达到100%，状态变为Continuous Data Replication，则完成存量数据的复制，进入变更复制阶段。此时可以启动EC2进行测试。在此阶段，需要确认迁移过后的EC2所必需的调整和配置，如：部分软件的升级、yum source、应用的重新配置等内容，并对最终的切换流程进行确认。如下图所示：

#### 启动测试模式
3.进入 CloudEndure 的 Machine 界面，点击首次全量数据复制完成的云服务器，可以看到左侧显示它的状态是“Never Tested”，且 Lag 是 None。这表示本虚拟机没有经过测试，另外持续数据复制是正常的，网络良好，没有延迟。
点击 Launch 按钮，在弹出的框中选择“Test Mode”，即可执行对虚拟机的转换并创建EC2实例。
![](/images/SyncWithCloudEndure/testmode1.png)

在弹出的测试环境的对话框中提示，一个迁移实例只能有一个测试环境，如果 此前曾经发起过测试，那么现在进入测试将自动删除掉以前的测试虚拟机。点击 Continue 继续。
![](/images/SyncWithCloudEndure/testmode2.png)

在点击了Continue按钮后，CloudEndure 将花费数分钟，从当前数据持续复制的状态中生成一个时间点，完成一份快照，然后将这个时间点的快照作为测试环境的系统盘，启动一个新的 EC2，交付测试。此时点击左侧的 Job Progress 按钮，即可看到系统后台的任务进行快照和虚拟机转换的进度。
![](/images/SyncWithCloudEndure/testmode3.png)

4.现在进入 AWS 控制台，选择本次迁移的目标区域宁夏区域，查看 EC2 清单， 可以看到有两台 EC2。名为 Replication Server 到实例会一直存在本 AWS 区域内，直到 CloudEndure 上的项目（Project）被删除。另一个实例叫做 Machine Converter，这个实例将用于从全量复制和增量复制的时间点生成磁盘快照。在环境启动完成后会自动把自己删除。
![](/images/SyncWithCloudEndure/testmode4.png)

5.等待数分钟，回到 CloudEndure 控制台，查看 Job Progress，确保通过快照生成测试环境的任务已经完成，如下截图。
![](/images/SyncWithCloudEndure/testmode5.png)

6.回到 AWS EC2 控制台，可以在 EC2 清单中看到，测试用的 EC2 实例也生成完毕，其规格、子网、EIP 配置都是咨询迁移过程的蓝图设置的,并且可以用阿里云上的用户名和key进行登录后测试，如下截图。
![](/images/SyncWithCloudEndure/testmode6.png)

7.当测试完毕，就可以等待“系统切换”时正式将应用服务器发布到宁夏Region。