---
title: "对迁移后的数据进行验证"
chapter: false
weight: 124
---

## 对迁移后的数据进行验证

在DataX把数据迁移到EMR以后，执行下面的步骤，对迁移后的数据进行验证：

1.SSH登录到EMR的master节点，确认数据已经迁移到了对应的hdfs目录下：
```bash
sudo su - hadoop
hdfs dfs -ls /user/hive/warehouse/demodw.db/bank_data
```

2.执行Hive查询，确认能够正常读出数据：
```bash
sudo su - hadoop
hive
use demodw;
select * from bank_data;
```

3.如果使用S3作为数据存储，则可以执行s3distcp命令，把迁移到HDFS里的数据传输到S3的bucket下。