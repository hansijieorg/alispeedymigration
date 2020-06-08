---
title: "在AWS VPN服务器上的配置"
chapter: false
weight: 33
---

## 在AWS VPN服务器上的配置

本次实验中，会在AWS的VPN虚机上进行如下的配置：
1.安装OpenSwan软件：
```bash
sudo su - 
yum install -y openswan
```

2.编辑ipsec.conf文件的时候，确保include /etc/ipsec.d/*.conf前面没有注释符，以及确保logfile=/var/log/pluto.log 前面没有注释符
```bash
vi /etc/ipsec.conf
```

3.编辑/etc/ipsec.d/nettonet.conf文件，添加如下的内容
```bash
vi /etc/ipsec.d/nettonet.conf
conn nettonet
            authby=secret
            auto=start
            leftid=y                    <--AWS VPN虚拟机的公网ip
            left=%defaultroute
            leftsubnet=10.0.0.0/16      <--AWS VPC CIDR
            leftnexthop=%defaultroute
            rightid=ALI
            right=x                     <--阿里云VPN虚拟机的公网ip
            rightsubnet=192.168.0.0/16  <--阿里云VPC CIDR
            keyingtries=%forever
            ike=aes128-sha1;modp1024
            ikelifetime=86400s
            phase2alg=aes128-sha1
            salifetime=3600s
            pfs=no
```

4.编辑/etc/ipsec.d/nettonet.secrets文件，添加如下的内容，这里的aws123表示密钥密码，可以是任何值。
```bash
vi /etc/ipsec.d/nettonet.secrets
y x: PSK "aws123"
```

5.编辑/etc/sysctl.conf文件，并添加如下内容。
```bash
vi /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.eth0.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.eth0.accept_redirects = 0
```

6.运行下面的命令从而启用新的配置
```bash
sysctl -p
```

7.在阿里云和AWS的两个VPN实例上启动OpenSwan并检查是否运行正常
```bash
systemctl start ipsec
ipsec verify
```