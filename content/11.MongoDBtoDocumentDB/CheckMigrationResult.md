---
title: "对迁移后的数据进行验证"
chapter: false
weight: 113
---

## 对迁移后的数据进行验证

#### 使用 MongoDB Shell 连接  DocumentDB

按照以下步骤使用 MongoDB Shell 连接 Amazon DocumentDB 集群：

1. 打开印度 Region 的 EC2 控制台：[https://ap-south-1.console.aws.amazon.com/ec2/v2/home?region=ap-south-1#Instances:search=BastionInstance;sort=instanceId](https://ap-south-1.console.aws.amazon.com/ec2/v2/home?region=ap-south-1#Instances:search=BastionInstance;sort=instanceId)
找到堡垒机EC2的公网ip地址，并使用key pair登录。

2.  安装 MongoDB Shell

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