归档节点会保存完整state和receipt的历史数据，非归档节点会定时清除state和receipt的历史数据，只能保存最近10个块的相应数据，如节点有查询历史数据的需求，节点在启动时需要开启归档模式。

## 概述
节点默认启动时会定时清除state和receipt的历史数据，只能保存最近10个块的相应数据。

假设当前块高为120，进入platon控制台，查询账户0x1000000000000000000000003在100块高时的账户余额:
```
 platon.getBalance('0x1000000000000000000000003'，100)
```
返回信息如下:
```
Error: missing trie node f7e7f0f53eb6dc23d18f8285553c916fdd410e484b611d53883e2a060e7926f8 (path )
```

如节点有查询历史数据的需求，节点在启动时需要开启归档模式，启动后不会去删除实时产生的state和receipt的历史数据。
开启归档模式后查询账户余额信息如下:
```
 platon.getBalance('0x1000000000000000000000003'，100)
```
返回信息如下:
```
1000000000000000
```

> [!NOTE|style:flat|label:注意]
>
> 归档模式的开启相对不开启会使磁盘的占用量提高约3倍左右。

本节描述如何操作成为归档节点。

##  操作步骤

按顺序完成以下步骤：

### 同步时间
验证节点的时间需要保持正确，因此需要和时间服务器实时同步，以Ubuntu系统为例，说明如何进行时间同步

#### 安装NTP(自动同步)

安装ntp，并且设置开机自启
```bash
sudo apt-get -y install ntp  &&  sudo systemctl enable ntp
```

#### 查看同步情况
输入以下命令查看同步情况
```bash
ntpq -p
```
返回

![ntpq返回](时钟同步.assets/ntpq.png)


###  安装节点
节点服务器须为Ubuntu 18.04，请按照[安装节点](zh-cn/Node/_[Chinese-Simplified]-安装节点.md)中Ubuntu的部分进行操作。

### 生成节点密钥与共识密钥
节点在启动时需要节点公私钥与BLS公私钥，BLS公私钥在共识协议中将被使用。
密钥生成方式参照[节点密钥](/zh-cn/Node/_[Chinese-Simplified]-钱包文件与节点密钥#节点密钥),将生成的密钥转移到节点所在目录。

> [!NOTE|style:flat|label:注意]
>
>  如果没有预先生成密钥，节点在启动时自动在节点的data目录下生成。

### 启动节点加入网络
根据用户自身需要，启动节点，选择加入公有网络，或者加入私有网络，操作见文档：
- [加入私有网络](zh-cn/Network/[Chinese-Simplified]-创建私有网络.md)
- [加入公有网络](zh-cn/Network/[Chinese-Simplified]-连接公有网络.md)

> [!NOTE|style:flat|label:注意]
>
> 启动节点加入网络时在命令行中加入--db.nogc
