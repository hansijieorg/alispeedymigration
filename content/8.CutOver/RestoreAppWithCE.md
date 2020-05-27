---
title: "启动容灾环境中的应用服务器"
chapter: false
weight: 82
---

## 通过CloudEndure把容灾环境的应用服务器启动起来

本次实验，会把容灾环境里的应用服务器启动起来。步骤如下：

1.配置蓝图(Blueprint)。到CloudEndure主界面，选择左边的Machines菜单选项，点击名为"WordPress APP"服务器，进入 Blueprint（蓝图）界面设置目标实例的配置信息：

* "Machine Type"中选择目标实例的类型，可以选择各种实例类型，或者选择复制源端的实例类型；这里选择c5.large。
* "Launch Type"中选择实例类型，这里保留缺省：On Demand。
* "Subnet"选择名为BCDRVPC里的名为DMZ subnet的子网。
* "Security Groups"选择名为WebServerSecurityGroup的安全组。
* "Private IP"选择"Create new"。
* "Elastic IP"选择"Create new"。
* 其余选项保留缺省值

![](/images/Failover/CloudEndureBlueprint.png)

2.完成蓝图的配置后，选择需要切换测试的机器，在Console右上角，选择Test Mode开始进行测试模式切换。
![](/images/Failover/testmode1.png)

3.在弹出的窗口上选择【NEXT】按钮，然后系统会跳出一个菜单让你选择恢复时间点。
CloudEndure在做连续数据复制时，会保留"Latest"即最近的恢复时间点，在正常情况下和源端的数据状态相同或存在毫秒级的RPO。
同时，CloudEndure也会保留最近一个小时的每10分钟、最近一天的每24小时、最近一个月的每一天等数据恢复时间点。
做容灾演练或者在源端发生服务器宕机、机房损毁等情况时，通常选择"Latest"时间点恢复容灾实例。
当发生数据误删除、服务器中病毒等情况，你可能会需要选择某一个时间点恢复服务器。
在这里，我们选择"Latest"，并点击【CONTINUE WITH LAUNCH】按钮。
![](/images/Failover/testmode2.png)

4.此时，CloudEndure会在AWS宁夏区域启动一台容灾服务器示例。你可以通过点击主界面左边的Job Progress菜单选项查看任务执行的状态。测试过程大约需要5分钟左右。
![](/images/Failover/testmode3.png)

5.测试模式切换完成后，AWS宁夏区域会出现一台目标实例，接下来就可以对目标实例进行验证。
如果需要调整蓝图，可以再次启动测试模式的切换，新产生的目标实例会覆盖上一次的目标实例（即终止原来的实例）。
这样，经过多次的调整蓝图和启动测试模式切换，直到你确认可以执行最终的切换。在CloudEndure console上，会显示"Tested Recently"的状态。
![](/images/Failover/testmode4.png)

6.当测试完毕，就可以进行系统切换，按照在测试阶段制订好的切换计划和流程进行。
停止生产端的应用，在CloudEndure Console上选择需要切换测试的机器，在Console右上角，选择Recovery Mode开始进行模式切换。
![](/images/Failover/recoverymode1.png)
在弹出的窗口上点击【NEXT】按钮，然后系统会跳出一个菜单让你选择恢复时间点。在这里，我们选择"Latest"，并点击【CONTINUE WITH LAUNCH】按钮。
你可以通过点击主界面左边的Job Progress菜单选项查看任务执行的状态。大约需要7分钟完成切换。

7.切换完成后，CloudEndure console上显示Failed Over的状态。此时，应用服务器在容灾站点运行。
![](/images/Failover/recoverymode2.png)

打开宁夏region的EC2控制台，并确认在容灾端启动的EC2的状态：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances:tag:Name=APP;sort=launchTime


