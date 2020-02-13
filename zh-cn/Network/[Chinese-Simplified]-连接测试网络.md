> 贝莱世界测试网络现已开放，用户可以加入测试网络进行开发、调试和测试节点。

本章节将说明如何让本地节点加入到测试网络。

设置前确保本地已经按照[PlatON安装指南](/zh-cn/basics/[Chinese-Simplified]-安装指南.md)安装好PlatON环境。

本文假设Ubuntu环境下工作目录为 `~/platon-node` ，Windows环境下工作目录为 `D:\platon-node`。注意后续均在工作目录下进行。


## 生成节点ID、节点公私钥和节点bls公私钥

**1.运行公私钥对生成工具`keytool`生成节点ID和节点公私钥**

- Windows命令行：

```
D:\platon-node> keytool.exe genkeypair
Address   :  0xA9051ACCa5d9a7592056D07659f3F607923173ad
PrivateKey:  1abd1200759d4693f4510fbcf7d5caad743b11b5886dc229da6c0747061fca36
PublicKey :  8917c748513c23db46d23f531cc083d2f6001b4cc2396eb8412d73a3e4450ffc5f5235757abf9873de469498d8cf45f5bb42c215da79d59940e17fcb22dfc127
```

- Ubuntu命令行：

```
$ chmod u+x keytool
$ ./keytool genkeypair
Address   :  0x95F06fC7569480544496e26a3189Ab1A78Ee9EdE
PrivateKey:  929ecf7473affebc19aeefdac2e0f2d467258bbf3acd15f3813c839bce85841d
PublicKey :  9dffb94030feaefcbf24bc2e7911827b5ed8b481bf5bd6d86e2f7ceed242fdebed9f612f0eee6ba7bc2434f93fdde651e99a60766bef6f63e80e6974a0e0450d
```

PublicKey是我们需要的 ***节点ID***， PrivateKey是对应的 ***节点私钥*** 。

**2.运行公私钥对生成工具`keytool`生成节点bls公私钥**

- Windows命令行：

```
D:\platon-node> keytool.exe genblskeypair
PrivateKey:  35c09aee82a98338f730277582ff669e68ca5fc20693e4c461ac254e17aebf06
PublicKey :  319aba31213ce8935b1f2758d9ebf7b01ec97dc857e8a5f6418e59f9914f1e59b49911446bc8c5383173d7c696a1d204c946ef54bafed9cdd0d1d3c3c12becca7b73f97afd9e30c1814b403d97d5f7f93c65332771491d94ca018e2e256b2314
```

- Ubuntu命令行：

```
$ chmod u+x keytool
$ ./keytool genblskeypair
PrivateKey:  3efd76151a22b272d0aa41da8c413ad310588279aaa7a3becc8419d94c0f3014
PublicKey :  3213a99d1bc4fd4db7297af41ef2bfe456e43ad9a77246c5b584f8a0f772b64d800054e1f9a8ffda4e3b9812c6629109d763e07d8497727a5a4f68fcd3b4f5d6b0b99892bf6f2d974de506246dd377067b4f74d8bd7ef11136bc57b56ebf4c81
```

PublicKey是我们需要的 ***节点bls公钥***， PrivateKey是对应的 ***节点bls私钥*** 。

**3.生成节点私钥文件nodekey，节点bls私钥文件blskey**

注意echo命令行参数为节点私钥、bls私钥，需要替换成第1步生成的 ***节点私钥*** 和第2步生成的 ***节点bls私钥*** 。

- Windows命令行：

```
D:\platon-node> echo 1abd1200759d4693f4510fbcf7d5caad743b11b5886dc229da6c0747061fca36 > .\data\nodekey
D:\platon-node> type .\data\nodekey
D:\platon-node> echo 35c09aee82a98338f730277582ff669e68ca5fc20693e4c461ac254e17aebf06 > .\data\blskey
D:\platon-node> type .\data\blskey
```

- Ubuntu命令行：

```
$ echo "929ecf7473affebc19aeefdac2e0f2d467258bbf3acd15f3813c839bce85841d" > ./data/nodekey
$ cat ./data/nodekey
$ echo "3efd76151a22b272d0aa41da8c413ad310588279aaa7a3becc8419d94c0f3014" > ./data/blskey
$ cat ./data/blskey
```

## 创建钱包账户

通过`Platon`命令，可创建账户:

- Windows命令行

```
D:\platon-node> mkdir data
D:\platon-node> platon.exe --datadir .\data account new
Your new account is locked with a password. Please give a password. Do not forget this password.
Passphrase:
Repeat passphrase:
Address: {550ae58b051a8e942f858ef22019c1c622292f7e}
```

- Linux命令行：

```
$ mkdir -p data
$ ./platon --datadir ./data account new
Your new account is locked with a password. Please give a password. Do not forget this password.
Passphrase:
Repeat passphrase:
Address: {550ae58b051a8e942f858ef22019c1c622292f7e}
```

输出结果为生成的账户地址。

## 申请测试Energon

使用第一步生成的账户地址在[PlatON官网](https://developer.platon.network/#/energon?lang=zh)申请测试Energon。

***注意：测试Energon没有任何价值，仅限于体验测试网络功能。如仅仅只是连接测试网络，无需申请！***


## 启动本地节点并连接测试网络
 
- Windows命令行

```
D:\platon-node> platon.exe --identity platon --datadir .\data --port 16789 --testnet --rpcport 6789 --rpcapi "db,eth,net,web3,admin,personal" --rpc --debug --nodekey ./data/nodekey --cbft.blskey ./data/blskey --verbosity 3 --rpcaddr 0.0.0.0  --syncmode "full" --gcmode "archive" 
```

- Linux命令行

```
$ ./platon --identity platon --datadir ./data --port 16789 --testnet --rpcport 6789 --rpcapi "db,eth,net,web3,admin,personal" --rpc --debug --nodekey ./data/nodekey --cbft.blskey ./data/blskey --verbosity 3 --rpcaddr 0.0.0.0  --syncmode "full" --gcmode "archive" 
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
| --testnet    | 指定连接到测试网络          |

更多参数意义通过`platon --help`命令查看。

## 查看是否添加成功

**1.通过`http`方式进入`platon`控制台**

- Windows命令行

```
D:\platon-node> platon.exe attach http://localhost:6789
```

- Linux命令行：

```
$ ./platon attach http://localhost:6789
```


**2.查看节点列表是否添加测试网络**

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

节点列表中出现一系列测试网络节点，则表示连接成功！