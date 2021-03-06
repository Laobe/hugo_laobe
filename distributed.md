## 粗糙的分布式理解

最近各种分布式概念层出不穷，伴随的是出现了各种分布式系统(分布式系统，分布式存储，分布式锁，分布式事务)，各种分布式算法(RAFT,PAXOS,Consistent Hash)，各种分布式理论(CAP, 高可用高性能高并发)

于是就想粗糙的整理一下自己对这些分布式的认知和理解。

### 分布式是什么

不需多想，分布式就是系统分布在多台机器上，多台机器同时提供服务。 可以在性能，可用性，动态扩容等方面都提供了一定
这样如果某台机器挂了，系统还可以提供服务

多个机器提供相同的运算服务，比如我们很常见的web服务，我们部署在多台机器上，然后可以依靠负载均衡这个唯一中心提供。这就是一个分布式系统。
然后如果运算能力不够了，我们只要再加web服务的机器，即使某台机器挂了，通过负载均衡的心跳检查，将这台机器剔除。就保证了高性能和高可用。

redis，我们平时用的是redis的单机单线程服务，redis性能足够好，可以hold一般规模的并发。但是redis也是个单线程的程序，单并发量上来后，一台机器不能很快处理所有请求时候，我们可以设计一台redis节点作为master用来接受写的任务，然后通过实时log同步给剩下的slave，这样slave节点都可以提供读的服务(当然master本身也可以提供读服务)，可能利用自己机器的计算性能分担master的压力。这就是master-slave集群，提供了高性能。

redis计算性能解决了，但是因为每台机器都是保存着同一份数据，所以redis的容量还是一台机器的内存，这样就没办法hold更大存储需求了。然后redis提供了水平扩张能力，利用slot机制，将不同的key分配到不同的redis节点上，而且随时可以加入新的节点，原分片规则也动态变更，这样就提供了扩容的能力，从内存上提供了高性能。

在计算内存都可以通过分布扩展能力的情况下，存储也需要分布式，也就是分布式存储。GFS就是一种很普遍基础的分布式存储。GFS设计为master-chunkserver架构，也是一个中心化的分布式系统。master单存的同步metadata，也就是所有的chunk与chunkserver的关联，最小化的减轻master的压力，然后具体的文件读写请求都落到对应的chunkserver上，客户端请求时先从maste获取对应的chunkserver，然后从chunkserver获取对应的chunk。




vector clock
gossip
raft
quorum
merkle tree
