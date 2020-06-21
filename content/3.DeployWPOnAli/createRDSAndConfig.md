---
title: "创建RDS并进行应用系统的配置"
chapter: false
weight: 32
---

## 创建RDS并进行应用系统的配置

在阿里云上部署了应用服务器和负载均衡器以后，按照下面的步骤部署RDS，并进行应用系统的配置：

1.执行下面的命令，创建RDS，下面的"x"改为你对应的编号，注意该命令会执行一段时间才会返回，请耐心等候：
```bash
RDSINFO=`aliyun rds CreateDBInstance \
--RegionId cn-zhangjiakou \
--Engine MySQL \
--EngineVersion 5.7 \
--DBInstanceClass mysql.n1.micro.1 \
--DBInstanceStorage 20 \
--DBInstanceNetType Internet \
--SecurityIPList 0.0.0.0/0 \
--PayType Postpaid \
--ZoneId cn-zhangjiakou-a \
--InstanceNetworkType VPC \
--ConnectionMode Standard \
--VPCId vpc-8vbimr8d4ffkh3l9xljz7 \
--VSwitchId vsw-8vbwd1gubib8d2smt4etl`
```

运行下面的命令获得RDS实例的状态：
```bash
RDSID=`echo $RDSINFO | jq .DBInstanceId | sed 's/\"//g'`
aliyun rds DescribeDBInstances \
--RegionId cn-zhangjiakou \
--DBInstanceId $RDSID | jq .Items | jq .DBInstance | jq .[0] | jq .DBInstanceStatus
```

直到返回Running，再进行后续的操作。

为RDS添加标签：
```bash
aliyun rds AddTagsToResource \
--RegionId cn-zhangjiakou \
--DBInstanceId $RDSID \
--Tag.1.key='author' \
--Tag.1.value='你的姓名拼音'
```

创建RDS账号：
```bash
RDSID=`echo $RDSINFO | jq .DBInstanceId | sed 's/\"//g'`
aliyun rds CreateAccount \
--DBInstanceId $RDSID \
--AccountName root \
--AccountPassword Initial-1 \
--AccountType Super
```

获得RDS的连接字符串：
```bash
RDSCONN=`echo $RDSINFO | jq .ConnectionString | sed 's/\"//g'`
echo $RDSCONN
```

2.根据之前获得的Wordpress应用服务器的公网IP地址，SSH登录到该服务器，修改相应的配置：
```bash
cd /usr/share/nginx/html/wordpress
sed -i "s/localhost/创建出来的RDS的连接字符串/g" wp-config.php
mysql -h 创建出来的RDS的连接字符串 -u root -pInitial-1 < ~/wordpress.sql

mysql -h 创建出来的RDS的连接字符串 -u root -pInitial-1 wordpress
```

执行下面的SQL语句：
```bash
UPDATE wp_options SET option_value = REPLACE(option_value, 'localhost', '阿里云SLB的公网IP地址') WHERE option_name = 'home' OR option_name = 'siteurl';
UPDATE wp_posts SET post_content = REPLACE(post_content, 'localhost', '阿里云SLB的公网IP地址');
UPDATE wp_posts SET guid = REPLACE(guid, 'localhost', '阿里云SLB的公网IP地址');
```

3.打开浏览器，访问http://阿里云SLB的公网IP地址/wordpress，确认该网站能够正常打开。

