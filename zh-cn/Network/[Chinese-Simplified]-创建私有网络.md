如果你不方便连接到外部网络，也可以选择搭建自己的私有网络。

`PlatON`支持单节点模式和集群模式运行私有网络。

设置前确保本地已经按照[PlatON安装指南](/zh-cn/basics/[Chinese-Simplified]-安装指南.md)安装好PlatON环境。

本文假设Ubuntu环境下工作目录为 `~/platon-node` ，Windows环境下工作目录为 `D:\platon-node`。注意后续均在工作目录下进行。

## 单节点环境

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

**4.生成coinbase账户，为方便测试，可以在创世区块为该账户预先分配一定的Energon**

- Windows命令行：

```
D:\platon-node> platon.exe --datadir .\data account new
Your new account is locked with a password. Please give a password. Do not forget this password.
Passphrase:
Repeat passphrase:
Address: {566c274db7ac6d38da2b075b4ae41f4a5c481d21}
```

- Ubuntu命令行：

```
$ ./platon --datadir ./data account new
Your new account is locked with a password. Please give a password. Do not forget this password.
Passphrase:
Repeat passphrase:
Address: {566c274db7ac6d38da2b075b4ae41f4a5c481d21}
```

记下生成的**Address**

**5.生成创世块配置文件`platon.json`**

在工作目录下创建创世区块文件，拷贝以下内容，修改 `your-node-pubkey` 为第1步生成的 ***节点ID*** ，`your-node-blspubkey` 为第2步生成的 ***节点bls公钥*** ，使本地节点成为共识节点参与共识。修改 `your-account-address` 为第4步生成的 ***Address***。`platon.json`内容如下：

```
{
    "config": {
        "chainId": 299,
        "eip155Block": 1,
		"VMInterpreter": "evm",
        "cbft": {
			"initialNodes": [{
				"node": "enode://your-node-pubkey@127.0.0.1:16789",
				"blsPubKey": "your-node-blspubkey"
			}],
            "amount": 10,
            "period": 20000,
            "validatorMode": "ppos"
        },
        "genesisVersion": 2048
    },
    "economicModel":{
        "common":{
            "maxEpochMinutes":360,
            "maxConsensusVals":25,
            "additionalCycleTime":525960
        },
        "staking":{
            "stakeThreshold": 1000000000000000000000000,
            "operatingThreshold": 10000000000000000000,
            "maxValidators": 101,
            "unStakeFreezeDuration": 28
        },
        "slashing":{
           "slashFractionDuplicateSign": 10,
           "duplicateSignReportReward": 50,
           "maxEvidenceAge":27,
           "slashBlocksReward":0
        },
         "gov": {
            "versionProposalVoteDurationSeconds": 1209600‬,
            "versionProposalSupportRate": 0.667,
            "textProposalVoteDurationSeconds": 1209600‬,
            "textProposalVoteRate": 0.5,
            "textProposalSupportRate": 0.667,          
            "cancelProposalVoteRate": 0.50,
            "cancelProposalSupportRate": 0.667,
            "paramProposalVoteDurationSeconds": 1209600‬,
            "paramProposalVoteRate": 0.50,
            "paramProposalSupportRate": 0.667      
        },
        "reward":{
            "newBlockRate": 50,
            "platonFoundationYear": 10 
        },
        "innerAcc":{
            "platonFundAccount": "0xBE0af016941Acaf08Bf5f4ad185155Df6B7388ce",
            "platonFundBalance": 0,
            "cdfAccount": "0x08b2320Ef2482f0a5ad9411CCB1a748BcE7c2823",
            "cdfBalance": 331811981000000000000000000
        }
    },
    "nonce": "0x0376e56dffd12ab53bb149bda4e0cbce2b6aabe4cccc0df0b5a39e12977a2fcd23",
    "timestamp": "0x5bc94a8a",
    "extraData": "0xd782070186706c61746f6e86676f312e3131856c696e757800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "gasLimit": "4712388",
    "alloc": {
        "1000000000000000000000000000000000000003": {
            "balance": "200000000000000000000000000"
        },
        "your-account-address": {
		  "balance": "999000000000000000000"
		}
    },
    "number": "0x0",
    "gasUsed": "0x0",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000"
}
```


**6.根据创世配置文件初始化创世信息**

- Windows命令行：

```
D:\platon-node> platon.exe --datadir .\data init platon.json
```

- Ubuntu命令行：

```
$ ./platon --datadir ./data init platon.json
```
出现以下提示说明初始化创世信息完成。

```
Successfully wrote genesis state
```

**7.启动节点**

- Windows命令行：

```
D:\platon-node> platon.exe --identity "platon" --datadir .\data --port 16789 --rpcaddr 0.0.0.0 --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodiscover --nodekey ./data/nodekey --cbft.blskey ./data/blskey
```

- Ubuntu命令行：

```
$ ./platon --identity "platon" --datadir ./data --port 16789 --rpcaddr 0.0.0.0 --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodiscover --nodekey ./data/nodekey --cbft.blskey ./data/blskey
```

***提示：***

| 选项 | 描述 |
| :------------ | :------------ |
| --identity | 指定网络名称 |
| --datadir  | 指定data目录路径 |
| --rpcaddr  | 指定rpc服务器地址 |
| --rpcport  | 指定rpc协议通信端口 |
| --rpcapi   | 指定节点开放的rpcapi名称 |
| --rpc      | 指定http-rpc通讯方式 |
| --nodiscover | 不开启节点发现功能 |
| --nodekey    | 指定节点私钥文件         |
| --cbft.blskey| 指定节点bls私钥文件      |

此时在标准输出中出现 blockNumber 增长的日志记录，**表示共识成功，链成功启动，并成功出块**。

至此我们就搭建好了一个拥有单节点的 PlatON 私有网络。网络名称为 `platon`， 网络 `ID` 为`100`，你可以在你的私有 `PlatON` 网络中像在公网一样的单节点中执行任何操作。

**8.后台不挂起运行**
一般情况下，platon 进程一直在前台进行，这样我们就不能进行其他操作了，并且如果中途退出该终端，程序将退出。

Ubuntu下以nohup方式启动程序：

```
$ nohup ./platon --identity "platon" --datadir ./data --port 16789 --rpcaddr 0.0.0.0 --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodiscover --nodekey ./data/nodekey --cbft.blskey ./data/blskey &
```
当shell中提示nohup成功后再按下一次回车，确保不会因为误关闭终端引起的进程退出。

**Windows不支持后台运行。**

## PlatON 集群环境

`PlatON集群`是有多节点参与的网络环境，这里我们假设你已经可以构建一个PlatON单节点。并且，我们将构建的是两个节点组成的网络。更多的节点在操作流程上类似。

为了在本地运行PlatON多节点，你要确保：

- 每个节点实例拥有单独的data目录（--datadir）

- 每个实例运行在不同的端口上，不管是p2p端口还是rpc端口（--port and --rpcport ）

- 节点必须知道对方的存在

- IPC-RPC服务器要么禁止，要么唯一


**1.在platon-node目录下创建目录data0和data1，作为两个节点的数据目录。分别生成两个节点的coinbase账户。**

- Windows命令行：

```
D:\platon-node> mkdir data0
D:\platon-node> platon.exe --datadir .\data0 account new
Your new account is locked with a password. Please give a password. Do not forget this password.
Passphrase:
Repeat passphrase:
Address: {9a568e649c3a9d43b7f565ff2c835a24934ba447}

D:\platon-node> mkdir data1
D:\platon-node> platon.exe --datadir .\data1 account new
Your new account is locked with a password. Please give a password. Do not forget this password.
Passphrase:
Repeat passphrase:
Address: {ce3a4aa58432065c4c5fae85106aee4aef77a115}
```

- Ubuntu命令行：

```
$ mkdir -p data0
$ ./platon --datadir ./data0 account new
Your new account is locked with a password. Please give a password. Do not forget this password.
Passphrase:
Repeat passphrase:
Address: {9a568e649c3a9d43b7f565ff2c835a24934ba447}

$ mkdir -p data1
$ ./platon --datadir ./data1 account new
Your new account is locked with a password. Please give a password. Do not forget this password.
Passphrase:
Repeat passphrase:
Address: {ce3a4aa58432065c4c5fae85106aee4aef77a115}
```

**2.运行公私钥对生成工具`keytool`分别为两个节点生成节点ID和节点公私钥**

- Windows命令行：

```
D:\platon-node> keytool.exe genkeypair
Address   :  0xA9051ACCa5d9a7592056D07659f3F607923173ad
PrivateKey:  1abd1200759d4693f4510fbcf7d5caad743b11b5886dc229da6c0747061fca36
PublicKey :  8917c748513c23db46d23f531cc083d2f6001b4cc2396eb8412d73a3e4450ffc5f5235757abf9873de469498d8cf45f5bb42c215da79d59940e17fcb22dfc127

D:\platon-node> keytool.exe genkeypair
Address   :  0x41779B2B955E87eB44660d08AEad5568b16Cc447
PrivateKey:  80916ad05af8b7ddfda2fe89b04bce2c25c40099bb63fbc116f24caa5edc9c07
PublicKey :  4767b5a1f2d1da11dbb56aef3966a8ab1cc2a797299502f58eadd255e1012f9d540152dcd5e2383cc72350eecb7861c1823b3ae852b32ebf800f4e5d0ad014eb
```

- Ubuntu命令行：

```
$ chmod u+x keytool
$ ./keytool genkeypair
Address   :  0x95F06fC7569480544496e26a3189Ab1A78Ee9EdE
PrivateKey:  929ecf7473affebc19aeefdac2e0f2d467258bbf3acd15f3813c839bce85841d
PublicKey :  9dffb94030feaefcbf24bc2e7911827b5ed8b481bf5bd6d86e2f7ceed242fdebed9f612f0eee6ba7bc2434f93fdde651e99a60766bef6f63e80e6974a0e0450d

$ ./keytool genkeypair
Address   :  0x733Db51deB88ca61719a44D84E12DAb5d2E4046F
PrivateKey:  19f4d03ef056b6c29863fadc7a0d16dbeb0c4cd321a88c86fd9309bb6d25fa90
PublicKey :  35b0af48bd75507a2fb6a942fc11cea885ef8c8178fb20332c3816dbb5871d5090e2a5606eb7816f6b89aa9e90e79d6766467642d0308f3677f953f6a0cb76d6
```
PublicKey是我们需要的 ***节点ID***， PrivateKey是对应的 ***节点私钥*** 。

**3.运行公私钥对生成工具`keytool`分别为两个节点生成bls公私钥**

- Windows命令行：

```
D:\platon-node> keytool.exe genblskeypair
PrivateKey:  35c09aee82a98338f730277582ff669e68ca5fc20693e4c461ac254e17aebf06
PublicKey :  319aba31213ce8935b1f2758d9ebf7b01ec97dc857e8a5f6418e59f9914f1e59b49911446bc8c5383173d7c696a1d204c946ef54bafed9cdd0d1d3c3c12becca7b73f97afd9e30c1814b403d97d5f7f93c65332771491d94ca018e2e256b2314

D:\platon-node> keytool.exe genblskeypair
PrivateKey:  c8000c7579847708c36187aa58a45da8026072f5fa040a2c9ff2146ffe45520f
PublicKey :  3808951b91810044be69ad5d74385f4e0a49c0d4f6632cba6402d627f7be70ea9e7326c502a148b27107fbfc6cefe70287faafe0dd2dc272a40b8c8e56bdd3d63e71947c2fe9add15296ab39dd70e692327e24855c3faaa42e60a8bb25e6518d
```

- Ubuntu命令行：

```
$ chmod u+x keytool
$ ./keytool genblskeypair
PrivateKey:  3efd76151a22b272d0aa41da8c413ad310588279aaa7a3becc8419d94c0f3014
PublicKey :  3213a99d1bc4fd4db7297af41ef2bfe456e43ad9a77246c5b584f8a0f772b64d800054e1f9a8ffda4e3b9812c6629109d763e07d8497727a5a4f68fcd3b4f5d6b0b99892bf6f2d974de506246dd377067b4f74d8bd7ef11136bc57b56ebf4c81

$ ./keytool genblskeypair
PrivateKey:  5315ced612a3c71fa1fdcca4eef33120dbfc93aa78dccf225b9eeb75db4ac40b
PublicKey :  c324c815f587b35e16be0f60aab0a05f21a0271f16217942bda32e4b0ecb0e96270270bc3629293500f1dbf7d2ad6e10a37e9cfaabef1b302fb2fa6108272f1d3451631a91ccf284dee235c824c06b77660b0c8a82f15ddd943cb2c5b017d611
```

PublicKey是我们需要的 ***节点bls公钥***， PrivateKey是对应的 ***节点bls私钥*** 。

**4.分别为两个节点生成节点私钥文件nodekey，节点bls私钥文件blskey**，文件分别放在节点0的./data0目录和节点1的./data1目录

注意echo命令行参数为节点私钥、bls私钥，需要替换成第2步生成的 ***节点私钥*** 和第3步生成的 ***节点bls私钥*** 。

- Windows命令行：

```
D:\platon-node> echo 1abd1200759d4693f4510fbcf7d5caad743b11b5886dc229da6c0747061fca36 > .\data0\nodekey
D:\platon-node> type .\data0\nodekey
D:\platon-node> echo 35c09aee82a98338f730277582ff669e68ca5fc20693e4c461ac254e17aebf06 > .\data0\blskey
D:\platon-node> type .\data0\blskey

D:\platon-node> echo 80916ad05af8b7ddfda2fe89b04bce2c25c40099bb63fbc116f24caa5edc9c07 > .\data1\nodekey
D:\platon-node> type .\data1\nodekey
D:\platon-node> echo c8000c7579847708c36187aa58a45da8026072f5fa040a2c9ff2146ffe45520f > .\data1\blskey
D:\platon-node> type .\data1\blskey
```

- Ubuntu命令行：

```
$ echo "929ecf7473affebc19aeefdac2e0f2d467258bbf3acd15f3813c839bce85841d" > ./data0/nodekey
$ cat ./data0/nodekey
$ echo "3efd76151a22b272d0aa41da8c413ad310588279aaa7a3becc8419d94c0f3014" > ./data0/blskey
$ cat ./data0/blskey

$ echo "19f4d03ef056b6c29863fadc7a0d16dbeb0c4cd321a88c86fd9309bb6d25fa90" > ./data1/nodekey
$ cat ./data1/nodekey
$ echo "5315ced612a3c71fa1fdcca4eef33120dbfc93aa78dccf225b9eeb75db4ac40b" > ./data1/blskey
$ cat ./data1/blskey
```

**5.修改创世块配置文件`platon.json`。**

将两个节点的节点信息加入 **initialNodes** 数组中，因为我们生成的是两个节点组成的集群环境，所以数组长度为2。
需要修改`platon.json`文件：

- `node0-pubkey`为步骤2生成的节点0的 ***节点ID*** 

- `node1-pubkey`为步骤2生成的节点1的 ***节点ID*** 

- `node0-account-address`为步骤1生成的节点0的 ***Address***

- `node1-account-address`为步骤1生成的节点1的 ***Address***

```
……
  "cbft": {
  "initialNodes": [{
		"node": "enode://node0-pubkey@127.0.0.1:16789",
		"blsPubKey": "node0-blspubkey"
	},{
		"node": "enode://node1-pubkey@127.0.0.1:16790",
		"blsPubKey": "node1-blspubkey"
	}],
	……
  "alloc": {
    "node0-account-address": {
      	"balance": "999000000000000000000"
    },
    "node1-account-address": {
      	"balance": "999000000000000000000"
    },
    "1000000000000000000000000000000000000003": {
		"balance": "200000000000000000000000000"
	}
  },
……
```

**6.为节点0初始化创世块信息，拉起节点0**

- Windows命令行：

```
D:\platon-node> platon.exe --datadir .\data0 init platon.json
D:\platon-node> platon.exe --identity "platon" --datadir .\data0 --port 16789 --rpcaddr 0.0.0.0 --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodiscover --nodekey ./data0/nodekey --cbft.blskey ./data0/blskey
```

- Ubuntu命令行：

```
$ ./platon --datadir ./data0 init platon.json
$ ./platon --identity "platon" --datadir ./data0 --port 16789 --rpcaddr 0.0.0.0 --rpcport 6789 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodiscover --nodekey ./data0/nodekey --cbft.blskey ./data0/blskey
```

**7.为节点1初始化创世块信息，拉起节点1**

- Windows命令行：

```
D:\platon-node> platon.exe --datadir .\data1 init platon.json
D:\platon-node> platon.exe --identity "platon" --datadir .\data1 --port 16790 --rpcaddr 0.0.0.0 --rpcport 6790 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodiscover --nodekey ./data1/nodekey --cbft.blskey ./data1/blskey
```
在Windows下除第一个节点外，其他节点都需要使用--ipcdisable启动。

- Ubuntu命令行：

```
$ ./platon --datadir ./data1 init platon.json
$ ./platon --identity "platon" --datadir ./data1 --port 16790 --rpcaddr 0.0.0.0 --rpcport 6790 --rpcapi "db,platon,net,web3,admin,personal" --rpc --nodiscover --nodekey ./data1/nodekey --cbft.blskey ./data1/blskey
```

**8.当两个节点都提示共识成功，区块插入到链，则集群环境启动成功。**

**9.不挂起运行**

像单节点一样，为使程序在Linux平台上后台不挂起运行，可按如下方式来启动节点：

```bash
$ nohup ./platon ... --cbft.blskey ./data0/blskey >> node0.log 2>&1 &

$ nohup ./platon ... --cbft.blskey ./data1/blskey >> node1.log 2>&1 &
```

每次 nohup 执行后同样需按下回车键。