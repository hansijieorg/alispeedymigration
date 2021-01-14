---
title: "对迁移后的数据进行验证"
chapter: false
weight: 124
---

## 对迁移后的数据进行验证

1. 登录AWS数据库：
`psql -h <AWS数据库终端节点> -p 5432 -U <数据库用户名> -W -d aliyun`

2. 执行命令查询表数据是否跟阿里云数据中保持一致
```
SELECT * FROM customers;
SELECT * FROM orders;
```