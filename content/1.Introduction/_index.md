---
title: "整体实验介绍"
chapter: false
weight: 10
---

{{% notice note %}}
如果你已经对整个实验有所了解，则可以跳过当前部分，而进入下一个步骤。否则，建议请阅读本部分，了解整个实验的目的以及所需要进行的步骤。
{{% /notice  %}}

## Use Scenario 

本次实验中，模拟了部署在阿里云上的三个应用，并把这些应用迁移到了AWS平台上。

* 一套部署在虚拟机里的三层架构的应用系统

* 一套基于容器化的应用系统

* 一套部署在Blink上的实时数据处理系统


本次实验环节包括：

1.在阿里云中部署Wordpress应用系统，基于容器化的应用系统，以及Blink上的实时数据处理系统。

2.以宁夏region为目标站点，部署Landing Zone，包括VPC、子网、安全组

3.搭建Site-To-Site VPN

3.部署CloudEndure，对应用服务器进行迁移

4.部署AWS DMS，对数据库进行迁移

5.把OSS里的文件迁移到到Amazon S3上

6.系统切割

7.把部署在ACK上容器应用迁移到EKS上（可选）

8.把部署在Blink上的数据处理系统迁移到Flink on EMR上（可选）

9.把部署在MaxCompute里的数据迁移到EMR上（可选）

