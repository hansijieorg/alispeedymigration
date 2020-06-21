---
title: "创建应用服务器以及负载均衡器"
chapter: false
weight: 31
---

## 在阿里云上部署Wordpress应用服务器

在本实验中，在阿里云上部署应用服务器以及负载均衡器。步骤如下：

1.在阿里云上创建key pair，建议在key的名称里带上你自己的姓名拼音：
```bash
aliyun ecs CreateKeyPair \
--RegionId cn-zhangjiakou \
--KeyPairName aliworkshop-你的姓名拼音 \
| jq .PrivateKeyBody \
| sed 's/\"//g' \
| sed 's/\\n/\n/g' > ~/aliworkshop-你的姓名拼音.pem
chmod 400 ~/aliworkshop-你的姓名拼音.pem
```

确认生成了名为"aliworkshop-你的姓名拼音.pem"的keypair文件。

2.SSH登录到位于AWS的堡垒机里，执行下面的命令创建Wordpress应用服务器。注意这里的参数：

- HostName和InstanceName，建议带上你自己的姓名拼音，与其他用户创建的Wordpress应用服务器区分开。

- 其他参数不要修改，因为VSwitchID，Security Group ID等，都是事先已经创建好了。

```bash
INSTANCE_ID=`aliyun ecs CreateInstance \
--RegionId cn-zhangjiakou \
--ZoneId cn-zhangjiakou-a \
--InstanceChargeType PostPaid \
--IoOptimized optimized \
--InstanceType ecs.t5-lc2m1.nano \
--ImageId m-8vb7gbyd3dc37k15i35c \
--VSwitchId vsw-8vbwd1gubib8d2smt4etl \
--InternetChargeType PayByTraffic \
--InternetMaxBandwidthOut 20 \
--SecurityGroupId sg-8vbbc7cf61pctx9nj5kl \
--HostName WP-Server-你的姓名的拼音 \
--InstanceName WP-Server-你的姓名的拼音 \
--SecurityEnhancementStrategy Deactive \
--SystemDisk.Size 20 \
--SystemDisk.Category cloud_efficiency \
--KeyPairName aliworkshop-你的姓名拼音 | jq .InstanceId | sed 's/\"//g'`

sleep 5
aliyun ecs StartInstance --InstanceId $INSTANCE_ID
sleep 10
aliyun ecs AllocatePublicIpAddress --InstanceId $INSTANCE_ID
```

3.执行下面的命令创建SLB，并关联Wordpress应用服务器。--LoadBalancerName参数值后面跟上你的姓名拼音，以便和其他人创建的SLB进行区分。
创建SLB：
```bash
LBID=`aliyun slb CreateLoadBalancer \
--RegionId cn-zhangjiakou \
--InternetChargeType paybytraffic \
--AddressType internet \
--LoadBalancerName wp-slb-你的姓名的拼音 \
--VpcId vpc-8vbimr8d4ffkh3l9xljz7 \
--MasterZoneId cn-zhangjiakou-a \
--SlaveZoneId cn-zhangjiakou-b \
--LoadBalancerSpec slb.s1.small \
--PayType PayOnDemand | jq .LoadBalancerId | sed 's/\"//g'`
```

创建监听器：
```bash
aliyun slb CreateLoadBalancerHTTPListener \
--RegionId cn-zhangjiakou \
--LoadBalancerId $LBID \
--Bandwidth 10 \
--ListenerPort 80 \
--BackendServerPort 80 \
--StickySession off \
--HealthCheck off
```

添加后端实例：
```bash
aliyun slb AddBackendServers \
--RegionId cn-zhangjiakou \
--LoadBalancerId $LBID \
--BackendServers "[{ 'ServerId': '$INSTANCE_ID', 'Weight': '100', 'Type': 'ecs'}]"
```

启动SLB：
```bash
aliyun slb StartLoadBalancerListener \
--RegionId cn-zhangjiakou \
--LoadBalancerId $LBID \
--ListenerPort 80
```

获取SLB的公网IP地址：
```bash
SLBIP=`aliyun slb DescribeLoadBalancers \
--RegionId cn-zhangjiakou \
--LoadBalancerId $LBID | jq .LoadBalancers | jq .LoadBalancer | jq .[0] | jq .Address | sed 's/\"//g'`
```

访问SLB的公网IP地址，确保能正常访问:
```bash
curl http://$SLBIP
echo $SLBIP
```

4.执行下面的命令获取该Wordpress应用服务器的公网IP地址和私有IP地址：
```bash
aliyun ecs DescribeInstances --RegionId cn-zhangjiakou|grep $INSTANCE_ID|jq .Instances | jq .Instance | jq .[0] | jq .PublicIpAddress | jq .IpAddress
aliyun ecs DescribeInstances --RegionId cn-zhangjiakou|grep $INSTANCE_ID|jq .Instances | jq .Instance | jq .[0] | jq .NetworkInterfaces | jq .NetworkInterface | jq .[0] | jq .PrimaryIpAddress
```

