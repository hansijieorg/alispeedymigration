---
title: "在容灾站点启动应用程序"
chapter: false
weight: 84
---

## 在AWS平台上把应用服务器和数据库关联并使其正常可用

如果本地数据中心发生不可用，从而需要切换到AWS的时候，通常都需要对应用程序进行一定的变更和配置。
对于我们这次使用的Wordpress示例应用来说，则需要在AWS上进行如下的配置：

1.打开宁夏region的EC2控制台，找到被CloudEndure启动起来的应用服务器：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-northwest-1#Instances:tag:Name=CloudEndure,APP;sort=launchTime

选择名称为"WordPress APP"的EC2，并记录其私有IP地址。
![](/images/Failover/wpEC2PrivIP.png)

2.打开宁夏region的RDS控制台：https://cn-northwest-1.console.amazonaws.cn/rds/home?region=cn-northwest-1#database:id=wordpress;is-cluster=false

把wordpress数据库的endpoint拷贝下来。
![](/images/Failover/getRDSEndpoint.png)

3.登录到堡垒机，并在xshell里，找到"remote-aws-env"，并修改其属性，在"主机(H)"一栏中，填入上一步记录下来的私有IP地址。
![](/images/Failover/modifyDRSiteEC2IP.png)

4.在右侧选择"用户身份验证"，再点击左侧的"用户密钥(K)"下拉列表，选择local-idc-key。再点击【确定】按钮。
{{% notice note %}}
因为本地数据中心里的key pair也被CloudEndure复制到了容灾端，因此在容灾端里的EC2使用了与本地数据中心相同的key pair。
{{% /notice  %}}

5.点击【连接】按钮，并在"SSH安全警告"弹出窗口里，点击【接受并保存】按钮，从而登录到容灾端的EC2实例里。

6.执行下面的命令：
```bash
sudo su - 
cd /usr/share/nginx/html/wordpress
sed -i "s/localhost/第2步中记录下来的RDS的Endpoint/g" wp-config.php
```

7.在堡垒机里，启动MySQL Workbench，在其界面上找到并右键点击"remote-aws-env"图标，在弹出菜单中选择"Edit Connection..."菜单选项。
并在"Hostname"一栏填入第2步中记录的RDS Endpoint。
![](/images/Failover/editRemoteRDSConnection.png)

点击"Store in Vault..."按钮，在弹出的窗口的"Password"栏位中输入：Initial-1

点击【OK】按钮退出当前窗口。

点击【Test Connection】按钮确认连接成功以后，点击【Close】按钮退出。

双击"remote-aws-env"，然后在Query 1里输入下面的SQL，注意把下面的"Wordpress服务器在宁夏region的私有IP地址"改为你在第1步中记录的私有IP地址，其IP地址的前2段为"192.168"
并把"Wordpress服务器在北京region的私有IP地址"对应的私有IP地址，其IP地址的前2段为"10.0"，也可以打开北京region的EC2控制台找到该私有IP：https://cn-northwest-1.console.amazonaws.cn/ec2/v2/home?region=cn-north-1#Instances:tag:Name=APP;sort=launchTime

```bash
UPDATE wp_options SET option_value = REPLACE(option_value, 'Wordpress服务器在北京region的私有IP地址', 'Wordpress服务器在宁夏region的私有IP地址') WHERE option_name = 'home' OR option_name = 'siteurl';
UPDATE wp_posts SET post_content = REPLACE(post_content, 'Wordpress服务器在北京region的私有IP地址', 'Wordpress服务器在宁夏region的私有IP地址');
UPDATE wp_posts SET guid = REPLACE(guid, 'Wordpress服务器在北京region的私有IP地址', 'Wordpress服务器在宁夏region的私有IP地址');
```

然后在Query下拉菜单里选择"Execute (All or Selection)"选项，执行这3条SQL语句：
![](/images/Failover/updateRemoteMetadata.png)

8.在桌面的WorkshopTools文件夹，找到并双击"Google Chrome"，在浏览器地址栏中输入：Wordpress服务器在宁夏region的私有IP地址/wordpress
从而打开Wordpress应用，确认是否可以看到您在本地数据中心的应用系统里输入的博客。



