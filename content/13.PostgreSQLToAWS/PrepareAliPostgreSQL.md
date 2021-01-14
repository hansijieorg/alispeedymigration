---
title: "准备阿里云 PostgreSQL 环境"
chapter: false
weight: 121
---

## 准备阿里云 PostgreSQL 环境

在本实验，会新建一个阿里云PostgreSQL实例，并准备好测试数据。

1. 进入阿里云RDS控制台，点击「创建实例」
![](/images/PostgreSQLToAWS/1-1.png)

2. 点击「下一步：实例配置」，「下一步：确认订单」，「去支付」
![](/images/PostgreSQLToAWS/1-2.png)
![](/images/PostgreSQLToAWS/1-3.png)


3. 在控制台实例列表中，等待运行状态为「运行中」，选择「操作 - 管理」
![](/images/PostgreSQLToAWS/1-4.png)

4. 在左侧选择「账号管理 - 创建账号」，数据库账号：`aws` ，账号类型「高权限账号」，密码：`Awsaws@123`，点击「创建」
![](/images/PostgreSQLToAWS/1-5.png)

5. 在左侧选择「数据安全性 - 白名单设置 - 添加白名单分组」，分组名称：`aws`，组内白名单：`0.0.0.0/0` ，点击「确定」
![](/images/PostgreSQLToAWS/1-7.png)

6. 在左侧选择「数据库连接 - 申请外网地址」，点击「确定」
![](/images/PostgreSQLToAWS/1-6.png)

7. 在左侧选择「参数设置」，修改参数 wal_level 的运行参数值为`logical`，点击「提交参数」，点击「确认」
![](/images/PostgreSQLToAWS/1-10-0.png)

{{% notice note %}}
注意下图的确认操作会重启数据库，生产环境请在维护时间段操作
{{% /notice  %}}

![](/images/PostgreSQLToAWS/1-11.png)

8. 安装 PostgreSQL 客户端:

Mac：
```
brew doctor
brew update
brew install libpq
brew link --force libpq
```
Ubuntu、Debian：
```
sudo apt-get update
sudo apt-get install postgresql-client
```
Windows：[https://www.postgresql.org/download/windows/](https://www.postgresql.org/download/windows/)


9. 连接数据库：
`psql -h <步骤6里的外网地址> -p 1921 -U <步骤4里的用户名> -W -d postgres`

10. 执行以下命令创建测试数据
```
# 创建测试数据库，名称：aliyun
CREATE DATABASE aliyun;
\c aliyun;

# 创建两张测试表格
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name TEXT
);
CREATE TABLE orders (
    order_id SERIAL,
    dish_name TEXT,
    customer_id INTEGER REFERENCES customers (id)
);

# 插入测试数据
INSERT INTO customers (id, full_name) VALUES (1, 'Andy');
INSERT INTO orders (order_id, dish_name, customer_id) VALUES (1, 'Andy_Dish', 1);

# 确认数据结果
SELECT * FROM customers;
SELECT * FROM orders;
```