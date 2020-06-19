---
title: "在ACK上部署应用系统"
chapter: false
weight: 91
---

## 在ACK上部署应用系统

请遵循以下步骤，从而在ACK上部署应用系统：

1.SSH到AWS的堡垒机上，执行下面的命令，获取阿里云ACK集群上的凭据：
```bash
cd ~/
rm -rf ~/.kube
mkdir ~/.kube
cd ~/.kube
wget https://ali-migrate-demo.s3.cn-northwest-1.amazonaws.com.cn/config
```

在获得了config文件以后，执行下面的命令确认能够成功连接到ACK集群：
```bash
kubectl get svc
```
如果输出能看到如下的输出，则说明成功连接上了ACK集群。
![](/images/ACKToEKS/getSvcFromACK.png)

2.把下面列出的、用于部署环境相关的脚本上传到AWS的堡垒机上。
{{%attachments title="下载链接:" /%}}

把3个模板文件和1个shell脚本文件下载同一个目录下，或者也可以在AWS的堡垒机上执行下面的命令：
```bash
cd ~/
mkdir ackgame
cd ackgame
wget http://gotoaws.cloudguru.run/9.ACKToEKS/deploySourceOnACK.files/2048-deployment.yaml.template
wget http://gotoaws.cloudguru.run/9.ACKToEKS/deploySourceOnACK.files/2048-namespace.yaml.template
wget http://gotoaws.cloudguru.run/9.ACKToEKS/deploySourceOnACK.files/2048-service.yaml.template
wget http://gotoaws.cloudguru.run/9.ACKToEKS/deploySourceOnACK.files/create-src.sh
```

文件下载以后，执行如下的命令，其中的"编号"为整个实验最开始之前为你分配的编号：
```bash
chmod u+x create-src.sh
./create-src.sh 编号
```

假设"编号"为2，则其输出会如下图所示，说明应用部署成功。
![](/images/ACKToEKS/deployGameOnACK.png)

执行下面的命令，获得生成的SLB的信息：
```bash
kubectl get svc -n 2048-game2
```

其输出如下图所示，可以看到生成的SLB的ip地址。
![](/images/ACKToEKS/getSLBonACK.png)

打开浏览器，并输入上图看到的SLB的IP地址，从而打开该应用。
