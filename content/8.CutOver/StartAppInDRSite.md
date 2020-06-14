---
title: "在目标站点启动应用程序"
chapter: false
weight: 85
---

## 在AWS平台上把应用服务器和数据库关联并使其正常可用

如果本地数据中心发生不可用，从而需要切换到AWS的时候，通常都需要对应用程序进行一定的变更和配置。
对于我们这次使用的Wordpress示例应用来说，则需要在AWS上进行如下的配置：

1.打开宁夏region的EC2控制台，找到被CloudEndure启动起来的应用服务器：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances:tag:Name=CloudEndure,WP-Server;sort=launchTime

选择名称为"WP-Server"的EC2，并记录其私有IP地址。
![](/images/Failover/wpEC2PrivIP.png)

2.打开宁夏region的RDS控制台：https://cn-northwest-1.console.amazonaws.cn/rds/home?region=cn-northwest-1#database:id=wordpress;is-cluster=false

把wordpress数据库的endpoint拷贝下来。
![](/images/Failover/getRDSEndpoint.png)

3.登录到EC2堡垒机里，执行下面的命令登录到WP-Server的EC2里，并把修改Wordpress配置文件里的数据连接字符串信息：
```bash
ssh -i key-in-zhangjiakou.pem root@10.0.64.97
sudo su - 
cd /usr/share/nginx/html/wordpress
sed -i "s/阿里云RDS的连接字符串/第2步中记录下来的RDS的Endpoint/g" wp-config.php
```

4.在EC2堡垒机里，通过mysql客户端登录到Amazon RDS里，并执行下面的SQL语句：
```bash
mysql -h 第2步中记录下来的RDS的Endpoint -uroot -pInitial-1 wordpress
UPDATE wp_options SET option_value = REPLACE(option_value, '阿里云SLB的公网IP地址', 'AWS在宁夏region的ALB的域名') WHERE option_name = 'home' OR option_name = 'siteurl';
UPDATE wp_posts SET post_content = REPLACE(post_content, '阿里云SLB的公网IP地址', 'AWS在宁夏region的ALB的域名');
UPDATE wp_posts SET guid = REPLACE(guid, '阿里云SLB的公网IP地址', 'AWS在宁夏region的ALB的域名');
```

5.在浏览器地址栏中输入：AWS在宁夏region的ALB的域名/wordpress
从而打开Wordpress应用，确认是否可以看到您在阿里云的应用系统里输入的博客。
