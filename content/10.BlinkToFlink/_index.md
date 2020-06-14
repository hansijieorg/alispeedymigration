---
title: "迁移Blink应用到Flink on EMR (可选)"
chapter: false
weight: 100
---

## 迁移Blink应用到Flink on EMR

### 场景介绍

数据由客户端通过网络将数据流输入至服务端的Kafka集群，由Blink/Flink从Kafka主题中进行实时的数据处理，并将结果数据存储或发送至其他目的地。
本实验主要描述如何把基于Blink开发的应用系统迁移到基于Flink的系统上，不牵涉到数据的迁移。

### 实验步骤：

* 准备开发环境

* 在阿里云Blink上开发应用系统

* 把基于阿里云Blink开发的应用系统迁移到Flink