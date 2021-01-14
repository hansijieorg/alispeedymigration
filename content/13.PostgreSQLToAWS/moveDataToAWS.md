---
title: "运行逻辑复制进行数据迁移"
chapter: false
weight: 123
---

## 运行逻辑复制进行数据迁移



1. 登录阿里云数据库：
`psql -h <阿里云数据库外网地址> -p 1921 -U <数据库用户名> -W -d aliyun`

2. 设置阿里云数据库 PUBLICATION：
```
CREATE PUBLICATION pub_orders FOR TABLE orders;
CREATE PUBLICATION pub_customers FOR TABLE customers;
```

3. 登录AWS数据库：
`psql -h <AWS数据库终端节点> -p 5432 -U <数据库用户名> -W -d aliyun`

4. 设置 AWS 数据库 SUBSCRIPTION：
```
CREATE SUBSCRIPTION sub_orders CONNECTION 'host=<阿里云数据库外网地址> port=1921 user=<数据库用户名> dbname=aliyun password=<数据库密码>' PUBLICATION pub_orders;
CREATE SUBSCRIPTION sub_customers CONNECTION 'host=<阿里云数据库外网地址> port=1921 user=<数据库用户名> dbname=aliyun password=<数据库密码>' PUBLICATION pub_customers;
```
