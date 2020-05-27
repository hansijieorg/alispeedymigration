---
title: "部署Agent"
chapter: false
weight: 41
---

## 在本地数据中心的应用服务器上部署CloudEndure agent

部署agent的过程如下：
1.访问Cloudendure Console: https://console.awscloudendure.cn/#/signIn

输入工作人员提供的用户名和密码，然后点击【SIGN IN】

2.点击左上角的"+"，创建项目，填写项目名称为wp-dir(如果多人共用一个CloudEndure账号，则项目名称后面可以跟上自己的名称，比如wp-dir-xyz)、类型选择Disaster Recovery，并创建项目。
![](/images/SyncWithCloudEndure/createProject.png)

3.点击创建项目按钮以后，在弹出的窗口上点击【START】按钮，并在下一个弹出的"Project Not Set Up!"界面上，点击【CONTINUE】按钮。
在Setup & Info中的AWS CREDENTIALS tab页中：

* 在"AWS Access Key ID"输入：demouser用户的Access key。
* 在"AWS Secret Access Key"输入：demouser用户的Secret key。

点击【Save】按钮。

4.接下来在REPLICATION SETTINGS中：

* 设置Disaster Recovery Source为AWS China(Beijing)，Disaster Recovery Target为AWS China(Ningxia)。

* 在Replication Servers里选择机型类型，如果需要复制的数量量较大，可适当选择稍大一些的机型。在这里选择c5.large。

* 在"Choose the subnet where the Replication Servers will be launched:"部分：选择名为BCDRVPC里的名为DMZ subnet的子网。

* 在"Choose the Security Groups to apply to the Replication Servers:"部分：选择名为WebServerSecurityGroup的安全组。

* 点击【SAVE REPLICATION SETTINGS】按钮。

下图显示了一个样例:
![](/images/SyncWithCloudEndure/replicationSettings.png)

5.安装Agent，点击左侧Machine菜单选项，来获取Agent安装信息。并把如下图样例所示的红框里的命令拷贝下来。
![](/images/SyncWithCloudEndure/installAgent1.png)

6.在本地数据中心的应用服务器里安装agent。打开北京region的EC2控制台：https://console.amazonaws.cn/ec2/v2/home?region=cn-north-1#Instances:tag:Name=Basion,APP;sort=launchTime

找到应用服务器的私有IP地址，然后remote desktop登录到堡垒机，把local-idc-key.pem文件拷贝到堡垒机的WorkShopTools目录下(在本地电脑里选中local-idc-key.pem文件并ctrl+c，然后鼠标点中WorkShopTools目录并ctrl+v即可完成拷贝)。
打开xshell，选择"local-idc-env"，点击"属性"菜单，在弹出界面上，把应用服务器的私有IP地址拷贝到"主机(H)"一栏。
![](/images/SyncWithCloudEndure/inputSourceIP.png)

然后在右侧选择"用户身份验证"，再点击左侧的【浏览(B)...】按钮，并在弹出的窗口上，点击【导入(I)...】按钮，
找到刚才拷贝进来的local-idc-key.pem文件。然后点击【取消按钮】，退出当前窗口。
![](/images/SyncWithCloudEndure/importKey.png)

在"方法(M)"下拉列表里，选择"Public Key"，在"用户名(U)"处保留原来的值"ec2-user"，在"用户密钥"下拉列表里，选择刚才导入的local-idc-key。
![](/images/SyncWithCloudEndure/loginEC2.png)

然后点击【连接】按钮，在"SSH安全警告"弹出窗口里，点击【接受并保存】按钮，从而登录到Wordpress EC2。

在登录到应用服务器以后，把第5步CloudEndure界面上部署agent的命令拷贝并粘贴到shell里执行，从而安装Agent。
![](/images/SyncWithCloudEndure/installAgent2.png)

