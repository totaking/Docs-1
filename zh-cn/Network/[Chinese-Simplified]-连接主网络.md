> 主网络

主网是正式上线的、独立运转的区块链网络，网络上的交易行为被社区全员认可。

`PlatON`节点默认运行在主网，本文档将说明怎么将本地`PlatON`节点和测试网络链接。

设置前确保本地已经按照[PlatON安装指南](/zh-cn/basics/[Chinese-Simplified]-安装指南.md)安装好PlatON节点。

本文假设Ubuntu环境下工作目录为 `~/platon-node` ，Windows环境下工作目录为 `D:\platon-node`。注意后续均在工作目录下进行。


## 启动本地节点并连接主网络
 
- Windows命令行

```
D:\platon-node> platon.exe --identity platon --datadir .\data --port 16789 --main --rpcport 6789 --rpcapi "db,eth,net,web3,admin,personal" --rpc --debug --verbosity 3 --rpcaddr 0.0.0.0  --syncmode "full" --gcmode "archive" 
```

- Linux命令行

```
$ ./platon --identity platon --datadir ./data --port 16789 --main --rpcport 6789 --rpcapi "db,eth,net,web3,admin,personal" --rpc --debug --verbosity 3 --rpcaddr 0.0.0.0  --syncmode "full" --gcmode "archive" 
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
| --main       | 连接到主网络，不指定默认为连接主网络   |

更多参数意义通过`platon --help`命令查看。

## 查看是否添加成功

1.通过`http`方式进入`platon`控制台

- Windows命令行

```
D:\platon-node> platon.exe attach http://localhost:6789
```

- Linux命令行：

```
$ ./platon attach http://localhost:6789
```


2.查看节点列表是否添加主网络

```
> admin.peers
[{
    caps: ["eth/62", "eth/63"],
    id: "23aa343260d06e04107d1cd9a7d12c54cc238719a1523ffe42640210c913218b5940d41511c5adb716da38844a85cdab8b7db0600d242e24168d7df10aebd324",
    name: "PlatONnetwork/V0.6_testsn/v0.6.0-stable-0f651de0/linux-amd64/go1.11",
    network: {
      consensus: false,
      inbound: false,
      localAddress: "192.168.18.181:51828",
      remoteAddress: "54.252.202.130:16789",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        head: "0x104fe03d2b2f0b783e808ea7fcd52566d7cde9f36c4a06e950795e0459db5551",
        number: 74822,
        version: 63
      }
    }
},
...
]
```

节点列表中出现一系列主网络节点，则表示连接成功！