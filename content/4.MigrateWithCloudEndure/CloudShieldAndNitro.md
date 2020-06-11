---
title: "卸载安骑士并安装Nitro驱动"
chapter: false
weight: 42
---

## 卸载云盾/安骑士
1.登录云盾服务器安全（安骑士）管理控制台，单击左侧导航栏设置 > 安装/卸载 。如下图所示。
![](/images/SyncWithCloudEndure/uninstallcloudshield1.png)

2.在“请选择对应的服务器”的区域找到属于你的阿里云应用服务器 ，勾选并点击确认。如下图所示。
![](/images/SyncWithCloudEndure/uninstallcloudshield2.png)

3.刷新页面，直至未安装安骑士的虚拟机出现在列表中。如下图所示。
![](/images/SyncWithCloudEndure/uninstallcloudshield3.png)


## 安装Nitro驱动
1.本次实验涉及到的应用服务器为CentOS，已安装过Nitro驱动，实际迁移中，Cloudendure仅会为Windows自动安装Nitro驱动，Linux请安装Nitro驱动。

2.下载并运行AWS Nitro检查脚本nitro_check_script.sh
https://github.com/awslabs/aws-support-tools/tree/master/EC2/NitroInstanceChecks

    chmod +x nitro_check_script.sh
    ./nitro_check_script.sh

3.如下图所示则说明检查通过。如遇到无ENA驱动，参考此文章进行安装：
https://aws.amazon.com/cn/premiumsupport/knowledge-center/install-ena-driver-rhel-ec2/
![](/images/SyncWithCloudEndure/checknitro.png)