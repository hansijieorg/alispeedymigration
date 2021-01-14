---
title: "准备 Amazon RDS for PostgreSQL 环境"
chapter: false
weight: 122
---

## 准备 Amazon RDS for PostgreSQL 环境

1. 登录 Amazon RDS 控制台，选择「参数组」

2. 点击「创建参数组」，参数组系列 选择 「postgres10」，组名: `aliyun-aws`, 描述：`aliyun-aws`, 点击「创建」
![](/images/PostgreSQLToAWS/2-0.png)

3. 点击创建好的参数组，修改参数 rds.logical_replication	值为 1，点击「保存修改」
![](/images/PostgreSQLToAWS/2-0-1.png)

4. 选择左侧 「数据库」，点击「创建数据库」
![](/images/PostgreSQLToAWS/2-1.png)

5. 选择「标准创建」，引擎类型「PostgreSQL」，版本「PostgreSQL 10.4-R1」，数据库实例标识符：`ali-aws`，主用户名：`aws`，密码：`Awsaws-123`，初始数据库名称: `aliyun`，数据库参数:`ali-aws`，「公开访问」选择「是」，其它配置参考下图或保持默认，点击「创建数据库」
![](/images/PostgreSQLToAWS/2-2.png)
![](/images/PostgreSQLToAWS/2-3.png)
![](/images/PostgreSQLToAWS/2-5.png)
![](/images/PostgreSQLToAWS/2-6-0.png)

6. 修改数据库VPC安全组，允许数据库的 5432 端口访问
![](/images/PostgreSQLToAWS/2-20.png)
![](/images/PostgreSQLToAWS/2-21.png)

7. 连接数据库：
`psql -h <终端节点> -p 5432 -U <步骤5里的主户名> -W -d <步骤5里的初始数据库名称>`
![](/images/PostgreSQLToAWS/2-23.png)

8. 创建数据表
```
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name TEXT
);

CREATE TABLE orders (
    order_id SERIAL,
    dish_name TEXT,
    customer_id INTEGER REFERENCES customers (id)
);
```
