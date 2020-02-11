## Web3.js 调用接口 

通过 web3.js 提供的web3对象与底层链进行交互。底层实现上，它通过 RPC 调用与本地节点通信。web3.js可以与任何暴露了RPC接口的PlatON节点连接。

### 准备工作

首先请确保本地成功安装了nodeJS环境，通过npm包管理工具将web3引入到项目工程中，通过如下步骤：

- npm: `npm i https://github.com/PlatONnetwork/client-sdk-js`

然后需要创建web3的实例，设置一个provider。为了保证不会覆盖已有的provider，需要先检查web3实例是否已经存在，可参考如下代码：

```js
if (typeof web3 !== 'undefined') {
  web3 = new Web3(web3.currentProvider);
} else {
  // set the provider you want from Web3.providers
  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:6789"));
}
```

成功引入后，现在可以使用web3的相关API了。

### 使用回调

由于这套API被设计用于与本地的PlatON节点交互，所有函数默认使用同步方式请求RPC接口。

如果需要发起异步请求。大多数函数允许传递可选的回调函数来支持异步。回调函数支持error first callback的风格。

```js
web3.platon.getBlock(48, function(error, result){
    if(!error)
        console.log(JSON.stringify(result));
    else
        console.error(error);
})
```

### 详细使用
#### web3
`web3` 对象提供了所有方法。
##### 示例：

```js
var Web3 = require('web3');
// create an instance of web3 using the HTTP provider.
// NOTE in mist web3 is already available, so check first if it's available before instantiating
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
```

***
#### web3.version.api

##### 调用：
```js
web3.version.api
```
##### 返回值：
 `String` - PlatON js的api版本号

##### 示例：
```js
var version = web3.version.api;
console.log(version); // "0.2.0"
```

***
#### web3.version.node

##### 调用：

web3.version.node

// 异步方式

web3.version.getNode(callback(error, result){ ... })

##### 返回值：
 `String` - 客户端或节点的版本信息

##### 示例：
```js
var version = web3.version.node;
console.log(version); // "Mist/v0.9.3/darwin/go1.4.1"
```

***
#### web3.version.network

##### 调用：
web3.version.network

// 异步方式

web3.version.getNetwork(callback(error, result){ ... })

##### 返回值：
 `String` - 网络协议版本

##### 示例：
```js
var version = web3.version.network;
console.log(version); // 54
```

***
#### web3.version.platon

##### 调用：
web3.version.platon

// 异步方式

web3.version.getPlaton(callback(error, result){ ... })

##### 返回值：
 `String` - PlatON 的协议版本

##### 示例：
```js
var version = web3.version.platon;
console.log(version); // 60
```

***
#### web3.isConnected

检查连接是否存在。

##### 调用：
web3.isConnected() 

##### 参数：
无

##### 返回值：
 `Boolean`

##### 示例：
```js
if(!web3.isConnected()) {
  
   // show some dialog to ask the user to start a node
 } else {
 
   // start web3 filters, calls, etc
}
```

***
#### web3.setProvider

设置Provider。

##### 调用：
web3.setProvider(provider)

##### 参数：
无

##### 返回值：
 `undefined`

##### 示例：
```js
web3.setProvider(new web3.providers.HttpProvider('http://localhost:8545')); // 8080 for cpp/AZ, 8545 for go/mist
```

***
#### web3.currentProvider

如果已经设置了Provider，则返回当前的Provider。这个方法可以检查在使用mist浏览器等情况下是否已经设置过Provider，避免重复设置。

##### 调用： 
web3.currentProvider

##### 返回值：
 `Object` - `null` 或 已经设置的`Provider`

##### 示例：
```js
// Check if mist etc. already set a provider
if(!web3.currentProvider)
    web3.setProvider(new web3.providers.HttpProvider("http://localhost:8545"));
```

***
#### web3.reset

重置web3的状态。重置除了manager以外的其它所有东西。卸载filter，停止状态轮询。

##### 调用： 
web3.reset(keepIsSyncing)

##### 参数：
 1. `Boolean` - 如果设置为true，将会卸载所有的filter，但会保留web3.platon.isSyncing()的状态轮询

##### 返回值：
 `undefined`

##### 示例：
```js
web3.reset();
```

***
#### web3.sha3

##### 调用： 
web3.sha3(string [, options])

##### 参数：
1. `String` - 传入的需要使用Keccak-256 SHA3算法进行哈希运算的字符串
2. `Object` - 可选项设置。如果要解析的是hex格式的十六进制字符串。需要设置encoding为hex。因为JS中会默认忽略0x

##### 返回值：
 `String` - 使用Keccak-256 SHA3算法哈希过的结果

##### 示例：
```js
var hash = web3.sha3("Some string to be hashed");
console.log(hash); // "0xed973b234cf2238052c9ac87072c71bcf33abc1bbd721018e0cca448ef79b379"
var hashOfHash = web3.sha3(hash, {encoding: 'hex'});
console.log(hashOfHash); // "0x85dd39c91a64167ba20732b228251e67caed1462d4bcf036af88dc6856d0fdcc"
```

***
#### web3.toHex

将任何值转为Hex。

##### 调用： 
web3.toHex(mixed);

##### 参数：
 1. `String|Number|Object|Array|BigNumber` - 需要转化为HEX的值。如果是一个对象或数组类型，将会先用JSON.stringify进行转换成字符串。如果传入的是BigNumber，则将得到对应的Number的HEX

##### 返回值：
 `String` - 转为Hex的字符串

##### 示例：
```js
var str = web3.toHex({test: 'test'});
console.log(str); // '0x7b2274657374223a2274657374227d'
```

***
#### web3.toAscii

将HEX字符串转为ASCII字符串。

##### 调用：
web3.toAscii(hexString);

##### 参数：
1. `String` - 十六进制字符串

##### 返回值：
 `String` - 给定十六进制字符串对应的ASCII码值

##### 示例：
```js
var str = web3.toAscii("0x506c61744f4ed");
console.log(str); // "PlatON"
```

***
#### web3.fromAscii

将任何的ASCII码字符串转为HEX字符串。

##### 调用：
web3.fromAscii(string);

##### 参数：
1. `String` - ASCII码字符串

##### 返回值：
 `String` - 转换后的HEX字符串

##### 示例：
```js
var str = web3.fromAscii('PlatON');
console.log(str); // "0x506c61744f4e"
```

***
#### web3.toDecimal

将一个十六进制转为一个十进制的数字。

##### 调用：
web3.toDecimal(hexString);

##### 参数：
1. `String` - 十六进制字符串

##### 返回值：
`Number` - 传入字符串所代表的十六进制值

##### 示例：
```js
var number = web3.toDecimal('0x15');
console.log(number); // 21
```

***
#### web3.fromDecimal

将一个数字，或者字符串形式的数字转为一个十六进制串。

##### 调用：
web3.fromDecimal(number);

##### 参数：
1. `Number|String` - 数字

##### 返回值：
 `String` - 给定数字对应的十六进制表示

##### 示例：
```js
var value = web3.fromDecimal('21');
console.log(value); // "0x15"
```

***
#### web3.fromVon

PlatON货币单位之间的转换。将以von为单位的数量，转为下述的单位，可取值如下：

- `von`
- `kvon`
- `mvon`
- `gvon`
- `microlat`
- `millilat`
- `lat`
- `klat`
- `mlat`
- `glat`
- `tlat`

##### 调用：
web3.fromVon(number, unit)

##### 参数：
1. `Number|String|BigNumber` - 数字或BigNumber
2. `String` - 单位字符串

##### 返回值：
`String|BigNumber` - 根据传入参数的不同，分别是字符串形式的字符串，或者是BigNumber

##### 示例：
```js
var value = web3.fromVon('21000000000000', 'gvon');
console.log(value); // "21000"
```

***
#### web3.toVon

按对应货币转为以von为单位。可选择的单位如下：

- `von`
- `kvon`
- `mvon`
- `gvon`
- `microlat`
- `millilat`
- `lat`
- `klat`
- `mlat`
- `glat`
- `tlat`

```
'von':          '1',
'kvon':         '1000',
'mvon':         '1000000',
'gvon':         '1000000000',
'microlat':     '1000000000000',
'millilat':     '1000000000000000',
'lat':          '1000000000000000000',
'klat':         '1000000000000000000000',
'mlat':         '1000000000000000000000000',
'glat':         '1000000000000000000000000000',
'tlat':         '1000000000000000000000000000000'
```

##### 调用：
web3.toVon(number, unit)

##### 参数：
1. `Number|String|BigNumber` - 数字或BigNumber
2. `String` - 字符串单位

##### 返回值：
 `String|BigNumber` - 根据传入参数的不同，分别是字符串形式的字符串，或者是BigNumber

##### 示例：
```js
var value = web3.toVon('1', 'lat');
console.log(value); // "1000000000000000000"
```

***
#### web3.toBigNumber

将给定的数字或十六进制字符串转为BigNumber。

##### 调用：
web3.toBigNumber(numberOrHexString); 

##### 参数：
1. `Number|String` - 数字或十六进制格式的数字

##### 返回值：
`BigNumber` - BigNumber的实例

##### 示例：
```js
var value = web3.toBigNumber('200000000000000000000001');
console.log(value); // instanceOf BigNumber
console.log(value.toNumber()); // 2.0000000000000002e+23
console.log(value.toString(10)); // '200000000000000000000001'
```

***
#### web3.isAddress

检查给定的字符串是否是地址。

##### 调用：
web3.isAddress(HexString); 

##### 参数：
 1. `String` - 十六进制字符串

##### 返回值：
 `Boolean` - 如果不是有效的地址格式，则为false。 如果为全小写或全大写有效地址，则返回“ true”。 如果是大小写混合的地址，则使用`web3.isChecksumAddress()`进行检查

##### 示例：
```js
var isAddress = web3.isAddress("0x8888f1f195afa192cfee860698584c030f4c9db1");
console.log(isAddress); // true
```

***
#### web3.net
#### web3.net.listening

此属性是只读的，表示当前连接的节点，是否正在listen网络连接与否。listen可以理解为接收。

##### 调用：
web3.net.listening

// 异步方式

web3.net.getListening(callback(error, result){ ... })

##### 返回值：
`Boolean` - `true` 表示连接上的节点正在listen网络请求，否则返回false

##### 示例：
```js
var listening = web3.net.listening;
console.log(listening); // true of false
```

***
#### web3.net.peerCount

属性是只读的，返回连接节点已连上的其它PlatON节点的数量。

##### 调用：
web3.net.peerCount

// 异步方式

web3.net.getPeerCount(callback(error, result){ ..... })

##### 返回值：
 `Number` - 连接节点连上的其它PlatON节点的数量

##### 示例：
```js
var peerCount = web3.net.peerCount;
console.log(peerCount); // 4
```

***
#### web3.platon

包含PlatON区块链相关的方法。

##### 示例：
```js
var platon = web3.platon;
```

***
#### web3.platon.gasPrice

属性是只读的，返回当前的gas价格。这个值由最近几个块的gas价格的中值决定。

##### 调用：
web3.platon.gasPrice

// 异步方式
web3.platon.getGasPrice(callback(error, result){ ... })

##### 返回值：
`BigNumber` - 当前的gas价格的BigNumber实例，以von为单位

##### 示例：
```js
var gasPrice = web3.platon.gasPrice;
console.log(gasPrice.toString(10)); // "10000000000000"
```

***
#### web3.platon.accounts

只读属性，返回当前节点持有的帐户列表。

##### 调用：
web3.platon.accounts

// 异步方式

web3.platon.getAccounts(callback(error, result){ ... })

##### 返回值：
 `Array` - 节点持有的帐户列表

##### 示例：
```js
var accounts = web3.platon.accounts;
console.log(accounts); // ["0x407d73d8a49eeb85d32cf465507dd71d507100c1"] 
```

***
#### web3.platon.blockNumber

属性只读，返回最新的区块号。

##### 调用：
web3.platon.blockNumber

// 异步方式

web3.platon.getBlockNumber(callback(error, result){ ... })

##### 返回值：
`Number` - 最新的区块号

##### 示例：
```js
var number = web3.platon.blockNumber;
console.log(number); // 2744
```

***
#### web3.platon.getBalance

获得在指定区块时给定地址的余额。

##### 调用：
web3.platon.getBalance(addressHexString [, defaultBlock] [, callback])

##### 参数：
1. `String` - 要查询余额的地址
2. `Number|String` - (可选) 如果不设置此值使
3. `Function` - (可选) 回调函数，用于支持异步的方式执行

##### 返回值：
 `String` - 一个包含给定地址的当前余额的BigNumber实例，单位为von

##### 示例：
```js
var balance = web3.platon.getBalance("0x407d73d8a49eeb85d32cf465507dd71d507100c1");
console.log(balance); // instanceof BigNumber
console.log(balance.toString(10)); // '1000000000000'
console.log(balance.toNumber()); // 1000000000000
```

***
#### web3.platon.getStorageAt

获得某个地址指定位置的存储的状态值。

##### 调用：
web3.platon.getStorageAt(addressHexString, position [, defaultBlock] [, callback])

##### 参数：
1. `String` - 要获得存储的地址
1. `Number` - 要获得的存储的序号
2. `Number|String` - (可选) 如果未传递参数，默认使用web3.platon.defaultBlock定义的块，否则使用指定区块
3. `Function` - (可选) 回调函数，用于支持异步的方式执行

##### 返回值：
`String` - 给定位置的存储值

##### 示例：
```js
var state = web3.platon.getStorageAt("0x407d73d8a49eeb85d32cf465507dd71d507100c1", 0);
console.log(state); // "0x03"
```

***
#### web3.platon.getCode

获取指定地址的代码。

##### 调用：
web3.platon.getCode(addressHexString [, defaultBlock] [, callback])

##### 参数：
1. `String` - 要获得代码的地址
1. `Number|String` - (可选) 如果未传递参数，默认使用 web3.platon.defaultBlock 定义的块，否则使用指定区块
2. `Function` - (可选) 回调函数，用于支持异步的方式执行

##### 返回值：
 `String` - 给定地址合约编译后的字节代码

##### 示例：
```js
var code = web3.platon.getCode("0xd5677cf67b5aa051bb40496e68ad359eb97cfbf8");
console.log(code); // "0x600160008035811a818181146012578301005b601b6001356025565b8060005260206000f25b600060078202905091905056"
```

***
#### web3.platon.getBlock

返回块号或区块哈希值所对应的区块。

##### 调用：
web3.platon.getBlock(blockHashOrBlockNumber [, returnTransactionObjects] [, callback])

##### 参数：

- Number|String -（可选）如果未传递参数，默认使用web3.platon.defaultBlock定义的块，否则使用指定区块
- Boolean -（可选）默认值为false。true会将区块包含的所有交易作为对象返回。否则只返回交易的哈希
- Function - 回调函数，用于支持异步的方式执行

##### 返回值：
- `Object` - The block object:
 - Number - 区块号。当这个区块处于pending将会返回null
 - hash - 字符串，区块的哈希串。当这个区块处于pending将会返回null
 - parentHash - 字符串，32字节的父区块的哈希值
 - nonce - 字符串，8字节。POW生成的哈希。当这个区块处于pending将会返回null
 - sha3Uncles - 字符串，32字节。叔区块的哈希值
 - logsBloom - 字符串，区块日志的布隆过滤器9。当这个区块处于pending将会返回null
 - transactionsRoot - 字符串，32字节，区块的交易前缀树的根
 - stateRoot - 字符串，32字节。区块的最终状态前缀树的根
 - miner - 字符串，20字节。这个区块获得奖励的矿工
 - difficulty - BigNumber类型。当前块的难度，整数
 - totalDifficulty - BigNumber类型。区块链到当前块的总难度，整数
 - extraData - 字符串。当前块的extra data字段
 - size - Number。当前这个块的字节大小
 - gasLimit - Number，当前区块允许使用的最大gas
 - gasUsed - 当前区块累计使用的总的gas
 - timestamp - Number。区块打包时的unix时间戳
 - transactions - 数组。交易对象。或者是32字节的交易哈希
 - uncles - 数组。叔哈希的数组

##### 示例：
```js
var info = web3.platon.getBlock(3150);
console.log(info);
/*
{
  "number": 3,
  "hash": "0xef95f2f1ed3ca60b048b4bf67cde2195961e0bba6f70bcbea9a2c4e133e34b46",
  "parentHash": "0x2302e1c0b972d00932deb5dab9eb2982f570597d9d42504c05d9c2147eaf9c88",
  "nonce": "0xfb6e1a62d119228b",
  "sha3Uncles": "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
  "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "transactionsRoot": "0x3a1b03875115b79539e5bd33fb00d8f7b7cd61929d5a3c574f507b8acf415bee",
  "stateRoot": "0xf1133199d44695dfa8fd1bcfe424d82854b5cebef75bddd7e40ea94cda515bcb",
  "miner": "0x8888f1f195afa192cfee860698584c030f4c9db1",
  "difficulty": BigNumber,
  "totalDifficulty": BigNumber,
  "size": 616,
  "extraData": "0x",
  "gasLimit": 3141592,
  "gasUsed": 21662,
  "timestamp": 1429287689,
  "transactions": [
    "0x9fc76417374aa880d4449a1f7f31ec597f00b1f6f3dd2d66f4c9c6c445836d8b"
  ],
  "uncles": []
}
*/
```

***
#### web3.platon.getBlockTransactionCount

返回指定区块的交易数。

##### 调用：
web3.platon.getBlockTransactionCount(hashStringOrBlockNumber [, callback])

##### 参数：
- Number|String -（可选）如果未传递参数，默认使用web3.platon.defaultBlock定义的块，否则使用指定区块
- Function - 回调函数，用于支持异步的方式执行

##### 返回值：
 `Number` - 给定区块的交易数量

##### 示例：
```js
var number = web3.platon.getBlockTransactionCount("0x407d73d8a49eeb85d32cf465507dd71d507100c1");
console.log(number); // 1
```

***
##### web3.platon.getTransaction

返回匹配指定交易哈希值的交易。

##### 调用：
web3.platon.getTransaction(transactionHash [, callback])

##### 参数：
- String - 交易的哈希值
- Function - 回调函数，用于支持异步的方式执行

##### 返回值：
- `Object` - A transaction object its hash `transactionHash`:
   - hash: String - 32字节，交易的哈希值
   - nonce: Number - 交易的发起者在之前进行过的交易数量
   - blockHash: String - 32字节。交易所在区块的哈希值。当这个区块处于pending将会返回null
   - blockNumber: Number - 交易所在区块的块号。当这个区块处于pending将会返回null
   - transactionIndex: Number - 整数。交易在区块中的序号。当这个区块处于pending将会返回null
   - from: String - 20字节，交易发起者的地址
   - to: String - 20字节，交易接收者的地址。当这个区块处于pending将会返回null
   - value: BigNumber - 交易附带的货币量，单位为von
   - gasPrice: BigNumber - 交易发起者配置的gas价格，单位是von
   - gas: Number - 交易发起者提供的gas
   - input: String - 交易附带的数据

##### 示例：
```js
var transaction = web3.platon.getTransaction('0x9fc76417374aa880d4449a1f7f31ec597f00b1f6f3dd2d66f4c9c6c445836d8b');
console.log(transaction);
/*
{
  "hash": "0x9fc76417374aa880d4449a1f7f31ec597f00b1f6f3dd2d66f4c9c6c445836d8b",
  "nonce": 2,
  "blockHash": "0xef95f2f1ed3ca60b048b4bf67cde2195961e0bba6f70bcbea9a2c4e133e34b46",
  "blockNumber": 3,
  "transactionIndex": 0,
  "from": "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b",
  "to": "0x6295ee1b4f6dd65047762f924ecd367c17eabf8f",
  "value": BigNumber,
  "gas": 314159,
  "gasPrice": BigNumber,
  "input": "0x57cb2fc4"
}
*/
```

***
#### web3.platon.getTransactionFromBlock

返回指定区块的指定序号的交易。

##### 调用：
getTransactionFromBlock(hashStringOrNumber, indexNumber [, callback])

##### 参数：
- String - 区块号或哈希。或者是earliest，latest或pending。查看web3.platon.defaultBlock了解可选值
- Number - 交易的序号
- Function - 回调函数，用于支持异步的方式执行

##### 返回值：
 `Object` - 交易对象，详见web3.platon.getTransaction

##### 示例：
```js
var transaction = web3.platon.getTransactionFromBlock('0x4534534534', 2);
console.log(transaction); // see web3.platon.getTransaction
```
***

#### web3.platon.getTransactionReceipt

通过一个交易哈希，返回一个交易的收据。

**备注** 处于pending状态的交易，收据是不可用的。

##### 调用：
web3.platon.getTransactionReceipt(hashString [, callback])

##### 参数：
- String - 交易的哈希
- Function - 回调函数，用于支持异步的方式执行

##### 返回值：
- `Object` - A transaction receipt object, or `null` when no receipt was found:
  - blockHash: String - 32字节，这个交易所在区块的哈希
  - blockNumber: Number - 交易所在区块的块号
  - transactionHash: String - 32字节，交易的哈希值
  - transactionIndex: Number - 交易在区块里面的序号，整数
  - from: String - 20字节，交易发送者的地址
  - to: String - 20字节，交易接收者的地址。如果是一个合约创建的交易，返回null
  - cumulativeGasUsed: Number - 当前交易执行后累计花费的gas总值10
  - gasUsed: Number - 执行当前这个交易单独花费的gas
  - contractAddress: String - 20字节，创建的合约地址。如果是一个合约创建交易，返回合约地址，其它情况返回  - null
  - logs: Array - 这个交易产生的日志对象数组

##### 示例：
```js
var receipt = web3.platon.getTransactionReceipt('0x9fc76417374aa880d4449a1f7f31ec597f00b1f6f3dd2d66f4c9c6c445836d8b');
console.log(receipt);
{
  "transactionHash": "0x9fc76417374aa880d4449a1f7f31ec597f00b1f6f3dd2d66f4c9c6c445836d8b",
  "transactionIndex": 0,
  "blockHash": "0xef95f2f1ed3ca60b048b4bf67cde2195961e0bba6f70bcbea9a2c4e133e34b46",
  "blockNumber": 3,
  "contractAddress": "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b",
  "cumulativeGasUsed": 314159,
  "gasUsed": 30234,
  "logs": [{
         // logs as returned by getFilterLogs, etc.
     }, ...],
  "status": "0x1"
}
```

***
#### web3.platon.getTransactionCount

返回指定区块的指定地址的交易。

##### 调用：
web3.platon.getTransactionCount(addressHexString [, defaultBlock] [, callback])

##### 参数：
- String - 要获得交易数的地址
- Number|String -（可选）如果未传递参数，默认使用web3.platon.defaultBlock定义的块，否则使用指定区块
- Function - 回调函数，用于支持异步的方式执行

##### 返回值：
 `Number` - 指定地址发送的交易数量

##### 示例：
```js
var number = web3.platon.getTransactionCount("0x407d73d8a49eeb85d32cf465507dd71d507100c1");
console.log(number); // 1
```

***
#### web3.platon.sendTransaction

发送一个交易到网络。

##### 调用：
web3.platon.sendTransaction(transactionObject [, callback])

##### 参数：
- `Object` - 要发送的交易对象
  - from: String - 指定的发送者的地址。如果不指定，使用web3.platon.defaultAccount
  - to: String - （可选）交易消息的目标地址，如果是合约创建，则不填.
  - value: Number|String|BigNumber - （可选）交易携带的货币量，以von为单位。如果合约创建交易，则为初始的基金
  - gas: Number|String|BigNumber - （可选）默认是自动，交易可使用的gas，未使用的gas会退回
  - gasPrice: Number|String|BigNumber - （可选）默认是自动确定，交易的gas价格，默认是网络gas价格的平均值 
  - data: String - （可选）或者包含相关数据的字节字符串，如果是合约创建，则是初始化要用到的代码
  - nonce: Number - （可选）整数，使用此值，可以允许你覆盖你自己的相同nonce的，正在pending中的交易
- `Function` - (可选) 回调函数，用于支持异步的方式执行

##### 返回值：
 `String` - 32字节的交易哈希串。用16进制表示

如果交易是一个合约创建，请使用web3.platon.getTransactionReceipt()在交易完成后获取合约的地址

##### 示例：
```js
var code = "603d80600c6000396000f3007c01000000000000000000000000000000000000000000000000000000006000350463c6888fa18114602d57005b6007600435028060005260206000f3";
 web3.platon.sendTransaction({data: code}, function(err, transactionHash) {
  if (!err)
    console.log(transactionHash); // "0x7f9fade1c0d57a7af66ab4ead7c2eb7b11a91385"
});
```
***

#### web3.platon.sendRawTransaction

发送一个已经签名的交易。

##### 调用：
web3.platon.sendRawTransaction(signedTransactionData [, callback])

##### 参数：
1. `String` - 16进制格式的签名交易数据
2. `Function` - (可选) 回调函数，用于支持异步的方式执行

##### 返回值：
 `String` - 32字节的16进制格式的交易哈希串

##### 示例：
```js
var Tx = require('ethereumjs-tx');
var privateKey = new Buffer('e331b6d69882b4cb4ea581d88e0b604039a3de5967688d3dcffdd2270c0fd109', 'hex')
 var rawTx = {
  nonce: '0x00',
  gasPrice: '0x09184e72a000', 
  gasLimit: '0x2710',
  to: '0x0000000000000000000000000000000000000000', 
  value: '0x00', 
  data: '0x7f7465737432000000000000000000000000000000000000000000000000000000600057'
}
 var tx = new Tx(rawTx);
tx.sign(privateKey);
 var serializedTx = tx.serialize();
 //console.log(serializedTx.toString('hex'));
//f889808609184e72a00082271094000000000000000000000000000000000000000080a47f74657374320000000000000000000000000000000000000000000000000000006000571ca08a8bbf888cfa37bbf0bb965423625641fc956967b81d12e23709cead01446075a01ce999b56a8a88504be365442ea61239198e23d1fce7d00fcfc5cd3b44b7215f
 web3.platon.sendRawTransaction('0x' + serializedTx.toString('hex'), function(err, hash) {
  if (!err)
    console.log(hash); // "0x7f9fade1c0d57a7af66ab4ead79fade1c0d57a7af66ab4ead7c2c2eb7b11a91385"
});
```

***
#### web3.platon.sign

使用指定帐户签名要发送的数据，帐户需要处于unlocked状态。

##### 调用：
web3.platon.sign(address, dataToSign, [, callback])

##### 参数：
1. `String` - 签名使用的地址
2. `String` - 要签名的数据
3. `Function` - (可选) 回调函数，用于支持异步的方式执行

##### 返回值：
 `String` - 签名后的数据

返回的值对应的是ECDSA（Elliptic Curve Digital Signature Algorithm）签名后的字符串

```
r = signature[0:64]
s = signature[64:128]
v = signature[128:130]
```

需要注意的是，如果你使用ecrecover，这里的v值是00或01，所以如果你想使用他们，你需要把这里的v值转成整数，再加上27。最终你要用的值将是27或28。

##### 示例：
```js
var result = web3.platon.sign("0x135a7de83802408321b74c322f8558db1679ac20",
    "0x9dd2c369a187b4e6b9c402f030e50743e619301ea62aa4c0737d4ef7e10a3d49"); // second argument is web3.sha3("xyz")
console.log(result); // "0x30755ed65396facf86c53e6217c52b4daebe72aa4941d89635409de4c9c7f9466d4e9aaec7977f05e923889b33c0d0dd27d7226b6e6f56ce737465c5cfd04be400"
```

***
#### web3.platon.call

在节点的VM中，直接执行消息调用交易。但不会将数据合并区块链中（这样的调用不会修改状态）。

##### 调用：
web3.platon.call(callObject [, defaultBlock] [, callback])

##### 参数：
1. `Object` - 返回一个交易对象，同web3.platon.sendTransaction。与sendTransaction的区别在于，from属性是可选的
2. `Number|String` - (可选) 如果不设置此值使
3. `Function` - (可选) 回调函数，用于支持异步的方式执行

##### 返回值：
 `String` - 函数调用返回的值

##### 示例：
```js
var result = web3.platon.call({
    to: "0xc4abd0339eb8d57087278718986382264244252f", 
    data: "0xc6888fa10000000000000000000000000000000000000000000000000000000000000003"
});
console.log(result); // "0x0000000000000000000000000000000000000000000000000000000000000015"
```

***
#### web3.platon.estimateGas

在节点的VM节点中执行一个消息调用，或交易。但是不会合入区块链中。返回使用的gas量。

##### 调用：
web3.platon.estimateGas(callObject [, callback])

##### 参数：
同web3.platon.sendTransaction，所有的属性都是可选的

##### 返回值：
 `Number` - 模拟的call/transcation花费的gas

##### 示例：
```js
var result = web3.platon.estimateGas({
    to: "0xc4abd0339eb8d57087278718986382264244252f", 
    data: "0xc6888fa10000000000000000000000000000000000000000000000000000000000000003"
});
console.log(result); // "0x0000000000000000000000000000000000000000000000000000000000000015"
```

***
#### web3.platon.filter
```js
// can be 'latest' or 'pending'
var filter = web3.platon.filter(filterString);
// OR object are log filter options
var filter = web3.platon.filter(options);
 // watch for changes
filter.watch(function(error, result){
  if (!error)
    console.log(result);
});
 // Additionally you can start watching right away, by passing a callback:
web3.platon.filter(options, function(error, result){
  if (!error)
    console.log(result);
});
```

##### 参数：
 1. `String|Object` - 字符串的可取值[latest，pending]。latest表示监听最新的区块变化，pending表示监听正在pending的区块。如果需要按条件对象过滤，如下：
  * `fromBlock`: `Number|String` - 起始区块号（如果使用字符串latest，意思是最新的，正在打包的区块），默认值是latest
  * `toBlock`: `Number|String` - 终止区块号（如果使用字符串latest，意思是最新的，正在打包的区块），默认值是latest
  * `address`: `String` - 单个或多个地址。获取指定帐户的日志
  * `topics`: `Array of Strings` - 在日志对象中必须出现的字符串数组。顺序非常重要，如果你想忽略主题， 如，[null,'0x00...']，你还可以为每个主题传递一个单独的可选项数组，如[null,['option1','option1']]

##### 返回值：
 `Object` - A filter object with the following methods:
  * `filter.get(callback)`: 返回满足过滤条件的日志
  * `filter.watch(callback)`: 监听满足条件的状态变化，满足条件时调用回调
  * `filter.stopWatching()`: 停止监听，清除节点中的过滤。你应该总是在监听完成后，执行这个操作

##### Watch callback return value
- `String` - 当使用latest参数时。返回最新的一个区块哈希值
- `String` - 当使用pending参数时。返回最新的pending中的交易哈希值
- `Object` - 当使用手工过滤选项时，将返回下述的日志对象
  - logIndex: Number - 日志在区块中的序号。如果是pending的日志，则为null
  - transactionIndex: Number - 产生日志的交易在区块中的序号。如果是pending的日志，则为null
  - transactionHash: String，32字节 - 产生日志的交易哈希值
  - blockHash: String，32字节 - 日志所在块的哈希。如果是pending的日志，则为null
  - blockNumber: Number - 日志所在块的块号。如果是pending的日志，则为null
  - address: String，32字节 - 日志产生的合约地址
  - data: string - 包含日志一个或多个32字节的非索引的参数
  - topics: String[] - 一到四个32字节的索引的日志参数数组（在Solidity中，第一个主题是整个事件的签名（如，Deposit(address,bytes32,uint256)），但如果使用匿名的方式定义事件的情况除外）


##### 示例：
```js
var filter = web3.platon.filter({toBlock:'pending'});
 filter.watch(function (error, log) {
  console.log(log); //  {"address":"0x0000000000000000000000000000000000000000", "data":"0x0000000000000000000000000000000000000000000000000000000000000000", ...}
});
 // get all past logs again.
var myResults = filter.get(function(error, logs){ ... });
 ...
 // stops and uninstalls the filter
filter.stopWatching();
```
***

## 内置合约调用指南

### 概述
通过对调用对象 ppos（经济模型相关内置合约） 的 call 或者 send 函数将传进来的参数转换为 rpc 接口 platon_call 或者 platon_sendRawTransaction 调用所需要的参数，然后将交易发送至链上。以及完成 call 与 send 调用入参需要的一些辅助函数。

### 简要使用
在调用`const web3 = new Web3('http://127.0.0.1:6789');`实例化一个web3的时候，系统会自动在 web3 后面附加一个 ppos 对象。也就是说你可以直接使用web3.ppos 调用 ppos 有的一些方法。但是如果要使用ppos对象发送上链的交易，那么除了在实例化`web3`的时候传进去的 provider，还至少需要发送交易签名需要的私钥以及链id，其中的链id可通过rpc接口`admin_nodeInfo`返回的`'chainId': xxx`获取。

当然，为了满足在能任意实例多个ppos(比如我要实例3个ppos给不同的链上同时发送交易调用)，我还会在web3对象上附上一个PPOS对象(注意全部是大写)。你可以调用`new PPOS(setting)`实例化一个ppos对象。一个调用示例如下：

```JavaScript
(async () => {
    const Web3 = require('web3');
    const web3 = new Web3('http://192.168.120.164:6789');
    const ppos = web3.ppos; // 后面例子我都以 ppos 为对象。就不写成 web3.ppos 了。

    // 更新 ppos 的配置，发送上链交易必须要做这一步
    // 由于在实例化web3的时候已传入了 provider, 可以不传入provider了。
    ppos.updateSetting({
        privateKey: 'acc73b693b79bbb56f89f63ccc3a0c00bf1b8380111965bfe8ab22e32045600c',
        chainId: 100,
    })

    let data, reply;

    // 传参以对象形式发送交易： 1000. createStaking() : 发起质押
    const benefitAddress = '0xe6F2ce1aaF9EBf2fE3fbA8763bABaDf25e3fb5FA';
    const nodeId = '80f1fcee54de74dbf7587450f31c31c0e057bedd4faaa2a10c179d52c900ca01f0fb255a630c49d83b39f970d175c42b12a341a37504be248d76ecf592d32bc0';
    const amount = '10000000000000000000000000000';
    const blsPubKey = 'd2459db974f49ca9cbf944d4d04c2d17888aef90858b62d6aec166341a6e886e8c0c0cfae9e469c2f618f5d9b7a249130d10047899da6154288c9cde07b576acacd75fef07ba0cfeb4eaa7510704e77a9007eff5f1a5f8d099e6ea664129780c';
    data = {
        funcType: 1000,
        typ: 0,
        benefitAddress: ppos.hexStrBuf(benefitAddress),
        nodeId: ppos.hexStrBuf(nodeId),
        externalId: 'externalId',
        nodeName: 'Me',
        website: 'www.platon.network',
        details: 'staking',
        amount: ppos.bigNumBuf(amount),
        programVersion: undefined, // rpc 获取
        programVersionSign: undefined, // rpc 获取
        blsPubKey: ppos.hexStrBuf(blsPubKey),
        blsProof: undefined, // rpc 获取
    }
    let pv = await ppos.rpc('admin_getProgramVersion');
    let blsProof = await ppos.rpc('admin_getSchnorrNIZKProve');
    data.programVersion = pv.Version;
    data.programVersionSign = pv.Sign;
    data.blsProof = ppos.hexStrBuf(blsProof);
    reply = await ppos.send(data);
    console.log('createStaking params object reply: ', JSON.stringify(reply, null, 2));

    // 传参以数组形式发送交易： 1000. createStaking() : 发起质押
    data = [
        1000,
        0,
        ppos.hexStrBuf(benefitAddress),
        ppos.hexStrBuf(nodeId),
        'externalId',
        'Me',
        'www.platon.network',
        'staking',
        ppos.bigNumBuf(amount),
        pv.Version,
        pv.Sign,
        ppos.hexStrBuf(blsPubKey),
        ppos.hexStrBuf(blsProof)
    ];
    // 由于上面已调用过，交易会上链，但是业务会失败
    reply = await ppos.send(data);
    console.log('createStaking params array reply: ', reply);

    // 传参以对象形式调用： 1102. getCandidateList() : 查询所有实时的候选人列表
    data = {
        funcType: 1102,
    }
    reply = await ppos.call(data);
    console.log('getCandidateList params object reply: ', reply);

    // 传参以数组形式调用： 1102. getCandidateList() : 查询所有实时的候选人列表
    data = [1102];
    reply = await ppos.call(data);
    console.log('getCandidateList params array reply: ', reply);

    // 重新实例化一个ppos1对象出来调用
    const ppos1 = new web3.PPOS({
        provider: 'http://127.0.0.1:6789',
        privateKey: '9f9b18c72f8e5154a9c59af2a35f73d1bdad37b049387fc6cea2bac89804293b',
        chainId: 100,
    })
    reply = await ppos1.call(data);
})()
```

日志信息输出如下。为了节省篇幅，有删减

```
createStaking params object reply:  {
  "blockHash": "0xdddd6b12919b69169b63d17fece52e8632fe3d8b48166c8b4ef8fdee39a1f35c",
  "blockNumber": "0xb",
  "contractAddress": null,
  "cumulativeGasUsed": "0x14f34",
  "from": "0x714de266a0effa39fcaca1442b927e5f1053eaa3",
  "gasUsed": "0x14f34",
  "logs": [
    {
      "address": "0x1000000000000000000000000000000000000002",
      "topics": [
        "0xd63087bea9f1800eed943829fc1d61e7869764805baa3259078c1caf3d4f5a48"
      ],
      "data": "0xe3a27b22436f6465223a302c2244617461223a22222c224572724d7367223a226f6b227d",
      "blockNumber": "0xb",
      "transactionHash": "0x4bee71e351076a81482e2576e469a8dfaa76da9b6cc848265c10968d6de67364",
      "transactionIndex": "0x0",
      "blockHash": "0xdddd6b12919b69169b63d17fece52e8632fe3d8b48166c8b4ef8fdee39a1f35c",
      "logIndex": "0x0",
      "removed": false,
      "dataStr": {
        "Code": 0,
        "Data": "",
        "ErrMsg": "ok"
      }
    }
  ],
  "logsBloom": "",
  "root": "0x3b7a41cea97f90196039586a3068f6a64c09aa7597898440c3c241a095e37984",
  "to": "0x1000000000000000000000000000000000000002",
  "transactionHash": "0x4bee71e351076a81482e2576e469a8dfaa76da9b6cc848265c10968d6de67364",
  "transactionIndex": "0x0"
}

createStaking params array reply:  { blockHash:
   '0x43351e4a9f1b7173552094bacfd5b6f84f18a6c7c0c02d8a10506e3a61041117',
  blockNumber: '0x10',
  contractAddress: null,
  cumulativeGasUsed: '0x14f34',
  from: '0x714de266a0effa39fcaca1442b927e5f1053eaa3',
  gasUsed: '0x14f34',
  logs:
   [ { address: '0x1000000000000000000000000000000000000002',
       topics: [Array],
       data:
        '0xf846b8447b22436f6465223a3330313130312c2244617461223a22222c224572724d7367223a22546869732063616e64696461746520697320616c7265616479206578697374227d',
       blockNumber: '0x10',
       transactionHash:
        '0xe5cbc728d6e284464c30ce6f0bbee5fb2b30351a591424f3a0edd37cc1bbdc05',
       transactionIndex: '0x0',
       blockHash:
        '0x43351e4a9f1b7173552094bacfd5b6f84f18a6c7c0c02d8a10506e3a61041117',
       logIndex: '0x0',
       removed: false,
       dataStr: [Object] } ],
  logsBloom:'',
  root:
   '0x45ffeda340b68a0d54c5556a51f925b0787307eab1fb120ed141fd8ba81183d4',
  to: '0x1000000000000000000000000000000000000002',
  transactionHash:
   '0xe5cbc728d6e284464c30ce6f0bbee5fb2b30351a591424f3a0edd37cc1bbdc05',
  transactionIndex: '0x0' }

getCandidateList params object reply:  { 
  Code: 0,
  Data:
   [ { candidate1 info... },
     { candidate2 info... },
     { candidate3 info... },
     { candidate4 info... } 
   ],
  ErrMsg: 'ok' }

getCandidateList params array reply:  { 
  Code: 0,
  Data:
   [ { candidate1 info... },
     { candidate2 info... },
     { candidate3 info... },
     { candidate4 info... } 
   ],
  ErrMsg: 'ok' }
```

### API 调用详细说明

#### `updateSetting(setting)`
更新 ppos 对象的配置参数。如果你只需要发送call调用，那么只需要传入 provider 即可。如果你在实例化 web3 的时候已经传入了 provider。那么会ppos的provider默认就是你实例化web3传进来的provider。当然你也可以随时更新provider。

如果你要发送send交易，那么除了provider，还必须要传入发送交易所需要的私钥以及链id。当然，发送交易需要设置的gas, gasPrice, retry, interval这四个参数详细请见`async send(params, [other])`说明。

对传入的参数，你可以选择部分更新，比如你对一个ppos对象，发送某个交易时想使用私钥A，那么你在调用`send(params, [other])`之前执行 `ppos.updateSetting({privateKey: youPrivateKeyA})`更新私钥即可。一旦更新之后，将会覆盖当前配置，后面调用发送交易接口，将默认以最后一次更新的配置。

入参说明：
* setting Object
  * provider String 链接
  * privateKey String 私钥
  * chainId String 链id
  * gas String 燃料最大消耗，请输入十六进制字符串，比如 '0x76c0000'
  * gasPrice String 燃料价格，请输入十六进制字符串，比如 '0x9184e72a000000'
  * retry Number 查询交易收据对象次数。
  * interval Number 查询交易收据对象的间隔，单位为ms。

无出参。

调用示例
```JavaScript
// 同时更新 privateKey，chainId
ppos.updateSetting({
    privateKey: 'acc73b693b79bbb56f89f63ccc3a0c00bf1b8380111965bfe8ab22e32045600c',
    chainId: 100,
})

// 只更新 privateKey
ppos.updateSetting({
    privateKey: '9f9b18c72f8e5154a9c59af2a35f73d1bdad37b049387fc6cea2bac89804293b'
})
```

***

#### `getSetting()`
查询你配置的参数

无入参

出参
* setting Object
  * provider String 链接
  * privateKey String 私钥
  * chainId String 链id
  * gas String 燃料最大消耗
  * gasPrice String 燃料价格
  * retry Number 查询交易收据对象次数。
  * interval Number 查询交易收据对象的间隔，单位为ms。

调用示例
```JavaScript
let setting = ppos.getSetting();
```

***

#### `async rpc(method, [params])`
发起 rpc 请求。一个辅助函数，因为在调用ppos发送交易的过程中，有些参数需要通过rpc来获取，所以特意封装了一个rpc供调用。注意此接口为async函数，需要加await返回调用结果，否则返回一个Promise对象。

入参说明：
* method String 方法名
* params Array 调用rpc接口需要的参数，如果调用此rpc端口不需要参数，则此参数可以省略。
  
出参
* reply rpc调用返回的结果

调用示例
```JavaScript
// 获取程序版本
let reply = await ppos.rpc('admin_getProgramVersion'); 

// 获取所有账号
let reply = await ppos.rpc('platon_accounts')

// 获取一个账号的金额
let reply = await ppos.rpc('platon_getBalance', ["0x714de266a0effa39fcaca1442b927e5f1053eaa3","latest"])
```

***

#### `bigNumBuf(intStr)`
将一个字符串的十进制大整数转为一个RLP编码能接受的buffer对象。一个辅助函数。因为JavaScript的正数范围只能最大表示为2^53，为了RLP能对大整数进行编码，需要将字符串的十进制大整数转换为相应的Buffer。注意，此接口暂时只能对十进制的大整数转为Buffer，如果是十六进制的字符串，您需要先将他转为十进制的字符串。

入参说明：
* intStr String 字符串十进制大整数。
  
出参
* buffer Buffer 一个缓存区。

调用示例
```JavaScript
let buffer = ppos.bigNumBuf('1000000000000000000000000000000000000000000'); 
```

***

#### `hexStrBuf(hexStr)`
将一个十六进制的字符串转为一个RLP编码能接受的buffer对象。一个辅助函数。在ppos发送交易的过程中，我们很多参数需要作为bytes传送而不是string，比如 `nodeId 64bytes 被质押的节点Id(也叫候选人的节点Id)`。而写代码时候的nodeId只能以字符串的形式表现。需要将他转为一个 64 bytes 的 Buffer。

注意：如果你传进去的字符串以 0x 或者 0X 开头，系统会默认为你是表示一个十六进制字符串不对开头的这两个字母进行编码。如果你确实要对 0x 或者 0X 编码，那你必须在字符串前面再加前缀 0x。比如，你要对全字符串 0x31c0e0 (4 bytes) 进行编码，那么必须传入 0x0x31c0e0 。

入参说明：
* hexStr String 一个十六进制的字符串。
  
出参
* buffer Buffer 一个缓存区。

调用示例
```JavaScript
const nodeId = '80f1fcee54de74dbf7587450f31c31c0e057bedd4faaa2a10c179d52c900ca01f0fb255a630c49d83b39f970d175c42b12a341a37504be248d76ecf592d32bc0';
let buffer = ppos.hexStrBuf(nodeId); 
```

***

#### `async call(params)`
发送一个 ppos 的call查询调用。不上链。所以你需要自行区分是否是查询或者是发送交易。入参可以选择对象或者数组。如果你选择传入对象，那么你需要使用规定的字符串key，但是对key要求不做顺序。你可以这样写`{a: 1, b: 'hello'}` 或者 `{b: 'hello', a: 1}`都没问题。

如果你选择以数组作为入参，那么你**必须严格按照入参的顺序依次将参数放到数组里面**。注意，对一些字符串大整数以及需要传入的bytes，请选择上面提供的接口`bigNumBuf(intStr)`跟`hexStrBuf(hexStr)`自行进行转换再传入。

注意此接口为async函数，需要加await返回调用结果，否则返回一个Promise对象。

入参说明：
* params Object | Array 调用参数。
  
出参
* reply Object call调用的返回的结果。注意，我已将将返回的结果转为了Object对象。
  * Code Number 调用返回码，0表示调用结果正常。
  * Data Array | Object | String | Number... 根据调用结果返回相应类型
  * ErrMsg String 调用提示信息。

以调用 `查询当前账户地址所委托的节点的NodeID和质押Id`这个接口，入参顺序从上到下，入参如下所示：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1103)|
|addr|common.address(20bytes)|委托人的账户地址|

调用示例
```JavaScript
let params, reply;

// 以传进入对象进行调用(对于key不要求顺序)
params = {
    funcType: 1103,
    addr: ppos.hexStrBuf("0xe6F2ce1aaF9EBf2fE3fbA8763bABaDf25e3fb5FA")
}
reply = await ppos.call(params);

// 以传入数组对象进行调用
params = [1103, ppos.hexStrBuf("0xe6F2ce1aaF9EBf2fE3fbA8763bABaDf25e3fb5FA")];
reply = await ppos.call(params);
```

***

#### `async send(params, [other])`
发送一个 ppos 的send发送交易调用。上链。所以你需要自行区分是否是查询或者是发送交易。入参可以选择对象或者数组。传入规则请看上述`async call(params)`调用。

由于是一个交易，将会涉及到调用交易需要的一些参数，比如gas，gasPrice。当交易发送出去之后，为了确认交易是否上链，需要不断的通过交易哈希去轮询链上的结果。这就有个轮询次数 retry 与每次轮询之间的间隔 interval。

对于上面提到的 gas, gasPrice, retry, interval 这四个参数，如果other入参有指定，则使用other指定的。如果other入参未指定，则使用调用函数时候`updateSetting(setting)`指定的参数，否则使用默认的数值。

注意此接口为async函数，需要加await返回调用结果，否则返回一个Promise对象。

入参说明：
* params Object|Array 调用参数。
* other Object 其他参数
  * gas String 燃油限制，默认 '0x76c0000'。
  * gasPrice String 燃油价格，默认 '0x9184e72a000000'。
  * retry Number 查询交易收据对象次数，默认 600 次。
  * interval Number 查询交易收据对象的间隔，单位为ms。默认 100 ms。

出参
* reply Object 调用成功！send调用方法返回指定交易的收据对象
  * status - Boolean: 成功的交易返回true，如果EVM回滚了该交易则返回false
  * blockHash 32 Bytes - String: 交易所在块的哈希值
  * blockNumber - Number: 交易所在块的编号
  * transactionHash 32 Bytes - String: 交易的哈希值
  * transactionIndex - Number: 交易在块中的索引位置
  * from - String: 交易发送方的地址
  * to - String: 交易接收方的地址，对于创建合约的交易，该值为null
  * contractAddress - String: 对于创建合约的交易，该值为创建的合约地址，否则为null
  * cumulativeGasUsed - Number: 该交易执行时所在块的gas累计总用量
  * gasUsed- Number: 该交易的gas总量
  * logs - Array: 该交易产生的日志对象数组

* errMsg String 调用失败！如果发送交易返回之后没有回执，则返回错误信息`no hash`。如果发送交易之后有回执，但是在规定的时间内没有查到收据对象，则返回 `getTransactionReceipt txHash ${hash} interval ${interval}ms by ${retry} retry failed`

以调用 `发起委托`这个接口，入参顺序从上到下，入参如下所示：

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1004)|
|typ|uint16(2bytes)|表示使用账户自由金额还是账户的锁仓金额做委托，0: 自由金额； 1: 锁仓金额|
|nodeId|64bytes|被质押的节点的NodeId|
|amount|big.Int(bytes)|委托的金额(按照最小单位算，1LAT = 10^18 von)|


调用示例
```JavaScript
const nodeId = "f71e1bc638456363a66c4769284290ef3ccff03aba4a22fb60ffaed60b77f614bfd173532c3575abe254c366df6f4d6248b929cb9398aaac00cbcc959f7b2b7c";
let params, others, reply;

// 以传进入对象进行调用(对于key不要求顺序)
params = {
    funcType: 1004,
    typ: 0,
    nodeId: ppos.hexStrBuf(nodeId),
    amount: ppos.bigNumBuf("10000000000000000000000")
}
reply = await ppos.send(params);

// 以传入数组对象进行调用
params = [1004, 0, ppos.hexStrBuf(nodeId), ppos.bigNumBuf("10000000000000000000000")];
reply = await ppos.send(params);

// 我不想默认的轮询
other = {
    retry: 300, // 只轮询300次
    interval: 200 // 每次轮询间隔200ms
}
params = [1004, 0, ppos.hexStrBuf(nodeId), ppos.bigNumBuf("10000000000000000000000")];
reply = await ppos.send(params, other);
```

### 内置合约入参详细说明

#### 质押

* 发起质押，send 发送交易。


|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1000)|
|typ|uint16(2bytes)|表示使用账户自由金额还是账户的锁仓金额做质押，0: 自由金额； 1: 锁仓金额|
|benefitAddress|20bytes|用于接受出块奖励和质押奖励的收益账户|
|nodeId|64bytes|被质押的节点Id(也叫候选人的节点Id)|
|externalId|string|外部Id(有长度限制，给第三方拉取节点描述的Id)|
|nodeName|string|被质押节点的名称(有长度限制，表示该节点的名称)|
|website|string|节点的第三方主页(有长度限制，表示该节点的主页)|
|details|string|节点的描述(有长度限制，表示该节点的描述)|
|amount|*big.Int(bytes)|质押的von|
|programVersion|uint32|程序的真实版本，治理rpc获取|
|programVersionSign|65bytes|程序的真实版本签名，治理rpc获取|
|blsPubKey|96bytes|bls的公钥|
|blsProof|64bytes|bls的证明,通过拉取证明接口获取|

* 修改质押信息，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1001)|
|benefitAddress|20bytes|用于接受出块奖励和质押奖励的收益账户|
|nodeId|64bytes|被质押的节点Id(也叫候选人的节点Id)|
|externalId|string|外部Id(有长度限制，给第三方拉取节点描述的Id)|
|nodeName|string|被质押节点的名称(有长度限制，表示该节点的名称)|
|website|string|节点的第三方主页(有长度限制，表示该节点的主页)|
|details|string|节点的描述(有长度限制，表示该节点的描述)|


* 增持质押，send 发送交易。

入参：

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1002)|
|nodeId|64bytes|被质押的节点Id(也叫候选人的节点Id)|
|typ|uint16(2bytes)|表示使用账户自由金额还是账户的锁仓金额做质押，0: 自由金额； 1: 锁仓金额|
|amount|*big.Int(bytes)|增持的von|


* 撤销质押(一次性发起全部撤销，多次到账)，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1003)|
|nodeId|64bytes|被质押的节点的NodeId|

* 发起委托，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1004)|
|typ|uint16(2bytes)|表示使用账户自由金额还是账户的锁仓金额做委托，0: 自由金额； 1: 锁仓金额|
|nodeId|64bytes|被质押的节点的NodeId|
|amount|*big.Int(bytes)|委托的金额(按照最小单位算，1LAT = 10**18 von)|

* 减持/撤销委托(全部减持就是撤销)，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1005)|
|stakingBlockNum|uint64(8bytes)|代表着某个node的某次质押的唯一标示|
|nodeId|64bytes|被质押的节点的NodeId|
|amount|*big.Int(bytes)|减持委托的金额(按照最小单位算，1LAT = 10**18 von)|

* 查询当前结算周期的验证人队列，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1100)|

**查询结果统一格式**

|名称|类型|说明|
|---|---|---|
|Code|uint32| 表示ppos内置合约返回的错误码|
|Data|string| json字符串的查询结果，具体格式参见以下查询相关接口返回值 |
|ErrMsg|string| 错误提示信息|

> 注：以下查询接口（platon_call调用的接口）如无特殊声明，返回参数都按照上述格式返回

返参： 列表

|名称|类型|说明|
|---|---|---|
|NodeId|64bytes|被质押的节点Id(也叫候选人的节点Id)|
|StakingAddress|20bytes|发起质押时使用的账户(后续操作质押信息只能用这个账户，撤销质押时，von会被退回该账户或者该账户的锁仓信息中)|
|BenefitAddress|20bytes|用于接受出块奖励和质押奖励的收益账户|
|StakingTxIndex|uint32(4bytes)|发起质押时的交易索引|
|ProgramVersion|uint32|被质押节点的PlatON进程的真实版本号(获取版本号的接口由治理提供)|
|StakingBlockNum|uint64(8bytes)|发起质押时的区块高度|
|Shares|*big.Int(bytes)|当前候选人总共质押加被委托的von数目|
|ExternalId|string|外部Id(有长度限制，给第三方拉取节点描述的Id)|
|NodeName|string|被质押节点的名称(有长度限制，表示该节点的名称)|
|Website|string|节点的第三方主页(有长度限制，表示该节点的主页)|
|Details|string|节点的描述(有长度限制，表示该节点的描述)|
|ValidatorTerm|uint32(4bytes)|验证人的任期(在结算周期的101个验证人快照中永远是0，只有在共识轮的验证人时才会被有值，刚被选出来时也是0，继续留任时则+1)|

* 查询当前共识周期的验证人列表，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1101)|

返参： 列表

|名称|类型|说明|
|---|---|---|
|NodeId|64bytes|被质押的节点Id(也叫候选人的节点Id)|
|StakingAddress|20bytes|发起质押时使用的账户(后续操作质押信息只能用这个账户，撤销质押时，von会被退回该账户或者该账户的锁仓信息中)|
|BenefitAddress|20bytes|用于接受出块奖励和质押奖励的收益账户|
|StakingTxIndex|uint32(4bytes)|发起质押时的交易索引|
|ProgramVersion|uint32(4bytes)|被质押节点的PlatON进程的真实版本号(获取版本号的接口由治理提供)|
|StakingBlockNum|uint64(8bytes)|发起质押时的区块高度|
|Shares|*big.Int(bytes)|当前候选人总共质押加被委托的von数目|
|ExternalId|string|外部Id(有长度限制，给第三方拉取节点描述的Id)|
|NodeName|string|被质押节点的名称(有长度限制，表示该节点的名称)|
|Website|string|节点的第三方主页(有长度限制，表示该节点的主页)|
|Details|string|节点的描述(有长度限制，表示该节点的描述)|
|ValidatorTerm|uint32(4bytes)|验证人的任期(在结算周期的101个验证人快照中永远是0，只有在共识轮的验证人时才会被有值，刚被选出来时也是0，继续留任时则+1)|

* 查询所有实时的候选人列表，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1102)|

返参： 列表

|名称|类型|说明|
|---|---|---|
|NodeId|64bytes|被质押的节点Id(也叫候选人的节点Id)|
|StakingAddress|20bytes|发起质押时使用的账户(后续操作质押信息只能用这个账户，撤销质押时，von会被退回该账户或者该账户的锁仓信息中)|
|BenefitAddress|20bytes|用于接受出块奖励和质押奖励的收益账户|
|StakingTxIndex|uint32(4bytes)|发起质押时的交易索引|
|ProgramVersion|uint32(4bytes)|被质押节点的PlatON进程的真实版本号(获取版本号的接口由治理提供)|
|Status|uint32(4bytes)|候选人的状态(状态是根据uint32的32bit来放置的，可同时存在多个状态，值为多个同时存在的状态值相加【0: 节点可用 (32个bit全为0)； 1: 节点不可用 (只有最后一bit为1)； 2： 节点出块率低但没有达到移除条件的(只有倒数第二bit为1)； 4： 节点的von不足最低质押门槛(只有倒数第三bit为1)； 8：节点被举报双签(只有倒数第四bit为1)); 16: 节点出块率低且达到移除条件(倒数第五位bit为1); 32: 节点主动发起撤销(只有倒数第六位bit为1)】|
|StakingEpoch|uint32(4bytes)|当前变更质押金额时的结算周期|
|StakingBlockNum|uint64(8bytes)|发起质押时的区块高度|
|Shares|string(0x十六进制字符串)|当前候选人总共质押加被委托的von数目|
|Released|string(0x十六进制字符串)|发起质押账户的自由金额的锁定期质押的von|
|ReleasedHes|string(0x十六进制字符串)|发起质押账户的自由金额的犹豫期质押的von|
|RestrictingPlan|string(0x十六进制字符串)|发起质押账户的锁仓金额的锁定期质押的von|
|RestrictingPlanHes|string(0x十六进制字符串)|发起质押账户的锁仓金额的犹豫期质押的von|
|ExternalId|string|外部Id(有长度限制，给第三方拉取节点描述的Id)|
|NodeName|string|被质押节点的名称(有长度限制，表示该节点的名称)|
|Website|string|节点的第三方主页(有长度限制，表示该节点的主页)|
|Details|string|节点的描述(有长度限制，表示该节点的描述)|

* 查询当前账户地址所委托的节点的NodeID和质押Id，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(1103)|
|addr|common.address(20bytes)|委托人的账户地址|

返参： 列表

|名称|类型|说明|
|---|---|---|
|Addr|20bytes|委托人的账户地址|
|NodeId|64bytes|验证人的节点Id|
|StakingBlockNum|uint64(8bytes)|发起质押时的区块高度|


* 查询当前单个委托信息，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16|代表方法类型码(1104)|
|stakingBlockNum|uint64(8bytes)|发起质押时的区块高度|
|delAddr|20bytes|委托人账户地址|
|nodeId|64bytes|验证人的节点Id|

返参： 列表

|名称|类型|说明|
|---|---|---|
|Addr|20bytes|委托人的账户地址|
|NodeId|64bytes|验证人的节点Id|
|StakingBlockNum|uint64(8bytes)|发起质押时的区块高度|
|DelegateEpoch|uint32(4bytes)|最近一次对该候选人发起的委托时的结算周期|
|Released|string(0x十六进制字符串)|发起委托账户的自由金额的锁定期委托的von|
|ReleasedHes|string(0x十六进制字符串)|发起委托账户的自由金额的犹豫期委托的von|
|RestrictingPlan|string(0x十六进制字符串)|发起委托账户的锁仓金额的锁定期委托的von|
|RestrictingPlanHes|string(0x十六进制字符串)|发起委托账户的锁仓金额的犹豫期委托的von|
|Reduction|string(0x十六进制字符串)|处于撤销计划中的von|

* 查询当前节点的质押信息，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16|代表方法类型码(1105)|
|nodeId|64bytes|验证人的节点Id|

返参： 列表

|名称|类型|说明|
|---|---|---|
|NodeId|64bytes|被质押的节点Id(也叫候选人的节点Id)|
|StakingAddress|20bytes|发起质押时使用的账户(后续操作质押信息只能用这个账户，撤销质押时，von会被退回该账户或者该账户的锁仓信息中)|
|BenefitAddress|20bytes|用于接受出块奖励和质押奖励的收益账户|
|StakingTxIndex|uint32(4bytes)|发起质押时的交易索引|
|ProgramVersion|uint32(4bytes)|被质押节点的PlatON进程的真实版本号(获取版本号的接口由治理提供)|
|Status|uint32(4bytes)|候选人的状态(状态是根据uint32的32bit来放置的，可同时存在多个状态，值为多个同时存在的状态值相加【0: 节点可用 (32个bit全为0)； 1: 节点不可用 (只有最后一bit为1)； 2： 节点出块率低但没有达到移除条件的(只有倒数第二bit为1)； 4： 节点的von不足最低质押门槛(只有倒数第三bit为1)； 8：节点被举报双签(只有倒数第四bit为1)); 16: 节点出块率低且达到移除条件(倒数第五位bit为1); 32: 节点主动发起撤销(只有倒数第六位bit为1)】|
|StakingEpoch|uint32(4bytes)|当前变更质押金额时的结算周期|
|StakingBlockNum|uint64(8bytes)|发起质押时的区块高度|
|Shares|string(0x十六进制字符串)|当前候选人总共质押加被委托的von数目|
|Released|string(0x十六进制字符串)|发起质押账户的自由金额的锁定期质押的von|
|ReleasedHes|string(0x十六进制字符串)|发起质押账户的自由金额的犹豫期质押的von|
|RestrictingPlan|string(0x十六进制字符串)|发起质押账户的锁仓金额的锁定期质押的von|
|RestrictingPlanHes|string(0x十六进制字符串)|发起质押账户的锁仓金额的犹豫期质押的von|
|ExternalId|string|外部Id(有长度限制，给第三方拉取节点描述的Id)|
|NodeName|string|被质押节点的名称(有长度限制，表示该节点的名称)|
|Website|string|节点的第三方主页(有长度限制，表示该节点的主页)|
|Details|string|节点的描述(有长度限制，表示该节点的描述)|



#### 治理

* 提交文本提案，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2000)|
|verifier|discover.NodeID(64bytes)|提交提案的验证人|
|pIDID|string(uint64)|PIPID|

* 提交升级提案，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2001)|
|verifier|discover.NodeID(64bytes)|提交提案的验证人|
|pIDID|string(uint64)|PIPID|
|newVersion|uint32(4bytes)|升级版本|
|endVotingRounds|uint64|投票共识轮数量。说明：假设提交提案的交易，被打包进块时的共识轮序号时round1，则提案投票截止块高，就是round1 + endVotingRounds这个共识轮的第230个块高（假设一个共识轮出块250，ppos揭榜提前20个块高，250，20都是可配置的 ），其中0 < endVotingRounds <= 4840（约为2周，实际论述根据配置可计算），且为整数）|


* 提交取消提案，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2005)|
|verifier|discover.NodeID(64bytes)|提交提案的验证人|
|pIDID|string(uint64)|PIPID|
|endVotingRounds|uint64|投票共识轮数量。参考提交升级提案的说明，同时，此接口中此参数的值不能大于对应升级提案中的值|
|tobeCanceledProposalID|common.hash(32bytes)|待取消的升级提案ID|


* 给提案投票，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2003)|
|verifier|discover.NodeID(64bytes)|投票验证人|
|proposalID|common.Hash(32bytes)|提案ID|
|option|uint8(1byte)|投票选项|
|programVersion|uint32(4bytes)|节点代码版本，有rpc的getProgramVersion接口获取|
|versionSign|common.VesionSign(65bytes)|代码版本签名，有rpc的getProgramVersion接口获取|

* 版本声明，send 发送交易。

|参数|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2004)|
|verifier|discover.NodeID(64bytes)|声明的节点，只能是验证人/候选人|
|programVersion|uint32(4bytes)|声明的版本，有rpc的getProgramVersion接口获取|
|versionSign|common.VesionSign(65bytes)|声明的版本签名，有rpc的getProgramVersion接口获取|

* 查询提案，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|2100)|
|proposalID|common.Hash(32bytes)|提案ID|

返参：Proposal接口实现对象的json字符串

* 查询提案结果，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2101)|
|proposalID|common.Hash(32bytes)|提案ID|

返参：TallyResult对象的json字符串

* 查询提案列表，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2102)|

返参：Proposal接口实现对象列表的json字符串。


* 查询节点的链生效版本，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2103)|

返参：版本号的json字符串，如{65536}，表示版本是：1.0.0。
解析时，需要把ver转成4个字节。主版本：第二个字节；小版本：第三个字节，patch版本，第四个字节。


* 查询提案的累积可投票人数，call 查询

入参：

|名称|类型|说明|
|---|---|---|
|funcType|uint16(2bytes)|代表方法类型码(2105)|
|proposalID|common.Hash(32bytes)|提案ID|
|blockHash|common.Hash(32bytes)|块hash|

返参：
是个[]uint16数组

|名称|类型|说明|
|---|---|---|
||uint16|累积可投票人数|
||uint16|赞成票数|
||uint16|反对票数|
||uint16|弃权票数|

**ProposalType 提案类型定义**

|类型|定义|说明|
|---|---|---|
|TextProposal|0x01|文本提案|
|VersionProposal|0x02|升级提案|
|CancelProposal|0x04|取消提案|

**ProposalStatus 提案状态定义**

对文本提案来说，有：0x01,0x02,0x03三种状态；
对升级提案来说，有：0x01,0x03,0x04,0x05,0x06四种状态。
对取消提案来说，有：0x01,0x02,0x03三种状态；

|类型|定义|说明|
|---|---|---|
|Voting|0x01|投票中|
|Pass|0x02|投票通过|
|Failed|0x03|投票失败|
|PreActive|0x04|（升级提案）预生效|
|Active|0x05|（升级提案）生效|
|Canceled|0x06|（升级提案）被取消|

**VoteOption 投票选项定义**

|类型|定义|说明|
|---|---|---|
|Yeas|0x01|支持|
|Nays|0x02|反对|
|Abstentions|0x03|弃权|

**Proposal接口 提案定义**

子类TextProposal：文本提案

字段说明：

|字段|类型|说明|
|---|---|---|
|ProposalID|common.Hash(32bytes)|提案ID|
|Proposer|common.NodeID(64bytes)|提案节点ID|
|ProposalType|byte|提案类型， 0x01：文本提案； 0x02：升级提案；0x03参数提案；0x04取消提案。|
|PIPID|string|提案PIPID|
|SubmitBlock|8bytes|提交提案的块高|
|EndVotingBlock|8bytes|提案投票结束的块高，系统根据SubmitBlock|


子类VersionProposal：升级提案

字段说明：

|字段|类型|说明|
|---|---|---|
|ProposalID|common.Hash(32bytes)|提案ID|
|Proposer|common.NodeID(64bytes)|提案节点ID|
|ProposalType|byte|提案类型， 0x01：文本提案； 0x02：升级提案；0x03参数提案；0x04取消提案。|
|PIPID|string|提案PIPID|
|SubmitBlock|8bytes|提交提案的块高|
|EndVotingRounds|8bytes|投票持续的共识周期数量|
|EndVotingBlock|8bytes|提案投票结束的块高，系统根据SubmitBlock，EndVotingRounds算出|
|ActiveBlock|8bytes|提案生效块高，系统根据EndVotingBlock算出|
|NewVersion|uint|升级版本|


子类CancelProposal：取消提案

字段说明：

|字段|类型|说明|
|---|---|---|
|ProposalID|common.Hash(32bytes)|提案ID|
|Proposer|common.NodeID(64bytes)|提案节点ID|
|ProposalType|byte|提案类型， 0x01：文本提案； 0x02：升级提案；0x03参数提案；0x04取消提案。|
|PIPID|string|提案PIPID|
|SubmitBlock|8bytes|提交提案的块高|
|EndVotingRounds|8bytes|投票持续的共识周期数量|
|EndVotingBlock|8bytes|提案投票结束的块高，系统根据SubmitBlock，EndVotingRounds算出|
|TobeCanceled|common.Hash(32bytes)|提案要取消的升级提案ID|


**Vote 投票定义**

|字段|类型|说明|
|---|---|---|
|voter|64bytes|投票验证人|
|proposalID|common.Hash(32bytes)|提案ID|
|option|VoteOption|投票选项|

**TallyResult 投票结果定义**

|字段|类型|说明|
|---|---|---|
|proposalID|common.Hash(32bytes)|提案ID|
|yeas|uint16(2bytes)|赞成票|
|nays|uint16(2bytes)|反对票|
|abstentions|uint16(2bytes)|弃权票|
|accuVerifiers|uint16(2bytes)|在整个投票期内有投票资格的验证人总数|
|status|byte|状态|
|canceledBy|common.Hash(32bytes)|当status=0x06时，记录发起取消的ProposalID|

#### 举报惩罚

* 举报双签，send 发送交易。


| 参数     | 类型   | 描述                                    |
| -------- | ------ | --------------------------------------- |
| funcType | uint16(2bytes) | 代表方法类型码(3000)                    |
| typ      | uint8         | 代表双签类型，<br />1：prepareBlock，2：prepareVote，3：viewChange |
| data     | string | 单个证据的json值，格式参照[RPC接口Evidences][evidences_interface] |

* 查询节点是否已被举报过多签，call 查询

入参：

| 参数        | 类型           | 描述                                                         |
| ----------- | -------------- | ------------------------------------------------------------ |
| funcType    | uint16(2bytes) | 代表方法类型码(3001)                                         |
| typ         | uint32         | 代表双签类型，<br />1：prepareBlock，2：prepareVote，3：viewChange |
| addr        | 20bytes        | 举报的节点地址                                               |
| blockNumber | uint64         | 多签的块高                                                   |

回参：

| 类型   | 描述           |
| ------ | -------------- |
| 16进制 | 举报的交易Hash |



#### 锁仓

* 创建锁仓计划，send 发送交易。

入参：

| 参数    | 类型           | 说明                                                         |
| ------- | -------------- | ------------------------------------------------------------ |
| account | 20bytes | `锁仓释放到账账户`                                           |
| plan    | []RestrictingPlan | plan 为 RestrictingPlan 类型的列表（数组），RestrictingPlan 定义如下：<br>type RestrictingPlan struct { <br/>    Epoch uint64<br/>    Amount：\*big.Int<br/>}<br/>其中，Epoch：表示结算周期的倍数。与每个结算周期出块数的乘积表示在目标区块高度上释放锁定的资金。Epoch \* 每周期的区块数至少要大于最高不可逆区块高度。<br>Amount：表示目标区块上待释放的金额。 |

* 获取锁仓信息，call 查询

注：本接口支持获取历史数据，请求时可附带块高，默认情况下查询最新块的数据。


入参：

| 参数    | 类型    | 说明               |
| ------- | ------- | ------------------ |
| account | 20bytes | `锁仓释放到账账户` |

返参：

返回参数为下面字段的 json 格式字符串

| 名称    | 类型            | 说明                                                         |
| ------- | --------------- | ------------------------------------------------------------ |
| balance | string(0x十六进制字符串) | 总锁仓余额-已释放金额                                                     |
| pledge    | string(0x十六进制字符串) |质押/抵押金额 |
| debt  | string(0x十六进制字符串)            | 欠释放金额                                                 |
| plans    | bytes           | 锁仓分录信息，json数组：[{"blockNumber":"","amount":""},...,{"blockNumber":"","amount":""}]。其中：<br/>blockNumber：\*big.Int，释放区块高度<br/>amount：\string(0x十六进制字符串)，释放金额 |

### 内置合约错误码说明
| 错误码    | 说明            |
| ------- | --------------- | 
|301000  | Wrong bls public key|
|301001  | Wrong bls public key proof|
|301002  | The Description length is wrong|
|301003  | The program version sign is wrong|
|301004  | The program version of the relates node's is too low|
|301005  | DeclareVersion is failed on create staking|
|301006  | The address must be the same as initiated staking|
|301100  | Staking deposit too low|
|301101  | This candidate is already exist|
|301102  | This candidate is not exist|
|301103  | This candidate status was invalided|
|301104  | IncreaseStake von is too low|
|301105  | Delegate deposit too low|
|301106  | The account is not allowed to be used for delegating|
|301107  | The candidate does not accept the delegation|
|301108  | Withdrew delegation von is too low|
|301109  | This delegation is not exist|
|301110  | The von operation type is wrong|
|301111  | The von of account is not enough|
|301112  | The blockNumber is disordered|
|301113  | The von of delegation is not enough|
|301114  | Withdrew delegation von calculation is wrong|
|301115  | The validator is not exist|
|301116  | The fn params is wrong|
|301117  | The slashing type is wrong|
|301118  | Slashing amount is overflow|
|301119  | Slashing candidate von calculate is wrong|
|301200  | Getting verifierList is failed|
|301201  | Getting validatorList is failed|
|301202  | Getting candidateList is failed|
|301203  | Getting related of delegate is failed|
|301204  | Query candidate info failed|
|301205  | Query delegate info failed|

### 其他
你可以根据test的目录下面config.default.js文件为模板配置好设置保存在同级目录的config.js文件。然后执行`npm run ppos`执行单元测试。更多调用示例请参考test目录下面写的单元测试ppos.js文件