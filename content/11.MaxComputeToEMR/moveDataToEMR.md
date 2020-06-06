---
title: "运行DataX进行数据迁移"
chapter: false
weight: 113
---

## 运行DataX进行数据迁移

在Linux工作服务器（已经事先安装好了DataX工具）上进行如下的配置，从而把数据从MaxCompute里迁移到EMR上：

1.登录到事先安装好了DataX工具的Linux EC2工作服务器，编辑已经准备好的odps2hdfs.json文件，并在如下所示的部分修改为符合你的信息：
```bash
vi ~/odps2hdfs.json
{
    "job": {
        "setting": {
            "speed": {
                "channel": 1
            }
        },
        "content": [
            {
                "reader": {
                    "name": "odpsreader",
                    "parameter": {
                        "accessId": "<此处填入你的阿里云RAM账号的Access Key ID>",
                        "accessKey": "<此处填入你的阿里云RAM账号的Access Key Secret>",
                        "column": [
                            "*"
                        ],
                        "odpsServer": "http://service.odps.aliyun.com/api",
                        "project": "sijiedemodw",
                        "table": "bank_data",
                        "tunnelServer": "http://dt.cn-zhangjiakou.maxcompute.aliyun.com"
                    }
                },
                "writer": {
                    "name": "hdfswriter",
                    "parameter": {
                        "defaultFS": "hdfs://<此处填入你的EMR master节点的私有IP地址>:8020",
                        "fileType": "text",
                        "path": "/user/hive/warehouse/demodw.db/bank_data",
                        "fileName": "bank_data",
                        "column":[
                           {
                               "name": "age",
                               "type": "BIGINT"
                           },
                           {
                               "name": "job",
                               "type": "STRING"
                           },
                           {
                               "name": "marital",
                               "type": "STRING"
                           },
                           {
                               "name": "education",
                               "type": "STRING"
                           },
                           {
                               "name": "default",
                               "type": "STRING"
                           },
                           {
                               "name": "housing",
                               "type": "STRING"
                           },
                           {
                               "name": "loan",
                               "type": "STRING"
                           },
                           {
                               "name": "contact",
                               "type": "STRING"
                           },
                           {
                               "name": "month",
                               "type": "STRING"
                           },
                           {
                               "name": "day_of_week",
                               "type": "STRING"
                           },
                           {
                               "name": "duration",
                               "type": "STRING"
                           },
                           {
                               "name": "campaign",
                               "type": "BIGINT"
                           },
                           {
                               "name": "pdays",
                               "type": "DOUBLE"
                           },
                           {
                               "name": "previous",
                               "type": "DOUBLE"
                           },
                           {
                               "name": "poutcome",
                               "type": "STRING"
                           },
                           {
                               "name": "emp_var_rate",
                               "type": "DOUBLE"
                           },
                           {
                               "name": "cons_price_idx",
                               "type": "DOUBLE"
                           },
                           {
                               "name": "cons_conf_idx",
                               "type": "DOUBLE"
                           },
                           {
                               "name": "euribor3m",
                               "type": "DOUBLE"
                           },
                           {
                               "name": "nr_employed",
                               "type": "DOUBLE"
                           },
                           {
                               "name": "y",
                               "type": "BIGINT"
                           }
                        ],
                        "writeMode": "append",
                        "fieldDelimiter": ",",
                        "compress":"gzip" 
                    }
                }
            }
        ]
    }
}
```

2.执行下面的命令，从而启动DataX，对MaxCompute里的bank_data的数据进行迁移。
```bash
cd /home/ec2-user/datax/bin
python datax.py ~/odps2hdfs.json
```

