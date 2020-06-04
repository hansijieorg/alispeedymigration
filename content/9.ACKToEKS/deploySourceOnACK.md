---
title: "在ACK上部署应用系统"
chapter: false
weight: 91
---

## 在ACK上部署应用系统

请遵循以下步骤，从而在ACK上部署应用系统：

1.使用RAM子账号登录阿里云控制台：https://signin.aliyun.com/1244465442914189.onaliyun.com/login.htm

用户名格式为：xxxxx@1244465442914189.onaliyun.com，密码为：Initial-1

2.进入镜像仓库控制台：https://cr.console.aliyun.com/cn-zhangjiakou/new

点击【设置Registry登录密码】按钮，并在弹出界面上，输入密码为：Initial-1

3.获得ACK集群的连接信息。进入ACK控制台：https://cs.console.aliyun.com/?spm=5176.8351553.nav-right.45.18641991YpiBs2#/k8s/cluster/list

找到并点击名为ack-game的链接
![](/images/ACKToEKS/ackclusterlist.png)

找到如下图所示的内容，点击【复制】按钮，把连接信息拷贝下来。
![](/images/ACKToEKS/getACKConnection.png)

4.在Linux工作服务器上，执行下面的命令：
```bash
mkdir ~/.kube
cd ~/.kube
vi config
```

并把上一步中拷贝的集群连接信息复制到config文件里，然后执行下面的命令确认能够成功连接到ACK集群：
```bash
kubectl get svc
```
如果输出能看到如下的输出，则说明成功连接上了ACK集群。
![](/images/ACKToEKS/getSvcFromACK.png)

5.把下面列出的、用于部署环境相关的脚本上传到Linux工作服务器上。
{{%attachments title="下载链接:" /%}}

把3个模板文件和1个shell脚本文件下载同一个目录下以后，执行如下的命令，其中的"编号"会由工作人员提供。
```bash
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
