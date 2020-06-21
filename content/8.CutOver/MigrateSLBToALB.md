---
title: "把阿里云的负载均衡器(SLB)迁移到AWS的ALB"
chapter: false
weight: 84
---

## 把阿里云的负载均衡器(SLB)迁移到AWS的ALB

在大型生产环境中，由于业务的需求，负载均衡器上往往配置了较多的转发规则。当用户进行迁移时，对规则的重建工作将是一项繁琐的工作。通过使用工具，以自动化的方式，将用户在阿里云上创建的负载均衡分发规则复制至AWS ALB之上。

本工具当前仅支持HTTP, HTTPS七层协议，对应AWS的负载均衡类型为应用负载均衡器(ALB)

具体操作步骤如下：

1.准备运行时环境

{{% notice note %}}
本次实验中，已经事先把所有需要用到的工具脚本下载到了堡垒机里。因此可以跳过该步骤，直接进行第2步：config.json文件的编辑。
如果是在其他环境中，可以按照下面的步骤进行运行时环境的准备工作。
{{% /notice  %}}

本工具需要使用Node.js 8.0及以上版本运行，首先将要安装Node.js运行时框架。

* SSH登录到AWS上的堡垒机，执行下面的命令下载Node.js 8.0:
```bash
wget https://nodejs.org/dist/v12.18.0/node-v12.18.0-linux-x64.tar.xz
tar -xvf node-v12.18.0-linux-x64.tar.xz
sudo mv node-v12.18.0-linux-x64 /usr/sbin/nodejs
sudo ln -s /usr/sbin/nodejs/bin/node /usr/local/bin/
sudo ln -s /usr/sbin/nodejs/bin/npm /usr/local/bin/
```

检查node版本和npm版本：
```bash
node --version
npm -version
```

如可以正确返回版本信息，即安装正确，如下图所示：
![](/images/Failover/512.png)

* 使用浏览器下载“https://github.com/liangfb/SLBRulestoALB/archive/V2.0.zip”，并进行解压缩，再上传到AWS的堡垒机上。
或者SSH登录到AWS上的堡垒机，执行下面的命令下载迁移工具：

```bash
wget http://<alb>:1313/8.CutOver/MigrateSLBToALB.files/SLBRulestoALB-2.0.zip
```

打开命令行工具，用cd命令进入到解压缩后的工具目录，运行命令，

```bash
unzip SLBRulestoALB-2.0.zip
cd ~/SLBRulestoALB-2.0
npm install
```

2.编辑配置文件：config.json

```bash
cd ~/SLBRulestoALB-2.0
vi config.json
```

- 配置Alicloud和AWS的AccessKey和SecretKey

- 配置Alicloud和AWS的Endpoint和区域信息

- 配置需要创建AWS Application Load Balancer的VPC和在不同可用区的最少两个公有子网

- 配置需要迁移的阿里云SLB：

- 填写阿里云上的SLB负载均衡Id

- 配置文件示例：

```bash
{
    "Alicloud":
    {
        "AccessKey": "分配给你的RAM用户的Access Key",
        "SecretKey": "分配给你的RAM用户的Secret Key",
        "Endpoint": "cn-zhangjiakou"                   //阿里云的区域
    },
    "AWS":
    {
        "AccessKey": "前面创建的demouser的Access Key",
        "SecretKey": "前面创建的demouser的Secret Key",
        "Region": "cn-northwest-1",                    //AWS区域
        "VPCId": "在部署Landing Zone时创建的VPC ID",    //ALB所在的VPC
        "Subnet":                                      //创建ALB所需要的最少两个在不同可用区的公有子网
        [
            "在部署Landing Zone时创建的公网子网1",
            "在部署Landing Zone时创建的公网子网2"
        ]
    },
    "SLB":                                             //要迁移的阿里SLB的实例ID列表
    [
        "SLB的实例ID"
    ]
}
```

3.运行工具进行迁移，登录到AWS删搞得堡垒机，运行下面的命令

```bash
cd ~/SLBRulestoALB-2.0/
node slb.js
```

该命令会输出已创建的ALB, Listener, Target Group, Rules信息，如下图所示：
![](/images/Failover/nodejsoutput.png)

* 在ELB控制台可以查看已创建的ALB相关资源：
![](/images/Failover/532.png)

{{% notice note %}}
迁移过来的ALB会使用default安全组，确保该安全组放行了80端口的流量。
{{% /notice  %}}

* 把CloudEndure的CutOver操作所部署的Wordpress EC2服务器添加至Target Group中，以完成所有步骤。
![](/images/Failover/531.png)



