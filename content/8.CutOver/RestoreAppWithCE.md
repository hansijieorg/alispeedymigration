---
title: "通过CloudEndure切换应用服务器"
chapter: false
weight: 82
---

## 通过CloudEndure切换应用服务器
找一个合适的时间点，使用CloudEndure对应用服务器进行切换。通过以下步骤进行切换：

1.修改阿里云应用服务器上的Cloud-init。由于阿里云版的Cloud-init中会访问阿里云的Metadata服务，即频繁尝试访问：http://100.100.100.200/latest/meta-data/ 。如下图所示。
![](/images/Failover/updatecloudinit.png)

如果不修改的话，直接迁移到AWS平台，会与AWS的metadata服务( http://169.254.169.254 )不同，导致EC2开机启动时间过长，且无法初始化EC2信息，所以需要在正式割接时修改为AWS的metadata服务。

SSH登录到阿里云Wordpress应用服务器，修改/etc/cloud/cloud.cfg配置，将datasource_list: [ AliYun ]修改为datasource_list: [ Ec2, None ]

```bash
sed -i "s/\[\ AliYun\ \]/\[\ Ec2\,\ None\ \]/g" /etc/cloud/cloud.cfg
```

2.通过CloudEndure切换应用服务器。进行系统切换的时候，按照在测试阶段制订好的切换计划和流程完成整个切换过程。
在CloudEndure Console上选择需要切换的机器，在Console右上角，选择Cutover Mode开始进行模式切换。
![](/images/Failover/cutovermode1.png)

3.等待几分钟后，使用root用户和aliworkshop密钥对进行登录后测试。
