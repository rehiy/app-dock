# Longhorn

Longhorn 是一个开源的分布式块存储系统，用于容器化环境。它是一个云原生的存储解决方案，可以与 Kubernetes 集成，为容器提供持久化存储功能。Longhorn 提供了数据复制、快照、备份和恢复等功能，以确保数据的安全性和可靠性。Longhorn 还具有用户友好的 Web 用户界面，方便用户管理和监控存储资源。

## 安装方法

```shell
export LONGHORN_DOMAIN=longhorn.example.org
export LONGHORN_USERNAME=admin
export LONGHORN_PASSWORD=passw0rd

./kubernetes.sh
```
