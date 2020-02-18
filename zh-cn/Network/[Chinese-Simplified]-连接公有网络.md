## 简介

PlatON目前有2个公有网络，一个是PlatON正式上线的、独立运行的主网络，网络ID为100，另外一个是用来对开发者开放的测试网络贝莱世界，网络ID为101。

## 准备

在加入PlatON公有网络前请确保服务器本地具备以下条件：

1. 已经按照[PlatON安装指南](/zh-cn/Node/[Chinese-Simplified]-安装节点.md)安装好PlatON环境。
2. 已经按照[节点秘钥](/zh-cn/Network/[Chinese-Simplified]-环境准备.md?id=节点秘钥)章节在'~/platon-node/data'目录下生成了节点私钥和节点BLS私钥。

## 加入主网

任何人、任何组织都可以加入PlatON主网。
执行以下命令即可加入PlatON主网：

```
$ ./platon --identity platon --datadir ./data --port 16789 --main --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodekey ./data/nodekey --cbft.blskey ./data/nodeblskey --verbosity 3 --rpcaddr 0.0.0.0  --syncmode "full"
```

***提示：***

| 选项         | 描述                     |
|:------------ |:------------------------ |
| --identity   | 指定网络名称             |
| --datadir    | 指定data目录路径         |
| --rpcaddr    | 指定rpc服务器地址        |
| --rpcport    | 指定rpc协议通信端口      |
| --rpcapi     | 指定节点开放的rpcapi名称 |
| --rpc        | 指定http-rpc通讯方式     |
| --nodekey    | 指定节点私钥文件         |
| --cbft.blskey| 指定节点bls私钥文件      |
| --main       | 指定连接到主网络，可选，不指定默认运行主网络   |

更多参数意义通过`platon --help`命令查看。

当platon启动成功后，正常情况下会通过节点发现协议自动和距离自己最近的节点建立连接，连接成功后会启动区块同步，所以，判断加入网络是否成功可以通过查看节点的peers和确认当前节点块高是否增长来判断。

**1.通过`http`方式进入`platon`控制台**

```
$ ./platon attach http://localhost:6789
```

**2.查看节点列表**

```
> admin.peers
[{
    caps: ["cbft/1", "platon/62", "platon/63"],
    id: "0dd4e447cf23f4bfc94b1568bae626bf4894ce2e9d5ca474e3cc73ec7e9d4de550fffc1e2fc64cca25d42aecf6169cf8f8c0f4fe6adb847c33dc6ceb6f001bd1",
    name: "PlatONnetwork/platon/v0.8.0-unstable-c5fc6b19/linux-amd64/go1.11.11",
    network: {
      consensus: true,
      inbound: true,
      localAddress: "127.0.0.1:16789",
      remoteAddress: "127.0.0.1:47706",
      static: false,
      trusted: false
    },
    protocols: {
      cbft: {
        commitBn: 0,
        highestQCBn: 0,
        lockedBn: 0,
        protocolVersion: 1
      },
      platon: {
        head: "0x88a4fe315ce13b3010abf4ab5d120f25a21ac2ccae8ec563ad259e47e24b24bc",
        number: 0,
        version: 63
      }
    }
},
...
]
```

**3.查看当前节点块高**

```
> platon.blockNumber
2235
>
```
节点列表中出现一系列主网络节点并且块高在不断增长，则表示连接成功！


## 加入贝莱世界

任何人、任何组织都可以加入PlatON主网。

执行以下命令即可加入PlatON主网：

```
$ ./platon --identity platon --datadir ./data --port 16789 --testnet --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodekey ./data/nodekey --cbft.blskey ./data/nodeblskey --verbosity 3 --rpcaddr 0.0.0.0  --syncmode "full"
```

与加入主网不同的是，加入贝莱世界的启动参数中将'--main'替换为'--testnet’， 同样，用上述主网同样的方式可以验证加入测试网络是否成功。

使用[之前](/zh-cn/Network/[Chinese-Simplified]-环境准备.md?id=钱包文件)生成的账户地址在[PlatON官网](https://developer.platon.network/#/energon?lang=zh)申请测试Energon。

***注意：测试Energon没有任何价值，仅限于体验测试网络功能。如仅仅只是连接测试网络，无需申请！***
