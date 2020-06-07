---
title: "把数据从OSS迁移到Amazon S3"
chapter: false
weight: 71
---

## 把数据从OSS迁移到Amazon S3

进行以下步骤，把数据从AliCloud OSS迁移到Amazon S3：
1.SSH登录到堡垒机，执行下面的命令，确认python3和Git已安装完成
```bash
python3 --version
git --version
```

2.确认环境就绪后,使用以下代码进行amazon-s3-resumable-upload工具安装
```bash
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple oss2 --user
git clone https://github.com/aws-samples/amazon-s3-resumable-upload.git
cd amazon-s3-resumable-upload-master/single_node
pip3 install -r requirements.txt --user
```

3.至此迁移工具主机上的环境和工具已经就绪,接下来开始配置迁移工具
进入amazon-s3-resumable-upload/single_node目录，找到并编辑s3_upload_config.ini文件。为了安全起见，我们可以先讲该文件备份一份。

我们使用node或者vi工具修改该文件,主要需要修改的参数包括:
```bash
JobType = ALIOSS_TO_S3
SrcFileIndex = *
S3Prefix =  
DesProfileName = default
DesBucket = ali-migrate-demo
ali_SrcBucket = oss-origin
ali_access_key_id = <填入你的RAM用户的Access Key ID>
ali_access_key_secret = <填入你的RAM用户的Access Key Secret>
ali_endpoint = oss-cn-zhangjiakou.aliyuncs.com
```

注意这些参数的值都不要前后加双引号，主要的参数的含义为：
* SrcFileIndex：表示所有文件

* S3Prefix：表示指定的OSS上的文件夹,如果留空表示的OSS bucket下所有的文件,这个Prefix也会同步到S3中

* DesBucket：AWS上的目地桶,根据需要修改

* ali_SrcBucket：阿里云OSS源Bucket,根据需要修改

* ali_endpoint：OSS 区域 endpoint，在OSS控制台界面可以找到

在配置文件完成以后，则可以启动迁移工作，在single_node目录下,输入下面的命令：
```bash
python3 s3_upload.py
```

执行过程如下图所示，并且当所有工作迁移完成后,会提示请点击回车退出：
![](/images/ObjectStorageMigration/upload2.png)

我们回到AWS 控制台中,在S3桶中验证数据已经从OSS迁移到了S3里。
