# 离线MTool使用手册 

## 1 简介

为了便于节点进行质押，委托以及治理等相关的操作，PlatON提供了MTool来辅助用户。

- MTool可支持Ubuntu 18.0.4和Windows 10，本文档描述Windows 10环境下的安装和使用
- MTool需要通过RPC接口连接到验证节点，验证节点的安装部署可参考[PlatON节点安装部署手册.md](./PlatON节点安装部署手册.md)
- 为保证节点安全，建议节点RPC端口通过Nginx代理访问，Nginx使用Https和用户认证加强安全防护
- MTool对质押等交易提供两种签名方式：在线签名和离线签名。此文档描述离线签名操作，在线签名请参考[在线MTool使用手册.md](./在线MTool使用手册.md)

## 2 安装MTool

### 2.1 在线MTool

如果已经安装在线MTool，可以忽略此步骤。在线MTool安装步骤如下：

- **step1. **浏览器复制链接 <https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/mtool_install.bat> 下载脚本。

- **step2.** 鼠标右键点击 mtool_install.bat， 选择以管理员身份运行

> 注意
> - 提示 `Enter password:` 时，请输入回车键。
> - 提示 `install and start mtool success` 时，表示 MTool 安装成功，未安装成功时，请通过我们的官方客户联系方式反馈具体问题。
> - 提示 `请按任意键继续. . .` 时，请输入回车键关闭当前 cmd 窗口。

### 2.2 离线MTool

安全考虑，离线MTool应该安装在离线机器（不连接任何网络和WIFI）上。

- 下载MTool安装包

  在有网络的机器上，复制链接<https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/mtool/0.7.3/mtool-setup.exe>到浏览器下载MTool安装包。

- 通过安全存储介质（移动U盘或者移动硬盘）将安装文件mtool-setup.exe转到**离线机器**下

- 在**离线机器**上安装MTool

  双击mtool-setup.exe进行安装。用户自行选择安装目录，弹出界面显示**Completing the mtool Setup Wizard**信息表示安装成功，点击**Finish**即可。

## 3 配置

### 3.1 钱包配置

#### 3.1.1 基本概念

* 冷钱包：存储在离线机器上的钱包，不能暴露在互联网
* 观察钱包：包含冷钱包地址的钱包，无法做交易，只能查看数据
* 热钱包：暴露在互联网的钱包

#### 3.1.2 创建冷钱包

如果用户没有钱包，在**离线机器**上执行命令生成质押钱包和收益钱包；如果已经有钱包，可通过存储介质将钱包文件拷贝到离线MTool的解压包的**keystore**目录下，跳过本步骤。

- 创建质押钱包

```bash
mtool-client.bat create_wallet --name staking
```

- 创建收益钱包

```bash
mtool-client.bat create_wallet --name reward
```

#### 3.1.3 生成观察钱包

- 生成质押观察钱包

在**离线机器**上执行命令生成质押观察钱包：

```bash
mtool-client.bat create_observewallet --keystore %MTOOLDIR%\keystore\staking.json
```

 输入质押冷钱包密码并返回生成的观察钱包，如下：

```
please input keystore password: 
SUCCESS
wallet created at: keystore/staking_observed.json
```

- 将生成的观察钱包文件staking_observed.json拷贝到**在线机器**的**keystore**目录下。
- 生成收益观察钱包

在**离线机器**上执行命令生成收益观察钱包：

```bash
mtool-client.bat create_observewallet --keystore %MTOOLDIR%\keystore\reward.json
```

 输入收益冷钱包密码并返回生成的观察钱包，如下：

```
please input keystore password: 
SUCCESS
wallet created at: keystore/reward_observed.json
```

- 将生成的观察钱包文件reward_observed.json拷贝到**在线机器**的**keystore**目录下。

### 3.2 连接到验证节点

如果已经配置验证节点信息，忽略此步骤。在**`在线机器`**上执行以下步骤生成验证节点配置信息：

- step1. 浏览器复制链接 <https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/validator_conf.bat> 下载脚本。

- step2. 鼠标右键点击 validator_conf.bat， 选择以管理员身份运行，结果如下：

> 注意
> - 提示 `Please enter the platon node IP address:` 时，请输入 PlatON 节点服务器 ip 地址。
> - 提示 `Enter your name:` 时，请输入配置 nginx 时输入的用户名。
> - 提示 `Enter your password:` 时，请输入配置 nginx 时输入的密码。
> - 提示 `Enter your platon node name:` 时，请输入 PlatON 节点的名称。
> - 提示 `Enter your platon node description:` 时，请输入 PlatON 节点描述。
> - 提示 `validator conf success` 时，表示脚本执行成功，未执行成功时，请通过我们的官方客户联系方式反馈具体问题。
> - 提示 `请按任意键继续. . .` 时，请输入回车键关闭当前 cmd 窗口。


## 4 基本操作流程

### 4.1  生成交易数据

- 生成待签名文件

  以质押操作为例，在**在线机器**上执行质押操作命令， 注意此时的钱包选项命令为`--address`

```bash
mtool-client.bat staking --amount 1000000 --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

注：staking_observed.json为观察钱包，根据实际观察钱包进行修改。

返回生成对应的待签名文件：

```bash
operation finished
SUCCESS
File generated on transaction_details/transaction_detail_20191108114241.csv
```

注：其中transaction_details/transaction_detail_20191108114241.csv为待签名交易文件。

- 拷贝待签名文件到**离线机器**

  通过存储介质把**在线机器**下的待签名文件%MTOOLDIR%\transaction_details\transaction_detail_20191108114241.csv拷贝到**离线机器**。

### 4.2 离线签名交易

- 生成交易签名文件

在**离线机器**下执行签名命令对该质押交易签名：

```bash
mtool-client.bat offlinesign --filelocation %MTOOLDIR%\transaction_details\transaction_detail_20191108114241.csv
```

注：%MTOOLDIR%\transaction_details\transaction_detail_20191108114241.csv为上一步骤生成的待签名文件，修改为实际的待签名文件。

输入对应冷钱包密码并返回签完名的文件，文件内容如下：

```csv
 ┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬───────┬───────┐
│Type    │From    │To      │Account │Amount  │Fee     │Nonce   │Create │Chain  │
│        │        │        │Type    │        │        │        │Time   │Id     │
├────────┼────────┼────────┼────────┼────────┼────────┼────────┼───────┼───────┤
│STAKING │0xa1548d│0x100000│FREE_AMO│5000000.│0.043210│0       │2019-10│100    │
│        │d61010a7│00000000│UNT_TYPE│00000000│00000000│        │-11T13:│       │
│        │42cd66fb│00000000│        │00000000│0000    │        │54:06.8│       │
│        │86324ab3│00000000│        │00      │        │        │97     │       │
│        │e2935586│00000000│        │        │        │        │       │       │
│        │4a      │02      │        │        │        │        │       │       │
└────────┴────────┴────────┴────────┴────────┴────────┴────────┴───────┴───────┘
Need load 1 wallets for address: [0xa1548dd61010a742cd66fb86324ab3e29355864a]

operation finished
SUCCESS
File generated on transaction_signature/transaction_signature_20191108114625.csv
total: 1, to be signed: 1
success: 1, failure: 0
```

注：其中transaction_signature/transaction_signature_20191108114625.csv为已签名交易文件。

- 将交易签名文件拷贝到在线机器

通过存储介质把**离线机器**上的**`已签名文件`** transaction_signature_20191108114625.csv 拷贝到**在线机器**。

###  4.3 发送签名交易

- 在**在线机器**执行交易上链命令完成质押操作

```bash
mtool-client.bat send_signedtx --filelocation %MTOOLDIR%\transaction_signature\transaction_signature_20191108114625.csv --config %MTOOLDIR%\validator\validator_config.json
```

注：其中transaction_signature_20191108114625.csv为上一步骤生成的交易签名文件，修改为实际的签名文件。

输入`yes`返回交易结果：

```bash
Send Transaction? (yes|no)
yes
transaction 1 success
transaction hash: 0xf14f74386e6ef9027c48582d7faed3b50ab1ffdd047d6ba3afcf27791afb4e9b
SUCCESS
total: 1
success: 1, failure: 0
```

注：提示success并返回transaction hash表示签名交易发送成功，否则发送签名交易失败。

##  5  MTool操作详解

此章节主要描述在**在线机器**上生成csv格式的交易待签名文件的相关命令（[5.5 委托奖励生成报表操作](#55-委托奖励生成报表操作)除外），生成的csv文件会保存在%MTOOLDIR%\transaction_details目录下。完整的发送离线签名交易流程可参考[4 基本操作流程](#4-基本操作流程)。

### 5.1 发起质押操作

​		如果共识节点部署完成，并且已经同步区块成功，您就可以使用MTool进行质押操作。质押资金申请完成后，确保质押账户余额足够，根据用户情况替换{质押金额}，质押最低门槛为100万LAT。

- 执行命令

```bash
mtool-client.bat staking --amount 1000000 --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```
- 参数说明

> address: 质押观察钱包路径
>
> amount: 质押数，不少于1000000lat-质押门槛，小数点不超过8位（使用自由金额质押）
>
> restrictedamount: 不少于1000000lat-质押门槛，小数点不超过8位（使用锁仓余额质押）

### 5.2 修改验证人信息操作 

- 执行命令

```bash
mtool-client.bat update_validator --name VerifierName --url "www.platon.com" --identity IdentifyID --reward 0x33d253386582f38c66cb5819bfbdaad0910339b3 --introduction "Modify the verifier information operation" --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json --a
```

- 参数说明

> name：验证人名称,不超过30字节，支持字母、数字、空格、上下划线及#,必须字母开头
>
> url：官网路径,不超过70字节，数字字母组成
>
> identity：身份认证ID，不超过140字节
>
> reward：收益地址，42字符（字母数字）
>
> introduction：简介，验证人简要介绍说明，不超过280字节，建议英文
>
> a：执行命令时，同时更新版本验证人配置文件

### 5.3 解质押操作

- 执行命令

```bash
mtool-client.bat unstaking --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> 无

### 5.4 增加质押操作

- 执行命令

```bash
mtool-client.bat increasestaking --amount 5000000 --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> amount：用账户余额来增加质押量(LAT)，不少于10最小增加值，小数点不超过8位（使用自由金额增加质押）
>
> restrictedamount： 用账户锁仓余额来增加质押量，不少于10质押门槛，小数点不超过8位（使用锁仓余额增加质押）

### 5.5 委托奖励生成报表操作

执行此操作之前，在**在线机器**上需要启动MTool的服务，如果已经启动，可以跳过此步骤。

- 执行启动MTool服务命令

```bash
mtool-server.bat
```

此命令会生成**分配奖励明细报表**和**分配奖励汇总报表**，报表以csv的文件格式存储。

- 编辑委托激励计划配置文件

如果reward_config.json文件已经配置好，可以跳过此步骤。

```bash
copy %MTOOLDIR%\validator\reward_config.json.example %MTOOLDIR%\validator\reward_config.json
```

编辑reward_config.json文件，文件模板说明如下：

```json
{
  	//质押奖励配置
 	"staking":{ 
    	// 奖励方式： AVERAGE（委托人数平均分配），PERCENT（委托人委托总量权重分配）
 		"rewardMethod": "AVERAGE", 
    	// 节点佣金百分比
		"commissionRatio": 0.1  
 	},
    //出块奖励配置
 	"block":{ 
    	// 奖励方式： AVERAGE（委托人数平均分配），PERCENT（委托人委托总量权重分配）
 		"rewardMethod": "AVERAGE",
    	// 节点佣金百分比
		"commissionRatio": 0.2
 	},
  	//交易手续费奖励配置
 	"trade":{
    	// 奖励方式： AVERAGE（委托人数平均分配），PERCENT（委托人委托总量权重分配）
 		"rewardMethod": "AVERAGE",
    	// 节点佣金百分比
		"commissionRatio": 0.3
	},
  	// 转账交易手续费支付方，DELEGATOR（委托人出）VALIDATOR（验证人出）
	"feePayer": "DELEGATOR"
}
```

- 执行命令

```bash
mtool-client.bat gen_reward --start_block 10751 --end_block 107500 --rewardconfig %MTOOLDIR%\validator\reward_config.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> address：必须是验证人节点指定的收益钱包地址
>
> start_block：发放激励统计的起始块高，为1或者10750(结算周期)整数倍加1
>
> end_block：  发放激励统计的截止块高，为10750(结算周期)整数倍,end block必须大于start block
>
> rewardconfig：委托激励计划配置文件

- 生成分配奖励明细报表

```
Period：block1201-block1500
"Plan：block reward(20.00%,AVERAGE), fee reward(30.00%,AVERAGE), staking reward(10.00%,AVERAGE), Fee payer:(DELEGATOR)"
Validator: liyf-test
Reward address: 0xa1548dd61010a742cd66fb86324ab3e29355864a（Balance: 50000000000000000000000 LAT)
Total reward: 60000 LAT
Total block reward: 20000 LAT
Total fee reward: 30000 LAT
Total staking reward: 10000 LAT
Delegators: 1
Total distribution: 46000 LAT
Delegator,Block reward,Fee reward,Staking reward,Total reward
0xc1553f9deadecdbb304e4f557fca196f81ea02cd,20000,30000,10000,60000
```

注：此报表为单个结算周期的分配奖励，如果命令参数中**start_block**到**end_block**起止区块区间有多个结算周期，会生成多个分配奖励明细报表。生成的文件在：C:\tools\mtool\current\reward_data\VerifierName\Date\目录下。其中VerifierName为验证人的名称，Date为生成报表日期。

- 生成分配奖励汇总

```
Period：block1201-block1500
"Plan：block reward(20.00%,AVERAGE), fee reward(30.00%,AVERAGE), staking reward(10.00%,AVERAGE), Fee payer:(DELEGATOR)"
Validator: liyf-test
Reward address: 0xa1548dd61010a742cd66fb86324ab3e29355864a（Balance: 50000000000000000000000 LAT)
Total reward: 60000 LAT
Total block reward: 20000 LAT
Total fee reward: 30000 LAT
Total staking reward: 10000 LAT
Delegators: 1
Total distribution: 46000 LAT
Adjusted Total Distribution :46000 LAT （Actual distribution award has been adjusted）
Delegator,Block reward,Fee reward,Staking reward,Issued reward,Distribute rewards,Actual distribute reward
0xc1553f9deadecdbb304e4f557fca196f81ea02cd,20000,30000,10000,6000,54000,54000
```

注：此报表是命令参数中**start_block**到**end_block**起止区块涉及的所有分配明细的汇总；如果起止区块区间有多个结算周期，会将多个结算周期的分配奖励明细汇总到此报表中，生成的文件在：C:\tools\mtool\current\reward_data\VerifierName\目录下。其中VerifierName为验证人的名称。

### 5.6 委托激励发放操作

执行此操作之前，需要进行其他操作，具体可参考[5.5 委托奖励生成报表操作](#55-委托奖励生成报表操作)的**执行启动MTool服务命令**和**编辑委托激励计划配置文件**步骤。

委托激励发放会在奖励分配文件的基础上回填交易hash和交易状态，生成**奖励分配结果报表**。生成的文件在：C:\tools\mtool\current\reward_data\VerifierName\目录下。其中VerifierName为验证人的名称。

- 执行命令

```bash
mtool-client.bat reward_divide --address %MTOOLDIR%\keystore\reward_observed.json --config %MTOOLDIR%\validator\validator_config.json --reward_file %MTOOLDIR%\validator\reward_config.json
```

- 参数说明

> reward_file：委托激励发放的文件名

- 奖励分配结果报表

```
Period：block1201-block1500
"Plan：block reward(20.00%,AVERAGE), fee reward(30.00%,AVERAGE), staking reward(10.00%,AVERAGE), Fee payer:(DELEGATOR)"
Validator: liyf-test
Reward address: 0xa1548dd61010a742cd66fb86324ab3e29355864a（Balance: 50000000000000000000000 LAT)
Total reward: 60000 LAT
Total block reward: 20000 LAT
Total fee reward: 30000 LAT
Total staking reward: 10000 LAT
Delegators: 1
Total distribution: 46000 LAT
Adjusted Total Distribution : 46000 LAT（Actual distribution award has been adjusted）
Total txn fee: 0.000021 LAT
Delegator,Block reward,Fee reward,Staking reward,Issued reward,Distribute rewards,Actual distribute reward,Tx fee,Actual reward,Txn hash," status"
0xc1553f9deadecdbb304e4f557fca196f81ea02cd,20000,30000,10000,6000,54000,54000,0.000021,53999.999979,0x4e5e2f63c8c3d63424749fccfafa4f08e73ce7cdfb1f2fdad5da2147357a72d9,Success
```

注：其中0x4e5e2f63c8c3d63424749fccfafa4f08e73ce7cdfb1f2fdad5da2147357a72d9为交易hash，Success为交易状态，表示委托激励发放交易成功。

### 5.7 提交文本提案操作

- 执行命令

```bash
mtool-client.bat submit_textproposal --pid_id 100 --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> pid_id：GitHub ID

### 5.8 提交升级提案操作

- 执行命令

```bash
mtool-client.bat submit_versionproposal --newversion 1.0.0 --end_voting_rounds 10 --pid_id 100 --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> newversion：目标升级版本，x.x.x，数字加标点
>
> end_voting_rounds：投票共识轮数，投票共识轮数N，必须满足0 < N <= 2419（约为2周）
>
> pid_id：GitHub ID

### 5.9 提交取消提案操作

- 执行命令

```bash
mtool-client.bat submit_cancelproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --end_voting_rounds 12 --pid_id 100 --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> proposalid：需要被取消的提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> end_voting_rounds：投票共识轮数，投票共识轮数N，必须满足0 < N <=2419（约为2周）
>
> pid_id：GitHub ID

### 5.10 文本提案投票操作

- 执行命令

```bash
mtool-client.bat vote_textproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --opinion yes --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> proposalid：文本提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> opinion：投票选项，yes、no、abstain-三选一

### 5.11 升级提案投票操作

- 执行命令

```bash
mtool-client.bat vote_versionproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> proposalid：升级提案ID，即发起提案交易的hash，66字符，字母数字组成

### 5.12 取消提案投票操作

- 执行命令

```bash
mtool-client.bat vote_cancelproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --opinion yes --address %MTOOLDIR%\keystore\staking_observed.json –config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> proposalid：取消提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> opinion：投票选项，yes、no、abstain-三选一

### 5.13 版本声明操作

- 执行命令

```bash
mtool-client.bat declare_version --address %MTOOLDIR%\keystore\staking_observed.json --config %MTOOLDIR%\validator\validator_config.json
```

- 参数说明

> 无

### 5.14 查看帮助

- 执行命令

```bash
mtool-client.bat help
```

- 参数说明

> 无