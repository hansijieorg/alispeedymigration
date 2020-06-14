---
title: "阿里云VPN虚拟机上的配置"
chapter: false
weight: 42
---

## 阿里云VPN虚拟机上的配置

本次实验中，进行如下的配置：

1.SSH登录到位于AWS的堡垒机里，执行下面的命令获取VPN服务器的公网IP地址。
```bash
aliyun ecs DescribeInstances --RegionId cn-zhangjiakou|grep $INSTANCE_ID|jq .Instances | jq .Instance | jq .[0] | jq .PublicIpAddress | jq .IpAddress
```

2.根据上面的命令获得的公网IP地址，SSH登录到阿里云的VPN虚机上，并进行以下操作。
安装OpenSwan软件：
```bash
yum install -y epel-release
yum install -y libreswan
yum install -y python2
ln -s /usr/bin/python2 /usr/bin/python
```

3.编辑ipsec.conf文件的时候，确保include /etc/ipsec.d/*.conf前面没有注释符，以及确保logfile=/var/log/pluto.log 前面没有注释符
```bash
vi /etc/ipsec.conf
```

4.编辑/etc/ipsec.d/nettonet.conf文件
```bash
vi /etc/ipsec.d/nettonet.conf
```

添加如下的内容到nettonet.conf文件里：
```bash
conn nettonet
        authby=secret
        auto=start
        leftid=x                   <--阿里云VPN虚拟机的公网ip
        left=%defaultroute
        leftsubnet=192.168.0.0/16  <--阿里云VPC CIDR
        leftnexthop=%defaultroute
        rightid=ZHY
        right=y                    <--AWS VPN虚拟机的公网ip
        rightsubnet=10.x.0.0/16    <--AWS VPC CIDR，注意这里的x替换成你的编号
        keyingtries=%forever
        ike=aes128-sha1;modp1024
        ikelifetime=86400s
        phase2alg=aes128-sha1
        salifetime=3600s
        pfs=no
```

5.编辑/etc/ipsec.d/nettonet.secrets文件
```bash
vi /etc/ipsec.d/nettonet.secrets
```

添加如下的内容，这里的aws123表示密钥密码，可以是任意内容。把x替换为阿里云VPN虚拟机的公网ip，y替换成AWS VPN虚拟机的公网ip。
```bash
x y: PSK "aws123"
```

6.编辑/etc/sysctl.conf文件
```bash
vi /etc/sysctl.conf
```

添加如下内容到/etc/sysctl.conf文件里：
```bash
net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.eth0.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.eth0.accept_redirects = 0
```

6.运行下面的命令，从而启用新的配置
```bash
sysctl -p
```

