---
title: "对迁移后的数据进行验证"
chapter: false
weight: 113
---

## 对迁移后的数据进行验证

#### 启动并配置 EC2 实例

按照以下步骤启动并配置 EC2 实例：

1. 打开印度 Region 的 EC2 控制台：[https://ap-south-1.console.aws.amazon.com/ec2/v2/home?region=ap-south-1#Instances:sort=instanceId](https://ap-south-1.console.aws.amazon.com/ec2/v2/home?region=ap-south-1#Instances:sort=instanceId)

2. 启动EC2实例

    * 点击【启动实例】，选择”Amazon Linux 2 AMI (HVM)“
    ![](/images/MongoDB2DocDB/EC2AMI.png)

    * 点击下一步，实例类型保持默认的“t2.micro”，点击下一步，网络选择跟 DocumentDB 同一个 VPC
    ![](/images/MongoDB2DocDB/EC2VPC.png)
        
    * 点击下一步，在添加存储、添加标签节目保持默认选项下一步。配置安全组界面，【分配安全组】选择：“创建一个新的安全组”，【安全组名称】和【描述】输入：`lab-ec2`，点击【审核和启动】
    ![](/images/MongoDB2DocDB/EC2SG.png)
        
    * 点击【启动】,在选择现有密钥对或创建新密钥对页面，选择“创建新密钥对”，“密钥对名称”输入：`lab`，点击【下载密钥对】，保存密钥文件后，点击【启动实例】
    ![](/images/MongoDB2DocDB/EC2Key.png)

3. 配置安全组，在 DocumentDB 使用的默认安全组里加入 EC2 使用安全组的入站规则

    * 在页面选择“安全组”，勾选安全组名称为 *default* 的安全组，并点击【编辑入站规则】
    ![](/images/MongoDB2DocDB/EC2Group1.png)

    * 点击【添加规则】，“类型”选择“所有流量”，“源”选择上面ec2使用的安全组，点击【保存规则】
    ![](/images/MongoDB2DocDB/EC2Group2.png)

4. 连接EC2实例

    * 在实例页面，等实例状态变为“running”后，点击页面的【连接】按钮，并选择“EC2 实例连接 (基于浏览器的 SSH 连接)”，点击【连接】
    ![](/images/MongoDB2DocDB/EC2Connect1.png)
    ![](/images/MongoDB2DocDB/EC2Connect2.png)

    * 本地电脑打开命令行终端，按照上面连接到实例的说明，连接到EC2实例
    ![](/images/MongoDB2DocDB/EC2Connect3.png)

#### 使用 MongoDB Shell 连接  DocumentDB

按照以下步骤使用 MongoDB Shell 连接 Amazon DocumentDB 集群：

1.  安装 MongoDB Shell

    * 在EC2里创建包含以下内容的文件 /etc/yum.repos.d/mongodb-org-3.6.repo：
    ```bash
    [mongodb-org-3.6]
        name=MongoDB Repository
        baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/3.6/x86_64/
        gpgcheck=1
        enabled=1
        gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
    ```

    * 以下单行命令创建该文件：
    ```bash
    echo -e "[mongodb-org-3.6] \nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/3.6/x86_64/\ngpgcheck=1 \nenabled=1 \ngpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc" | sudo tee /etc/yum.repos.d/mongodb-org-3.6.repo 
    ```

    * 安装MongoDB Shell：
    ```bash
    sudo yum install -y mongodb-org-shell
    ```

2. 连接 Amazon DocumentDB 集群
    * 打开DocumentDB实例信息页面：https://ap-south-1.console.aws.amazon.com/docdb/home?region=ap-south-1#cluster-details/aws-docdb
    ![](/images/MongoDB2DocDB/ShellConnectInfo.png)

    * 按照连接说明连接，密码是之前设置的：Awsaws123 , 连接后看到如下界面说明连接成功
    ![](/images/MongoDB2DocDB/ShellConnect.png)


#### 验证数据迁移结果

按照以下步骤验证数据迁移结果：

1. 在MongoDB Shell页面，输入以下命令查看所有数据库：
    ```bash
    show dbs
    ```

2. 输入以下命令使用admin数据库：
    ```bash
    use admin
    ```
3. 输入以下命令查询admin数据库中的集合：
    ```bash
    show collections
    ```
4. 如果能显示admin数据库以及数据库里的aws集合，说明迁移已经完成了
![](/images/MongoDB2DocDB/CheckResult.png)

5. 迁移验证完成后，可以在阿里云的MongoDB里再插入新的数据，并验证 DocumentDB 里对新插入数据的同步情况