---
title: "把OSS上的数据迁移到S3"
chapter: false
weight: 70
---

在本次实验中，我们会使用迁移工具将AliCloud OSS上的文件迁移到指定的S3存储桶中。
我们在此次试验中所使用的工具是amazon-s3-resumable-upload tool ( https://github.com/aws-samples/amazon-s3-resumable-upload )。

它本身是一个开源工具,由AWS团队开发,主要功能包括:

* 源文件的自动分片获取，多线程并发上传到目的S3再合并文件，断点续传(分片级别)。
* 支持的源：本地文件、Amazon S3、阿里云 OSS
* 支持的目的地：Amazon S3、本地文件
* 多文件并发传输，且每个文件再多线程并发传输，充分压榨带宽。S3_TO_S3 或 ALIOSS_TO_S3 中间只过中转服务器的内存，不落盘，节省时间和存储。
* 网络超时自动多次重传。重试采用递增延迟，延迟间隔=次数\*5秒。程序中断重启后自动查询S3上已有分片，断点续传(分片级别)。每个分片上传都在S3端进行MD5校验，每个文件上传完进行,分片合并时可选再进行一次S3的MD5与本地进行二次校验，保证可靠传输。
* 自动遍历下级子目录，也可以指定单一文件拷贝。
* 可设置S3存储级别，如：标准、S3-IA、Glacier或深度归档。
* 可设置输出消息级别，如设置WARNING级别，则只输出你最关注的信息

OSS迁移的的整体方案架构如下图：
![](/images/ObjectStorageMigration/arc1.png)

本次实验中，我们会进行如下的操作：

* 把数据从OSS迁移到Amazon S3

