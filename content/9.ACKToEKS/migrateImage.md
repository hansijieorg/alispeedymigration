---
title: "迁移镜像"
chapter: false
weight: 93
---

## 迁移镜像
镜像迁移过程中，如果涉及到的镜像 过多，那么迁移工作机的磁盘会被大量消耗，那么需要保证迁移工作机的磁盘容量。
假设在客户生产环境中使用到的应用的镜像都存放在阿里云镜像仓库私有模式下，通过以下方式完成镜像的迁移（以下操作都在Linux工作服务器上完成）：

1.登录到ACR（阿里云镜像仓库），并把应用所用到的镜像下载到本地服务器。其中的"xxxx"是工作人员所提供的阿里云RAM账号。
```bash
sudo docker login --username=xxxx registry.cn-zhangjiakou.aliyuncs.com
sudo docker pull registry.cn-zhangjiakou.aliyuncs.com/aliworkshop/aligame:2048-game
```

2.在AWS的ECR里创建名为prodrepo的镜像仓库。
```bash
aws ecr create-repository --repository-name aliworkshop --region cn-northwest-1
```

3.把镜像推送到ECR上：
```bash
aws ecr get-login-password --region cn-northwest-1 | sudo docker login --username AWS --password-stdin <12位的aws账号>.dkr.ecr.cn-northwest-1.amazonaws.com.cn
sudo docker tag registry.cn-zhangjiakou.aliyuncs.com/aliworkshop/aligame:2048-game <12位的aws账号>.dkr.ecr.cn-northwest-1.amazonaws.com.cn/aliworkshop:2048-game
sudo docker push <12位的aws账号>.dkr.ecr.cn-northwest-1.amazonaws.com.cn/aliworkshop:2048-game
```

