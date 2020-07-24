---
title: "使用 AWS DMS 进行数据迁移"
chapter: false
weight: 113
---

## 部署 使用 AWS DMS 进行数据迁移

#### 创建终端节点

按照以下步骤创建源终端节点和目标终端节点：

1. 打开印度 Region 的 DMS 控制台：[https://ap-south-1.console.aws.amazon.com/dms/v2/home?region=ap-south-1](https://ap-south-1.console.aws.amazon.com/dms/v2/home?region=ap-south-1)

2. 创建源终端节点
    
    * 在左边菜单上选择【终端节点】菜单，然后在右边的界面上选择【创建终端节点】按钮
        ![](/images/MongoDB2DocDB/CreateEndpoint.png)
    
    * 在创建终端节点的界面上：
        
        * “终端节点类型”选择：源终端节点
        
        * “终端节点标识符”输入：`ali-endpoint`
        
        * “源引擎”选择：mongodb
        
        * “服务器名称”输入: 之前所获得的阿里云MongoDB的外网连接地址里的域名
        ![](/images/MongoDB2DocDB/MongoDBPublicAccess.png)
        
        * “端口”输入：`3717`
        
        * “身份验证模式”选择：password
        
        * “用户名”输入：`root`
        
        * “密码”输入：`Aliyun123`
                
        * “数据库名称”输入：`admin`

        * 其他保留缺省值
        ![](/images/MongoDB2DocDB/SourceEndpoint-1.png)
        ![](/images/MongoDB2DocDB/SourceEndpoint-2.png)
        
        * 点击【创建终端节点】

3. 创建目标终端节点
    
    * 在左边菜单上选择【终端节点】菜单，然后在右边的界面上选择【创建终端节点】按钮
        ![](/images/MongoDB2DocDB/CreateEndpoint2.png)
    
    * 在创建终端节点的界面上：
        
        * “终端节点类型”选择：目标终端节点
        
        * “终端节点标识符”输入：`aws-endpoint`
        
        * “源引擎”选择：docdb
        
        * “服务器名称”输入DocumentDB连接信息里的域名
        ![](/images/MongoDB2DocDB/DocdbCname.png)
        
        * “端口”输入：`27017`
        
        * “安全套接字层 (SSL) 模式”选择：verify-full
        
        * 点击 “添加新的CA证书”，把DocumentDB连接信息里获取到的pem证书下载地址通过浏览器或者wget命令下载到本地，然后点击【Choose File】上传，“证书标识符”输入：`LabCertificate`，点击【导入证书】
            
        ![](/images/MongoDB2DocDB/DocdbCAURL.png)                        
        ![](/images/MongoDB2DocDB/DocdbCAUpload.png)
        
        * “用户名”输入：`root`
        
        * “密码”输入：`Awsaws123`
        
        * “数据库名称”输入：`admin`

        * 其他保留缺省值
        ![](/images/MongoDB2DocDB/DestEndpoint.png)

        * 点击【创建终端节点】

####  创建复制实例

按照以下步骤创建复制实例：

1. 打开印度Region的DMS控制台：[https://ap-south-1.console.aws.amazon.com/dms/v2/home?region=ap-south-1#replicationInstances](https://ap-south-1.console.aws.amazon.com/dms/v2/home?region=ap-south-1#replicationInstances)

2. 创建复制实例

    * 在左边菜单上选择【复制实例】菜单，然后在右边的界面上选择【创建复制实例】按钮

        ![](/images/MongoDB2DocDB/CreateReplicaInstance.png)
    
    * 在创建复制实例界面上：
        
        * “名称”输入：`lab-replication`
        
        * “描述”输入：`lab-replication`
        
        * “VPC”选择：如果只有一个选项就选择默认的一个，如果有多个选择跟DocumentDB实例同一个vpc
        ![](/images/MongoDB2DocDB/ReplicationVPC.png)
        
        * 其他保留缺省值
        ![](/images/MongoDB2DocDB/CreateReplicaInstance2.png)

        * 点击【创建】按钮

#### 测试终端节点连接

按照以下步骤测试终端节点连接：

1. 打开印度Region的DMS控制台：[https://ap-south-1.console.aws.amazon.com/dms/v2/home?region=ap-south-1#endpointList](https://ap-south-1.console.aws.amazon.com/dms/v2/home?region=ap-south-1#endpointList)

2. 选择ali-endpoint，在【操作】下拉框里选择【测试连接】
    ![](/images/MongoDB2DocDB/AliEndpoint.png)
    
3. 在界面上选择【运行测试】按钮，看到状态为successful以后，点击【返回】按钮
    ![](/images/MongoDB2DocDB/AliEndpointTest.png)
    
4. 选择ali-endpoint，在【操作】下拉框里选择【测试连接】
    ![](/images/MongoDB2DocDB/AWSEndpoint.png)
    
5. 在界面上选择【运行测试】按钮，看到状态为successful以后，点击【返回】按钮
    ![](/images/MongoDB2DocDB/AWSEndpointTest.png)

#### 创建迁移任务

按照以下步骤创建迁移任务：

1. 打开DMS控制台： [https://ap-south-1.console.aws.amazon.com/dms/v2/home?region=ap-south-1#tasks](https://ap-south-1.console.aws.amazon.com/dms/v2/home?region=ap-south-1#tasks)

2. 在左边菜单上选择【数据库迁移任务】菜单，然后在右边的界面上选择【创建任务】按钮
![](/images/MongoDB2DocDB/CreateMigrationJob.png)

3. 在创建数据库迁移任务界面上：
    
    * “任务标识符”输入：`lab-migration`
    
    * “复制实例”选择：lab-replication - vpc-xxxxxxx
    
    * “源数据库终端节点”选择：ali-endpoint
    
    * “目标数据库终端节点”选择：aws-endpoint
    
    * “迁移类型”选择：迁移现有数据并复制正在进行的更改
    
    * “表映像”选择：引导式UI，点击【添加新选择规则】，“架构”选择：输入架构，
    
    * 其他保留缺省值
    ![](/images/MongoDB2DocDB/CreateMigrationJobInfo-1.png)
    ![](/images/MongoDB2DocDB/CreateMigrationJobInfo-2.png)
        
    * 点击【创建任务】按钮

4. 等迁移任务进度变成“100%”后，进行下一步的实验
![](/images/MongoDB2DocDB/MigrationDone.png)
