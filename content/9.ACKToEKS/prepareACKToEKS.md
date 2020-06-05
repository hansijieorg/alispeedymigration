---
title: "迁移前的准备工作"
chapter: false
weight: 92
---

## 迁移前的准备工作

在把ACK上的应用迁移到EKS之前，需要在AWS平台上进行一些准备工作。
登录到AWS的Linux工作服务器上，进行如下的操作，从而在ACK上安装velero。

1.下载velero
```bash
wget https://github.com/vmware-tanzu/velero/releases/download/v1.3.2/velero-v1.3.2-linux-amd64.tar.gz
tar -xvf velero-v1.3.2-linux-amd64.tar.gz
cd velero-v1.3.2-linux-amd64
sudo cp velero /usr/local/bin/
```

2.在宁夏region创建bucket，该bucket用于存放从ACK上备份的应用数据。为了避免冲突，bucket的名称可以带上自己的姓名拼音。
```bash
export VELERO_BUCKET=velero-s3-bucket-<姓名拼音>
export AWS_DEFAULT_REGION=cn-northwest-1
aws s3api create-bucket \
--bucket ${VELERO_BUCKET} \
--region ${AWS_DEFAULT_REGION} \
--create-bucket-configuration LocationConstraint=${AWS_DEFAULT_REGION} \
--profile default
```

3.创建velero的用户名和组，需要s3和ec2的权限，下面的脚本中给了full access。
```bash
aws iam create-group --group-name velero --profile default
aws iam attach-group-policy --policy-arn arn:aws-cn:iam::aws:policy/AmazonS3FullAccess --group-name velero --profile default
aws iam attach-group-policy --policy-arn arn:aws-cn:iam::aws:policy/AmazonEC2FullAccess --group-name velero --profile default
aws iam create-user --user-name velero --profile default
aws iam add-user-to-group --user-name velero --group-name velero --profile default
aws iam create-access-key --user-name velero --profile default
```

把创建用户velero的时候输出的access key id以及secret key记录下来，分别填入下面的<access key id>和<secret key>部分。
```bash
echo "[default]" >> credentials-velero
echo "aws_access_key_id = <access key id>" >> credentials-velero
echo "aws_secret_access_key = <secret key>" >> credentials-velero
```

4.在ACK里安装velero，注意把下面的"<姓名拼音>"改为你自己的值。
```bash
export VELERO_BUCKET=velero-s3-bucket-<姓名拼音>
export AWS_DEFAULT_REGION=cn-northwest-1
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.0.0 \
    --bucket ${VELERO_BUCKET} \
    --backup-location-config region=${AWS_DEFAULT_REGION}  \
    --snapshot-location-config region=${AWS_DEFAULT_REGION} \
    --use-restic \
    --secret-file ./credentials-velero
```

执行下面的命令查看velero在ACK上的安装过程。
```bash
kubectl get pods -n velero --watch
```

5.在EKS里安装velero。
假设已经按照AWS的官方文档安装好了名为echo-cluster的EKS集群：https://docs.amazonaws.cn/eks/latest/userguide/getting-started-console.html

执行下面的命令，在.kube/config文件里添加新的集群的信息：
```bash
kubectl config current-context
aws eks update-kubeconfig --name echo-cluster --profile default --region cn-northwest-1
kubectl config current-context
```

确认了当前kubectl连接的集群为EKS上的echo-cluster以后，执行下面的命令，从而在EKS上安装velero。
注意把下面的"<姓名拼音>"改为你自己的值。
```bash
export AWS_DEFAULT_REGION=cn-northwest-1
export VELERO_BUCKET=velero-s3-bucket-<姓名拼音>
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.0.0 \
    --bucket ${VELERO_BUCKET} \
    --backup-location-config region=${AWS_DEFAULT_REGION}  \
    --snapshot-location-config region=${AWS_DEFAULT_REGION} \
    --use-restic \
    --secret-file ./credentials-velero
```

执行下面的命令查看velero在EKS上的安装过程。
```bash
kubectl get pods -n velero --watch
```

