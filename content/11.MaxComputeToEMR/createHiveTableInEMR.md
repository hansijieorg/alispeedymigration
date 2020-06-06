---
title: "在Amazon EMR集群里创建Hive表"
chapter: false
weight: 112
---

## 在Amazon EMR集群里创建Hive表

在EMR里执行下面的步骤，创建Hive表，从而对应MaxCompute里的bank_data表：

1.登录到你预先建好的EMR集群的master节点。

2.执行下面的命令：
```bash
sudo su - hadoop
hive
create database demodw;
use demodw;
CREATE TABLE IF NOT EXISTS bank_data
(
 age             BIGINT ,
 job             STRING ,
 marital         STRING ,
 education       STRING ,
 default         STRING ,
 housing         STRING ,
 loan            STRING ,
 contact         STRING ,
 month           STRING ,
 day_of_week     STRING ,
 duration        STRING ,
 campaign        BIGINT ,
 pdays           DOUBLE ,
 previous        DOUBLE ,
 poutcome        STRING ,
 emp_var_rate    DOUBLE ,
 cons_price_idx  DOUBLE ,
 cons_conf_idx   DOUBLE ,
 euribor3m       DOUBLE ,
 nr_employed     DOUBLE ,
 y               BIGINT 
)ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;
```

3.执行下面的命令，确保bank_data表对应的HDFS目录已经创建出来：
```bash
hdfs dfs -ls /user/hive/warehouse/demodw.db/bank_data
```
