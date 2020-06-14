---
title: "迁移应用系统"
chapter: false
weight: 94
---

## 迁移应用系统
对于ACK上的应用系统迁移来说，其流程为：先使用velero对ACK上的应用进行备份，再通过备份从而在EKS上进行恢复。
其具体步骤如下所示（以下操作都在Linux工作服务器上完成）：

1.把kubectl的连接切换到ACK集群。
```bash
kubectl config get-contexts
```
![](/images/ACKToEKS/ack-get-contexts.png)

从以上命令的输出中，可以找到ACK集群的namespace，其由一串数字以及一些随机字符串组成，类似为：218875390585367918-cb3e834a2fff540459ff8341d60da0d54
然后切换到到该ACK集群：
```bash
kubectl config use-context <ACK集群的namespace>
kubectl config current-context
```

2.在ACK上备份源系统，注意把<编号>改为工作人员提供给你的数字。
```bash
kubectl get all -n 2048-game<编号>
velero backup-location get
velero backup get
velero backup create game-backup-<姓名拼音> --include-namespaces 2048-game<编号> --wait
velero backup get
```

如果能够看到名为game-backup-<姓名拼音>的备份，并且其STATUS为Completed，则说明备份成功。也可以查看S3的bucket，确保其中包含了备份文件：
```bash
aws s3 ls s3://velero-s3-bucket-<姓名拼音>/backups/game-backup-<姓名拼音>/
```
![](/images/ACKToEKS/ack-game-backup.png)

3.执行下面的命令，把kubectl的连接切换到EKS集群。
```bash
kubectl config get-contexts
```
从以上命令的输出中，可以找到EKS集群的namespace，其命名格式为：arn:aws-cn:eks:cn-northwest-1:<12位的AWS账号>:cluster/echo-cluster
然后切换到到该EKS集群：
```bash
kubectl config use-context <EKS集群的namespace>
kubectl config current-context
```

4.创建backup location。
```bash
export VELERO_BUCKET=velero-s3-bucket-<姓名拼音>
velero backup-location create game-backup-<姓名拼音> --bucket ${VELERO_BUCKET} --access-mode ReadOnly --provider aws
velero backup-location get
```

5.把备份文件恢复到EKS集群上
```bash
velero restore create --from-backup game-backup-<姓名拼音> --include-namespaces 2048-game<编号>
```

6.因为备份文件中记录的镜像的路径是ACR里的镜像，因此在EKS上恢复应用以后，还需要调整所使用的镜像，使其指向ECR里的路径。
```bash
kubectl edit deployment deployment-2048 -n 2048-game<编号>
```

搜索"registry.cn-zhangjiakou.aliyuncs.com"，从而找到image选项，并将其改为：<12位的aws账号>.dkr.ecr.cn-northwest-1.amazonaws.com.cn/prodrepo:2048-game
保存以后，监控EKS上deployment的启动情况：
```bash
kubectl get deployments -n 2048-game<编号> --watch
```

检查service是否正常启动：
```bash
kubectl get svc -n 2048-game<编号>
```

如果一切正常，会看到一个ALB被创建出来。如下图所示。
![](/images/ACKToEKS/restoreOnEKSWithALB.png)

打开浏览器，并在地址来里输入该ALB的名称，确认能打开应用系统，从而完成了ACK上的应用到EKS上的迁移。
