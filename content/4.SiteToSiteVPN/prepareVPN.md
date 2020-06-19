---
title: "配置VPN之前的准备工作"
chapter: false
weight: 41
---

## 配置VPN之前的准备工作

本次实验中，先进行配置前的准备工作，如下所示：

 VPN信息 | 阿里云 | AWS |
| :------| :------ | :------ |
| VPC CIDR | 192.168.0.0/16 | 10.x.0.0/16 |
| VPN Instance Private IP | 192.168.x.x | 10.x.0.5 |
| VPN Instance Public IP | <填入阿里云实际的EIP> | <填入AWS实际的EIP> |

目前对公网IP，使用x和y代替，可以从创建好instance后获得。

1.登录到AWS上的EC2堡垒机，因为该堡垒机会同时作为VPN服务器，因此执行下面的命令，禁用source/destination检查。
```bash
export INST_ID=`curl http://169.254.169.254/latest/meta-data/instance-id`
aws ec2 modify-instance-attribute --instance-id $INST_ID --no-source-dest-check
```

2.确认AWS的VPN实例的安全组已经放行4500和500。打开EC2控制台：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances:search=BastionInstance;sort=launchTime

并找到堡垒机实例的安全组，并确认其入站规则已经放行4500和500

3.SSH登录到AWS的Linux堡垒机上，执行下面的命令，在阿里云上创建VPN服务器。注意这里的参数：

- HostName和InstanceName，建议带上你自己的姓名拼音，与其他用户创建的VPN服务器区分开。

- 其他参数不要修改，因为VSwitchID，Security Group ID等，都是事先已经创建好了。

```bash
INSTANCE_ID=`aliyun ecs CreateInstance \
  --RegionId cn-zhangjiakou \
  --ZoneId cn-zhangjiakou-a \
  --InstanceChargeType PostPaid \
  --IoOptimized optimized \
  --InstanceType ecs.t5-lc2m1.nano \
  --ImageId centos_8_0_x64_20G_alibase_20200218.vhd \
  --VSwitchId vsw-8vbwd1gubib8d2smt4etl \
  --InternetChargeType PayByTraffic \
  --InternetMaxBandwidthOut 50 \
  --SecurityGroupId sg-8vbcnwimxknppj8jbu50 \
  --HostName VPN-Server-你自己的姓名拼音 \
  --InstanceName VPN-Server-你自己的姓名拼音 \
  --SecurityEnhancementStrategy Deactive \
  --SystemDisk.Size 20 \
  --SystemDisk.Category cloud_efficiency \
  --KeyPairName aliworkshop--你的姓名拼音 | jq .InstanceId | sed 's/\"//g'`

sleep 5
aliyun ecs StartInstance --InstanceId $INSTANCE_ID
sleep 10
aliyun ecs AllocatePublicIpAddress --InstanceId $INSTANCE_ID
```

4.阿里云的VPN实例的安全组已经添加了相应的、针对500和4500端口的规则。另外，需要再执行下面的命令，把AWS的网段加入阿里云上所使用的安全组：
```bash
aliyun ecs AuthorizeSecurityGroup \
--RegionId cn-zhangjiakou \
--SecurityGroupId sg-8vbcnwimxknppj8jbu50 \
--IpProtocol all \
--PortRange='-1/-1' \
--SourceCidrIp 10.x.0.0/16 \
--Priority 1

aliyun ecs AuthorizeSecurityGroup \
--RegionId cn-zhangjiakou \
--SecurityGroupId sg-8vbcnwimxknppj8jbu50 \
--IpProtocol all \
--PortRange='-1/-1' \
--SourceCidrIp 10.x.0.0/16 \
--Priority 1
```

5.执行下面的命令，从而在阿里云的私有子网里添加一条路由条目，目标网段为AWS的VPC CIDR（10.x.0.0/16），下一跳为阿里云上的VPN虚拟机的实例id。
{{% notice note %}}
注意把这里的DestinationCidrBlock的参数值里的x替换为对应的编号。
{{% /notice  %}}

```bash
aliyun vpc CreateRouteEntry \
  --RegionId cn-zhangjiakou \
  --RouteTableId vtb-8vbkwbrxeern7wdgfg21x \
  --DestinationCidrBlock 10.x.0.0/16 \
  --NextHopId $INSTANCE_ID
```

6.AWS的路由已经在前面部署landing zone的时候配置完毕。

