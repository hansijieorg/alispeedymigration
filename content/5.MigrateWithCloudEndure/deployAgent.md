---
title: "部署Agent"
chapter: false
weight: 51
---

## 在阿里云的应用服务器上部署CloudEndure agent

部署agent的过程如下：

1.在阿里云的Wordpress应用服务器上卸载安骑士。

先判断当前阿里云ECS服务器上是否运行了安骑士：
```bash
ps aux | grep Ali | grep -v grep
```

如果上面的命令有返回结果，则说明运行了安骑士。按照下面的方式进行删除：
```bash
curl -sSL http://update.aegis.aliyun.com/download/quartz_uninstall.sh | sudo bash
rm -rf /usr/local/aegis
rm /usr/sbin/aliyun-service
ps aux | grep Ali | grep -v grep | awk '{print $2}' | xargs kill -9
```

2.访问Cloudendure Console: https://console.awscloudendure.cn/#/signIn

输入工作人员提供的用户名和密码，然后点击【SIGN IN】

3.点击左上角的"+"，创建项目，填写项目名称为wp-dir(如果多人共用一个CloudEndure账号，则项目名称后面可以跟上自己的名称，比如wp-dir-xyz)、类型选择Migration，并创建项目。
![](/images/SyncWithCloudEndure/createProject.png)

4.点击创建项目按钮以后，在弹出的窗口上点击【START】按钮，并在下一个弹出的"Project Not Set Up!"界面上，点击【CONTINUE】按钮。

在向导的第一步，要求设置 API Access Key。在 Setup & Info 界面下的Credentials 标签页下，输入之前创建的demouser用户的access key和secret key，如下截图。

* 在"AWS Access Key ID"输入：demouser用户的Access key。

* 在"AWS Secret Access Key"输入：demouser用户的Secret key。
![](/images/SyncWithCloudEndure/createProject1.png)

点击【Save】按钮。

5.接下来在REPLICATION SETTINGS中：

* 设置Migration Source为Other Infrastructure，即非AWS的基础设施。Migration Target为AWS China(Ningxia)。

* Replication Server Type：复制实例的类型，如果需要复制的数量量较大，可适当选择稍大一些的机型。在这里为了加快复制，选择c5.large。

* Converter Instance Type：转换实例的类型。这是在数据复制完成 ，生成 Staging 测试服务器和磁盘快照过程的中间实例。为加速转换， 建议设置为默认对m5.xlarge/m4.xlarge。

* Use dedicated Replication Server：不要选中

* 磁盘类型：选择 Use fast SSD data disks

* Subnet：选择名称包含ALIMIGRATIONPrivateSubnet1的子网作为Replication Servers部署的子网

* Security Group：选择名称包含SG-WebServer的安全组

* VPN 或 Direct Connect：选择通过VPN连接到Replication Servers，并选择"Disable public IP"复选框。

* 点击【SAVE REPLICATION SETTINGS】按钮。

下图显示了一个样例:
![](/images/SyncWithCloudEndure/createProject2.png)

6.安装Agent，点击左侧Machine菜单选项，来获取Agent安装信息。并把如下图样例所示的红框里的命令拷贝下来。
![](/images/SyncWithCloudEndure/installAgent1.png)

7.SSH登录到阿里云的应用服务器（根据前面步骤中获得的安装了Wordpress应用的ECS的公网IP地址），把第5步CloudEndure界面上部署agent的两个命令拷贝并粘贴到shell里执行，从而安装Agent。

如果看到下面的输出，则说明安装成功。
![](/images/SyncWithCloudEndure/installAgent2.png)


