# Application Dock

## 使用方法

- 将需要安装的应用目录上传到服务器
- 编辑 `config`，修改环境变量的为你需要的信息
- 运行 `./docker.sh` 或 `./kubernets.sh` 安装应用

## 设置亲和性

若K8s集群未启用云原生存储，当部署需要持久存储的应用时，可以考虑使用亲和性设置来将pod分配到固定的节点，以防止pod迁移。这样做可以避免因pod迁移而引起的不可用问题。详细信息可以在 [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity) 文档中找到。

这种方法对于需要持久存储的应用（如MySQL和MongoDB等）非常关键，虽然这可能会降低pod的可迁移性，但至少能确保不会因为pod迁移而导致不可用。在集群中使用本地存储可能会对可靠性和可扩展性产生重大影响；但与此同时，它也带来了一些附加好处，如最大程度地提高IO性能、简化集群存储管理等。

将下面的`affinity`片段插入到你的**Deployment**配置中，既可以实现亲和性设置。

```yaml
kind: Deployment
# 省略一些配置 #
spec:
  # 省略一些配置 #
  template:
    # 省略一些配置 #
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: kubernetes.io/hostname
                    operator: In
                    values:
                      - cvrw # 填写要绑定的节点主机名
```

## 支持的应用

| 名称                             | 描述                  | Docker | Kubernetes | 备注                            |
| -------------------------------- | --------------------- | ------ | ---------- | ------------------------------- |
| [grafpro](./grafpro/README.md)   | Granfana + Prometheus | √      | √          |                                 |
| [longhorn](./longhorn/README.md) | 云原生存储            | ×      | √          | https://www.rehiy.com/post/404/ |
| [mysql5](./mysql5/README.md)     | 关系数据库 MySQL v5   | √      | √          |                                 |
| [mysql8](./mysql8/README.md)     | 关系数据库 MySQL v8   | √      | √          |                                 |
| [typecho](./typecho/README.md)   | PHP 开源博客系统      | √      | √          |                                 |
