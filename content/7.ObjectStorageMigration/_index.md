---
title: "把OSS上的数据迁移到S3"
chapter: false
weight: 70
---

在本次实验中，我们会部署AWS Storage Gateway，对本地数据中心里的文件进行备份，并存储在Amazon S3上。

AWS Storage Gateway 是一项可以帮助用户实现在混合架构环境中将本地数据中心内设施与AWS云端存储进行无缝集成的服务。通过Storage Gateway可以简化本地IT环境与云端存储间移动数据，将数据存储到AWS云，并且实现备份，存档以及灾难恢复等主要功能。

AWS Storage File Gateway文件网关提供了一个文件接口，让您可以使用行业标准 NFS 文件协议将文件作为对象存储在 Amazon S3 中，并通过 NFS 从您的数据中心或 Amazon EC2 访问这些文件。当对象传输到 S3 之后，它们可以作为原生 S3 对象进行管理，版本控制、生命周期管理和跨区域复制等存储桶策略将直接应用于存储在存储桶中的对象。 

客户端使用文件网关 NFS 接口将文件数据存储到 S3 中，这些数据便可以供基于对象的工作负载使用，用作传统备份应用程序的经济高效的存储目标，或者用作应用程序文件存储的云端存储库或存储层。文件存储网关服务使用分段并行上传等技术，优化了网关与 AWS 之间的数据传输，以更好利用可用带宽。与缓存卷类似，系统维护本地缓存以提供对最近访问数据的低延迟访问，并减少数据传出成本。

Stroage Gateway的整体方案如下图：
![](/images/SetupStorageGW/storagegw-overview.png)

本次实验中，我们会进行如下的操作：

* 准备工作

* 在本地数据中心中使用AWS Storage Gateway作为NAS存储，进行文件备份

* 在AWS平台上，对AWS Storage Gateway备份的文件进行恢复

