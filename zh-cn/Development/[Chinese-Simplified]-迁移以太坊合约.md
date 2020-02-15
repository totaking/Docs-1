# 迁移以太坊合约

## 简介 

​      如果您希望将以太坊的智能合约迁移到platon上，可以通过platon-truffle开发工具来进行。首先确保您正确安装了platon-truffle,只需按照以下步骤操作即可。

## 操作步聚

**step1.** 使用创建一个新的工作目录如example
```bash
juzix@juzix:~$ mkdir example
juzix@juzix:~$ cd example/
juzix@juzix:~/example$
```
**step2.** truffle init 创建一个truffle工程
```bash
juzix@juzix:~/example$ truffle init
```
**step3.** 将以太坊合约文件如ERC200513Token.sol放至example/contracts目录下
```bash
juzix@juzix:~/example/contracts$ ls
ERC200513Token.sol  Migrations.sol
```
**注意事项：** platon智能合约中的货币单位为lat和von。要成功将您的以太坊智能合约迁移至platon，请将以太币面额更改为platon面额。请记住，1ether-> 1lat  1wei->1von。

**step4.** 修改truffle-config.js中的编译版本号及链相关配制
```bash
module.exports = {
  networks: {
     development: {
      host: "10.1.1.6",     // Localhost (default: none)
      port: 8806,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
      from: "0xf644cfc3b0dc588116d6621211a82c1ef9c62e9e",
      gas: 90000000,
      gasPrice: 50000000004,	     
     },
  },

  compilers: {
    solc: {
       version: "^0.5.12",    // Fetch exact version from solc-bin
       docker: false,        // Use "0.5.1" you've installed locally with docker
    }
  }
}
```

**step5.** 执行编译 truffle compile
```bash
truffle compile
编译成功输出如下信息：
```
>juzix@juzix:~/example$ truffle compile
>
>Compiling your contracts...
> Compiling ./contracts/ERC200513Token.sol
> Compiling ./contracts/Migrations.sol

>   compilation warnings encountered:

>Warning: This is a pre-release compiler version, please do not use it in production.

> Artifacts written to /home/juzix/example/build/contracts
> Compiled successfully using:
>
>   - solc: 0.5.13-develop.2020.1.2+commit.9ff23752.mod.Emscripten.clang


**step6.** 进入example/migrations 添加合约部署配制文件2_initial_ERC200513Token.js
```bash
juzix@juzix:~/example/migrations$ ls
1_initial_migration.js  2_initial_ERC200513Token.js
内容如下：
```
> const ERC200513Token = artifacts.require("ERC200513Token");
>   
> module.exports = function(deployer) {
>   deployer.deploy(ERC200513Token,100,'PLA','PLAT');
> };


**step7.** 执行truffle migrate 部署合约

```bash
执行truffle migratte
输出结果如下，表示迁移成功
```
>juzix@juzix:~/example$ truffle migrate
>
>Compiling your contracts...
>
> Everything is up to date, there is nothing to compile.
>2_initial_ERC200513Token.js
>
>   Deploying 'ERC200513Token'
>     transaction hash:    0xa1770aecf4cffb0e75a172e06e75a9e9cb2d36bf89291b57d504e8c054985e99
>     Blocks: 0            Seconds: 0
>     contract address:    0x5474608c5dee5039C95FEf3D7e48Fa793903Ce99
>     block number:        265657
>     block timestamp:     1581742216965
>     account:             0xF644CfC3b0Dc588116D6621211a82C1Ef9c62E9e
>     balance:             90000000.826385379994114416
>     gas used:            638876
>     gas price:           50.000000004 gwei
>     value sent:          0 ETH
>     total cost:          0.031943800002555504 ETH
>    
>    
>     Saving migration to chain.
>     Saving artifacts
>    
>     Total cost:     0.031943800002555504 ETH
>
>
>Summary

> Total deployments:   2
> Final cost:          0.037844150003027532 ETH




