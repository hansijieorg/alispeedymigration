---
title: "割接并发布应用服务器"
chapter: false
weight: 82
---
## 修改阿里云应用服务器上的Cloud-init
1.由于阿里云版的Cloud-init中会访问阿里云的Metadata服务，即频繁尝试访问http://100.100.100.200/latest/meta-data/，这与AWS的metadata服务(http://169.254.169.254)不同，会导致EC2开机启动时间过长，且无法初始化EC2信息，所以需要在正式割接时修改为AWS的。

修改/etc/cloud/cloud.cfg配置，将datasource_list: [ AliYun ]修改为datasource_list: [ Ec2, None ]

    sed -e "s/\[\ AliYun\ \]/\[\ Ec2\,\ None\ \]/g" /etc/cloud/cloud.cfg

![](/images/Failover/updatecloudinit.png)

## 通过CloudEndure割接并发布应用服务器
2.进行系统割接时，按照在测试阶段制订好的切换计划和流程进行。
在CloudEndure Console上选择需要割接的机器，在Console右上角，选择Cutover Mode开始进行模式切换。
![](/images/Failover/cutovermode1.png)

3.等待几分钟后，通过阿里云上的用户名和key进行登录后测试,确保IP和大小和蓝图设置都一样。

![](/images/Failover/cutovermode2.png)

