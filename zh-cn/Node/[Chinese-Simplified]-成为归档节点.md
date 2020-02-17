## 成为归档节点

### 1 归档节点概述
节点默认启动时会定时清除state和receipt的历史数据，只能保存最近10个块的相应数据。

```
当前块高为120时，无法取得账户在块高为100时的余额
> platon.getBalance('0x1000000000000000000000003'，100)
Error: missing trie node f7e7f0f53eb6dc23d18f8285553c916fdd410e484b611d53883e2a060e7926f8 (path )
```

如节点有查询历史数据的需求，节点在启动时需要开启归档模式，启动后不会去删除实时产生的state和receipt的历史数据。

```
当前块高为120时
> platon.getBalance('0x1000000000000000000000003'，100)
1000000000000000
```

注意:归档模式的开启相对不开启会使磁盘的占用量提高约3倍左右。


### 2 如何成为归档节点
节点在启动时需要在启动命令中加入参数`--db.nogc`,
启动命令参考如下:
```
platon --identity platon  --datadir $node_dir/data --port 16789 --rpc --rpcaddr 127.0.0.1 --rpcport 6789 --rpcapi platon,debug,personal,admin,net,web3,txpool --maxpeers 25 --verbosity 3 --nodekey $node_dir/data/nodekey --cbft.blskey $node_dir/data/blskey  --db.nogc
```
注：
-  $node_dir为项目所在的目录
