---
title: "配置VPN之前的准备工作"
chapter: false
weight: 31
---

## 配置VPN之前的准备工作

本次实验中，先进行配置前的准备工作，如下所示：

 左对齐标题 | 阿里云 | AWS |
| :------| :------ | :------ |
| VPC CIDR | 192.168.0.0/16 | 10.0.0.0/16 |
| VPN Instance Private IP | 192.168.0.5 | 10.0.0.5 |
| VPN Instance Public IP | <填入阿里云实际的EIP> | <填入AWS实际的EIP> |

公网IP后期创建好instance后获得，目前用x和y代替。

1. 登录到AWS上的EC2堡垒机，因为该堡垒机会同时作为VPN服务器，因此执行下面的命令，禁用source/destination检查。
```bash
export INST_ID=`curl http://169.254.169.254/latest/meta-data/instance-id`
aws ec2 modify-instance-attribute --instance-id $INST_ID --no-source-dest-check
```

2. 确认AWS的VPN实例的安全组已经放行4500和500。打开EC2控制台：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances:search=BastionInstance;sort=launchTime

并找到堡垒机实例的安全组，并查看其入站规则，如下图所示：
![](/images/VPNBetweenAWSAndAli/SGonVPNEC2.png)

3. 阿里云的VPN实例的操作系统为Centos 8.0，不要选安全加固。

4. 为阿里云的VPN实例的安全组添加下图所示的规则：
- Ingress udp 500 0.0.0.0/0
- Ingress udp 4500 0.0.0.0/0

5. 在阿里云的私有子网里添加一条路由条目，目标网段为AWS的VPC CIDR（10.0.0.0/16），下一跳为阿里云上的VPN虚拟机的实例id

6. AWS的路由已经在前面部署landing zone的时候配置好了

