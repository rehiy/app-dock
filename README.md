# Application Dock

## 设置亲和性

若K8s集群未启用云原生存储，部署需要持久存储的应用时，可以使用亲和性设置将pod指派给固定的节点，以防止pod迁移。参考文档 [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity)。

这对于MySQL、MongoDB等应用来说是很重要的，虽然损失了pod的可迁移性，但至少能防止pod迁移导致的不可用。使用本地存储对可靠性、可扩展性有着致命的负担，但也能带来一些额外的好处，比如可以最大限度的保证IO性能、简化集群存储管理等。

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
