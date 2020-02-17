# 智能合约开发入门手册

## 1 简介

合约，就是一段程序，并且是一段能在区块链上运行的程序。把合约部署到区块链网络后，用户就能通过platon-truffle来调用这个合约，完成业务逻辑。本教程主要是指导用户在PlatON上创建，编译，部署和与HelloWorld智能合约交互。PlatON提供了platon-truffle来辅助用户与链进行交互。如果您想使用更加丰富的API可以参考[Java SDK开发指南](/zh-cn/Development/[Chinese-Simplified]-Java-SDK.md) 或者 [JS SDK开发指南](/zh-cn/Development/[Chinese-Simplified]-JS-SDK.md)

- solidity智能合约语法请参考[Solidity官方文档](https://solidity.readthedocs.io/en/develop/)
- platon-truffle开发工具[源码地址](https://github.com/PlatONnetwork/platon-truffle.git)

## 2 platon-truffle开发工具介绍
- platon-truffle开发工具[安装参考](https://github.com/PlatONnetwork/platon-truffle/tree/feature/evm)
- platon-truffle开发工具[使用手册](https://platon-truffle.readthedocs.io/en/v0.1.0/index.html)


## 3  创建HelloWorld合约

```
pragma solidity ^0.5.13;

contract HelloWorld {
    
    string name;
    
    function setName(string memory _name) public returns(string memory){
        name = _name;
        return name;
    }
    
    function getName() public view returns(string memory){
        return name;
    }
}
```

说明：

```plain
pragma solidity ^0.5.13
	pragma solidity：是solidity版本声明。
	0.5.13：代表solidity版本。
	^ ：表示向上兼容,即可以用0.5.13以上版本编译器进行编译。

contract HelloWorld
	contract：合约声明的关键字。
	HelloWorld：当前合约的名称。

string name
	name：合约的状态变量。
	string：指明此状态变量的类型。

function setName(string memory _name) public returns(string memory)
	function：合约中函数声明关键字。
	setName：此函数的名称。
	memory：声明_name参数的存储位置（字符串类型的函数输入参数与输出参数必须声明为memory）。
	_name：为此函数的局部变量。
	public：声明此函数的可见性。
	name = _name：此操作将外部传进来的局部变量赋值给状态变量。

function getName() public view returns(string memory)
	view:如果一个函数带有view关键字，此函数将不会改变合约中状态变量的值（主要用于查询）。		

```

## 4 编译HelloWorld合约 

**step1.** 使用platon-truffle初始化项目

```
在安装有platon-truffle的服务器上面先初始化一个工程。
mkdir HelloWorld
cd HelloWorld
truffle init
提示如下表示成功：

  ✔ Preparing to download
  ✔ Downloading
  ✔ Cleaning up temporary files
  ✔ Setting up box
  
  Unbox successful. Sweet!
  
  Commands:
  
    Compile:        truffle compile
    Migrate:        truffle migrate
    Test contracts: truffle test
```

**step2.** 将HelloWorld.sol放入HelloWorld/contracts目录下

```
guest@guest:~/HelloWorld/contracts$ ls
HelloWorld.sol  Migrations.sol
```

**step3.** 修改truffle-config.js文件，将编译器版本修改成“^0.5.13”

```
compilers: {
    solc: {
       version: "^0.5.13",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
       }
    }
}
```

**step4.** 执行truffle compile编译合约

```
guest@guest:~/HelloWorld$ truffle compile

Compiling your contracts...

 Compiling ./contracts/HelloWorld.sol
 Compiling ./contracts/Migrations.sol

 compilation warnings encountered:

Warning: This is a pre-release compiler version, please do not use it in production.

 Artifacts written to /home/guest/hudenian/HelloWorld/build/contracts
 Compiled successfully using:
    solc: 0.5.13-develop.2020.1.2+commit.9ff23752.mod.Emscripten.clang
```

## 5 部署HelloWorld合约

**step1.** 在HelloWorld/migrations/下添加部署HelloWorld合约辅助脚本2_initial_helloword.js，内容如下所示：

```
const HelloWorld = artifacts.require("HelloWorld"); 
module.exports = function(deployer) {
  	deployer.deploy(HelloWorld);
};
```


**step2.** 修改truffle-config.js中链的配制信息

```
networks: {
     development: {
      host: "10.1.1.6",     // 区块链所在服务器主机
      port: 8806,            // 链端口号
      network_id: "*",       // Any network (default: none)
      from: "0xf644cfc3b0dc588116d6621211a82c1ef9c62e9e", //部署合约账号的钱包地址
      gas: 90000000,
      gasPrice: 50000000004,
     },
}
```

**step3.**  执行truffle migrate 部署合约

```
guest@guest:~/HelloWorld$ truffle migrate

Compiling your contracts...

 Everything is up to date, there is nothing to compile.

Migrations dry-run (simulation)

Network name:    'development-fork'
Network id:      1
Block gas limit: 0x5f5e100
2_initial_helloword.js

   Deploying 'HelloWorld'
   
    transaction hash:    0x2bb5c7f6202225554a823db410fb16cf0c8328a51391f24fb9052a6a8f3033e3
    Blocks: 0            Seconds: 0
    contract address:    0x714E74eEc4b63D9DB72cbB5F78CDD5b5bb60F9dc
    block number:        142522
    block timestamp:     1581667696206
    account:             0xF644CfC3b0Dc588116D6621211a82C1Ef9c62E9e
    balance:             90000000.867724449997417956
    gas used:            149247
    gas price:           50.000000004 gVON
    value sent:          0 LAT
    total cost:          0.007462350000596988 LAT


    Saving migration to chain.
    Saving artifacts
   
    Total cost:     0.007462350000596988 LAT
```

## 6 调用HelloWorld合约

**step1.**  构建合约对象

```
guest@guest:~/HelloWorld$ truffle console
truffle(development)> var abi = [{"constant":false,"inputs":[{"internalType":"string","name":"_name","type":"string"}],"name":"setName","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}]'; 
truffle(development)> var helloWorld = new web3.eth.Contract(abi,'0x9A5015F9A3728ff64f401b9B93E98078BdD48FD1');  
```

**step2.**  调用合约
```
truffle(development)>helloWorld.methods.setName("hello world").send({from:'0xf644cfc3b0dc588116d6621211a82c1ef9c62e9e'}).on('transactionHash',function(hash){}).on('confirmation', function(confirmationNumber, receipt){}).on('receipt', function(receipt){ console.log(receipt);}).on('error', console.error);
交易回执如下:

{ blockHash:
   '0x3ae287d1e745e30d0d6c95d5220cc7816cda955e7b2f013c6a531ed95028a794',
  blockNumber: 159726,
  contractAddress: null,
  cumulativeGasUsed: 44820,
  from: '0xf644cfc3b0dc588116d6621211a82c1ef9c62e9e',
  gasUsed: 44820,
  logsBloom:
  '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
  status: true,
  to: '0x9a5015f9a3728ff64f401b9b93e98078bdd48fd1',
  transactionHash:
   '0xb7a41f72d555d4a2d9f2954fbdc5bbbb4c5ce89c836f8704276419ed416b3866',
  transactionIndex: 0,
  events: {} }
{ blockHash:
   '0x3ae287d1e745e30d0d6c95d5220cc7816cda955e7b2f013c6a531ed95028a794',
  blockNumber: 159726,
  contractAddress: null,
  cumulativeGasUsed: 44820,
  from: '0xf644cfc3b0dc588116d6621211a82c1ef9c62e9e',
  gasUsed: 44820,
  logsBloom:
   '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
  status: true,
  to: '0x9a5015f9a3728ff64f401b9b93e98078bdd48fd1',
  transactionHash:
   '0xb7a41f72d555d4a2d9f2954fbdc5bbbb4c5ce89c836f8704276419ed416b3866',
  transactionIndex: 0,
  events: {} }
```

**step3.**  查询合约
```
truffle(development)>helloWorld.methods.getName().call(null,function(error,result){console.log("name is:" + result);})  
查询结果如下：
 name is:
 'hello world'
```

## 7 FAQ 

> 问: platon-truffle有哪些命令如何使用？

> 答: platon-truffle开发使用手册[参考这里](https://platon-truffle.readthedocs.io/en/v0.1.0/index.html)




> 问: 合约为什么语法校验通不过？

> 答: solidity合约0.4.x版本与0.5.x版本有重大变更，具体语法[参考这里](https://solidity.readthedocs.io/en/develop/)



> 问:  platon-truffle执行truffle compile 失败?

> 答:  1.确认编译的合约文件中的版本号与truffle-config.js中指定的版本号是否一致。
>           2.可能语法有误（如下所示），可以根据命令行提示修复后再进行编译
>               Error: CompileError: /home/guest/hudenian/solidityDoc/contracts/HelloWorld.sol7 22 TypeError:Data location must be "memory" for parameter in function, but none was given.
>               function setName(string  _name) public returns(string memory){
>                                                  ^-----------^ 
>               Compilation failed. See above.at Object.compile (/home/guest/platon-truffle/build/webpack:/packages/workflow-compile/legacy/index.js72:1)
>               at process._tickCallback (internal/process/next_tick.js68:7)



> 问: platon-truffle执行truffle migrate部署合约失败

> 答: 1.确认truffle-config.js中连接的链的配制信息及用户的钱包地址是否正确




> 问: truffle migrate部署带参数的构造函数合约失败

> 答: 以合约A.sol为例，在migrations/2_initial_A.js文件中，确认是否添加构造参数信息如：
> A.sol构造函数格式如下：
> constructor(uint256 a, string memory b, string memory c) public {}


>2_initial_A.js文件配制如下：
> const A = artifacts.require("A");
>   
> module.exports = function(deployer) {
>   deployer.deploy(ERC200513Token,100,'PLA','PLAT');//需要传入对应构造函数参数
> };




