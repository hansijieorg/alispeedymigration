---
title: "割接并发布应用服务器"
chapter: false
weight: 82
---
## 删除阿里云应用服务器上的Cloud-init
1.由于阿里云版的Cloud-init与AWS不兼容，会导致EC2开机时无法正常启用，频繁尝试访问http://100.100.100.200/latest/meta-data/，所以需要在正式割接时删除。

    sudo systemctl stop cloud-config.service
    sudo systemctl disable cloud-config.service
    sudo systemctl stop cloud-final.service
    sudo systemctl disable cloud-final.service
    sudo systemctl stop cloud-init-local.service
    sudo systemctl disable cloud-init-local.service
    sudo systemctl stop cloud-init-upgrade.service
    sudo systemctl disable cloud-init-upgrade.service
    sudo systemctl stop cloud-init.service
    sudo systemctl disable cloud-init.service
    #删除
    sudo rm /lib/systemd/system/cloud-final.service
    sudo rm /lib/systemd/system/cloud-config.service
    sudo rm /lib/systemd/system/cloud-config.target
    sudo rm /lib/systemd/system/cloud-init.service
    sudo rm /lib/systemd/system/cloud-init-upgrade.service
    sudo rm /lib/systemd/system/cloud-init-local.service

## 通过CloudEndure割接并发布应用服务器
2.进行系统割接时，按照在测试阶段制订好的切换计划和流程进行。
在CloudEndure Console上选择需要割接的机器，在Console右上角，选择Cutover Mode开始进行模式切换。
![](/images/Failover/cutovermode1.png)

3.等待几分钟后，通过阿里云上的用户名和key进行登录后测试,确保IP和大小和蓝图设置都一样。

![](/images/Failover/cutovermode2.png)

