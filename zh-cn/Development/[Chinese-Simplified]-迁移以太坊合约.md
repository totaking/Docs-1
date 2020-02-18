# 迁移以太坊合约

## 简介 

如果您希望将以太坊的智能合约迁移到PlatON上，可以通过platon-truffle开发工具来进行。首先确保您正确安装了platon-truffle,只需按照以下步骤操作即可。

## 操作步聚

**step1.** 创建一个新的工作目录如example
```bash
mkdir example && cd example
```
- 以下命令如果没有特殊说明都在example目录下进行

  

**step2.** 使用platon-truffle初始化一个工程
```
truffle init
```
在操作完成之后，就有这样的一个项目结构：

- contracts/: Solidity合约目录

- migrations/: 部署脚本文件目录

- test/: 测试脚本目录

- truffle-config.js: platon-truffle 配置文件



**step3.** 将以太坊合约文件如ERC200513Token.sol放至example/contracts目录下

```
ls contracts/
```
- 将看到 ERC200513Token.sol

- PlatON智能合约中的货币单位为LAT和VON。要将以太坊智能合约迁移至PlatON，请将以太币面额更改为PlatON面额。同时注意以太/LAT市场汇率

  

**step4.** 修改truffle-config.js中的编译版本号及链相关配制
```
module.exports = {
  networks: {
     development: {
      host: "10.1.1.6",     // 链地址
      port: 8806,            // 链使用的rpc端口
      network_id: "*",       // Any network (default: none)
      from: "0xf644cfc3b0dc588116d6621211a82c1ef9c62e9e", //部署合约所使用的钱包地址
      gas: 90000000,
      gasPrice: 50000000004,	     
     },
  },

  compilers: {
    solc: {
       version: "^0.5.13",    // 编译合约所使用的solidity版本号，与合约定义版本一致
       docker: false,        // Use "0.5.1" you've installed locally with docker
    }
  }
}
```



**step5.** 编译合约

```
truffle compile
```
编译成功输出如下信息：

- Compiling your contracts...
- Compiling ./contracts/ERC200513Token.sol
- Compiling ./contracts/Migrations.sol
-   compilation warnings encountered:

- Warning: This is a pre-release compiler version, please do not use it in production.
- Artifacts written to /home/guest/example/build/contracts
- Compiled successfully using: //表示编译成功
-   solc: 0.5.13-develop.2020.1.2+commit.9ff23752.mod.Emscripten.clang



**step6.** 添加合约部署配制文件
```
cd migrations && touch 2_initial_ERC200513Token.js
```
合约部署配制文件2_initial_ERC200513Token.js内容如下：

- const ERC200513Token = artifacts.require("ERC200513Token"); //ERC200513Token即迁移合约类名
- module.exports = function(deployer) {
-   deployer.deploy(ERC200513Token,100,'PLA','PLAT'); //ERC200513Token第一行定义的合约抽象，后面三个参数为合约构造函数参数
- };



**step7.** 部署合约

```
truffle migratte
```
输出结果如下，表示迁移成功
- Compiling your contracts...
- Everything is up to date, there is nothing to compile.
- 2_initial_ERC200513Token.js
-    Deploying 'ERC200513Token'
-      transaction hash:    0xa1770aecf4cffb0e75a172e06e75a9e9cb2d36bf89291b57d504e8c054985e99
-      Blocks: 0            Seconds: 0
-      contract address:    0x5474608c5dee5039C95FEf3D7e48Fa793903Ce99 //迁移后的合约地址
-      block number:        265657
-      block timestamp:     1581742216965
-      account:             0xF644CfC3b0Dc588116D6621211a82C1Ef9c62E9e
-      balance:             90000000.826385379994114416
-      gas used:            638876
-      gas price:           50.000000004 gVON
-      value sent:          0 LAT
-      total cost:          0.031943800002555504 LAT
-      Saving migration to chain.
-      Saving artifacts
-      Total cost:     0.031943800002555504 LAT
- Summary
-  Total deployments:   2
-  Final cost:          0.037844150003027532 LAT
