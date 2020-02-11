> PlatON开源的桌面版钱包客户端

## 什么是Samurai

**Samurai**是PlatON开源的图形化桌面版钱包客户端，支持基础的普通钱包管理，基于多重签名技术的联名钱包管理，同时为开发者提供Wasm合约的部署与运行，PlatON私有链的可视化搭建，以及基于PlatON经济模型下的共识节点注册与投票，参与PlatON生态治理等功能。未来，Samurai将持续为不同用户提供更加基础、更加丰富的应用功能，让大家更好的了解和使用PlatON生态服务。

Samurai核心功能如下：

- 搭建PlatON私有网络

- 创建钱包/导入钱包（支持使用Keystore，助记词，私钥）

- 支持联名钱包（基于多重签名技术）

- 查看钱包余额及交易明细

- 发送及提取Energon

- 合约部署与运行

- 共识节点注册与质押管理

- 参与节点投票

请注意，Samurai仍处于测试阶段，可能会出现一些问题。 本指南将帮助您解决一些最常见的问题。如有更多问题欢迎提交到[issues](https://github.com/PlatONnetwork/Docs/issues) ！

## 如何下载安装PlatON Samurai客户端

Samurai目前适用于Windows 及Ubuntu系统，下载请点击[这里](https://github.com/PlatONnetwork/Samurai/releases)。未来Samurai还会支持在MacOS系统上运行，敬请期待。

### Windows安装

Windows安装程序下载后，双击安装程序并按照说明进行操作。安装程序会在桌面上添加Samurai的快捷方式。

*注意：由于当前正处于测试阶段，底层版本更新比较大，非初次安装，请您先卸载完后再手动删除如下图所示的保存区块数据的文件夹（默认路径：C:\Users\Username\AppData\Roaming\Samurai，其中Username为您登陆PC的账号名称），然后再按照安装引导进行安装。*

<img src="zh-cn/user-interfaces/platon-samurai/image/Keystore_address-cn.png" width = "503" height="362"/>  

### Ubuntu安装

tar.xz源代码包安装说明：

1.下载Ubuntu版Samurai安装包，如：samurai-ubuntu-amd64-xxx.tar.xz（xxx表示版本）

2.右键解压安装包

3.进入解压的文件夹，双击可执行文件Samurai即可打开客户端

## 如何使用Samurai

### 网络初始化

- [如何加入PlatON测试网络](/zh-cn/user-interfaces/platon-samurai/_网络初始化.md#怎么加入platon测试网络)
- [如何创建PlatON本地私有网络](/zh-cn/user-interfaces/platon-samurai/_网络初始化.md#如何创建platon本地私有网络)

### 钱包

- [如何创建一个钱包](/zh-cn/user-interfaces/platon-samurai/_钱包.md#如何创建一个钱包)
- [如何导入/恢复一个已有的钱包](/zh-cn/user-interfaces/platon-samurai/_钱包.md#%e5%a6%82%e4%bd%95%e5%af%bc%e5%85%a5%e6%81%a2%e5%a4%8d%e4%b8%80%e4%b8%aa%e5%b7%b2%e6%9c%89%e7%9a%84%e9%92%b1%e5%8c%85)
- [如何发送/接收Energon](/zh-cn/user-interfaces/platon-samurai/_%E9%92%B1%E5%8C%85.md#%E5%A6%82%E4%BD%95%E5%8F%91%E9%80%81%E6%8E%A5%E6%94%B6energon)
- [为什么钱包中的测试币被清零了](/zh-cn/user-interfaces/platon-samurai/_钱包.md#为什么钱包中的测试币被清零了)

### 联名钱包

- [什么是联名钱包](/zh-cn/user-interfaces/platon-samurai/_联名钱包.md#什么是联名钱包)
- [如何创建一个联名钱包](/zh-cn/user-interfaces/platon-samurai/_联名钱包.md#如何创建一个联名钱包)
- [如何添加已创建的联名钱包](/zh-cn/user-interfaces/platon-samurai/_联名钱包.md#如何添加已创建的联名钱包)
- [如何使用联名钱包发送/接收Energon](/zh-cn/user-interfaces/platon-samurai/_%E8%81%94%E5%90%8D%E9%92%B1%E5%8C%85.md#%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8%E8%81%94%E5%90%8D%E9%92%B1%E5%8C%85%E5%8F%91%E9%80%81%E6%8E%A5%E6%94%B6energon)

### 合约

- [Wasm合约是什么](/zh-cn/user-interfaces/platon-samurai/_合约.md#wasm合约是什么)
- [如何部署一个Wasm合约](/zh-cn/user-interfaces/platon-samurai/_合约.md#如何部署一个wasm合约)
- [如何添加别人已部署的合约](/zh-cn/user-interfaces/platon-samurai/_合约.md#如何添加别人已部署的合约)
- [怎样运行Wasm合约](/zh-cn/user-interfaces/platon-samurai/_合约.md#怎样运行wasm合约)
- [什么是隐私合约](/zh-cn/user-interfaces/platon-samurai/_合约.md#什么是隐私合约)
- [如何部署隐私合约](/zh-cn/user-interfaces/platon-samurai/_合约.md#如何部署隐私合约)
- [怎么执行隐私合约](/zh-cn/user-interfaces/platon-samurai/_合约.md#怎么执行隐私合约)

### 共识节点

- [怎样注册共识节点](/zh-cn/user-interfaces/platon-samurai/_竞选节点.md#怎样注册共识节点)
- [如何提高成为验证节点的概率](/zh-cn/user-interfaces/platon-samurai/_竞选节点.md#如何提高成为验证节点的概率)
- [如何为共识节点投票](/zh-cn/user-interfaces/platon-samurai/_竞选节点.md#如何为共识节点投票)
- [共识节点为什么会被淘汰](/zh-cn/user-interfaces/platon-samurai/_竞选节点.md#共识节点为什么会被淘汰)
- [被淘汰的节点如何再次加入](/zh-cn/user-interfaces/platon-samurai/_竞选节点.md#被淘汰的节点如何再次加入)
- [如何注销共识节点](/zh-cn/user-interfaces/platon-samurai/_竞选节点.md#如何注销共识节点)
- [如何提取被质押的资产](/zh-cn/user-interfaces/platon-samurai/_竞选节点.md#如何提取被质押的资产)

