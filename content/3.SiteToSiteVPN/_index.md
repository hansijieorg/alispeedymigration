---
title: "部署阿里云和AWS之间的VPN"
chapter: false
weight: 30
---

## 部署阿里云和AWS之间的VPN

本次实验会在AWS宁夏region部署实验环境的基础架构，部署过程中，会在AWS Landing Zone的理念下，以符合AWS最佳实践的方式部署基础架构。本次实验包括两部分：

* 把AWS的网络和阿里云的网络打通。

### 先进行如下的准备工作：
 左对齐标题 | 阿里云 | AWS |
| :------| :------ | :------ |
| VPC CIDR | 10.0.0.0/24 | 192.168.0.0/24 |
| VPN Instance Private IP | 10.0.0.5 | 192.168.0.5 |
| VPN Instance Public IP | x | y |

公网IP后期创建好instance后获得，目前用x和y代替。

### 配置过程
1. AWS上的VPN实例操作系统为Amazon Linux 2，并禁用source/destination检查。
2. AWS的VPN实例的安全组为SGBastionVPN
3. 阿里云的VPN实例的操作系统为Centos 8.0，不要选安全加固。
4. 为阿里云的VPN实例的安全组添加下图所示的规则：
- Ingress udp 500 0.0.0.0/0
- Ingress udp 4500 0.0.0.0/0
5. 在阿里云的私有子网里添加一条路由条目，目标网段为AWS的VPC CIDR，下一跳为OpenSwan虚拟机的实例id
6. AWS的路由已经由cloudformation做好

### 在阿里云虚机上的配置：
1) yum install -y epel-release
2) yum install -y libreswan
3) yum install -y python2
4) ln -s /usr/bin/python2 /usr/bin/python
5) vi /etc/ipsec.conf
```
5.1) 确保include /etc/ipsec.d/*.conf前面没有注释符
5.2) 确保logfile=/var/log/pluto.log 前面没有注释符
```
6) vi /etc/ipsec.d/nettonet.conf，并添加如下的内容
```
conn nettonet
        authby=secret
        auto=start
        leftid=39.98.193.226   <--阿里云VPN虚拟机的公网ip
        left=%defaultroute
        leftsubnet=10.0.0.0/24  <--阿里云VPC CIDR
        leftnexthop=%defaultroute
        rightid=ZHY
        right=52.83.126.30  <--AWS VPN虚拟机的公网ip
        rightsubnet=192.168.0.0/24  <--AWS VPC CIDR
        keyingtries=%forever
        ike=aes128-sha1;modp1024
        ikelifetime=86400s
        phase2alg=aes128-sha1
        salifetime=3600s
        pfs=no
```
7) vi /etc/ipsec.d/nettonet.secrets，并添加如下的内容
```
39.98.193.226 52.83.126.30: PSK "aws123"
```
这里的aws123表示密钥密码，可以是任何值。
8) vi /etc/sysctl.conf，并添加如下内容：
```
net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.eth0.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.eth0.accept_redirects = 0
```
9)运行sysctl -p从而启用新的配置


在AWS instance的配置：

在AWS的OpenSwan EC2里执行类似的操作：
1) yum install -y openswan
2) vi /etc/ipsec.conf
```
2.1) 确保include /etc/ipsec.d/*.conf前面没有注释符
2.2) 确保logfile=/var/log/pluto.log 前面没有注释符
```
3) vi /etc/ipsec.d/nettonet.conf，并添加如下的内容
```
conn nettonet
            authby=secret
            auto=start
            leftid=52.83.126.30  <--AWS VPN虚拟机的公网ip
            left=%defaultroute
            leftsubnet=192.168.0.0/24  <--AWS VPC CIDR
            leftnexthop=%defaultroute
            rightid=ALI
            right=39.98.193.226   <--阿里云VPN虚拟机的公网ip
            rightsubnet=10.0.0.0/24  <--阿里云VPC CIDR
            keyingtries=%forever
            ike=aes128-sha1;modp1024
            ikelifetime=86400s
            phase2alg=aes128-sha1
            salifetime=3600s
            pfs=no
```
4) vi /etc/ipsec.d/nettonet.secrets，并添加如下的内容
```
52.83.126.30 39.98.193.226: PSK "aws123"
```
这里的aws123表示密钥密码，必须和阿里云VPN虚拟机的配置完全一样。
5) vi /etc/sysctl.conf，并添加如下内容：
```
net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.eth0.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.eth0.accept_redirects = 0
```
6)运行sysctl -p从而启用新的配置
9、在阿里云和AWS的两个VPN实例上启动OpenSwan并检查配置：
```
systemctl start ipsec
```
10、运行ipsec verify命令确认OpenSwan运行正常。

