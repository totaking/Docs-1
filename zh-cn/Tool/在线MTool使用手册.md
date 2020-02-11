# 在线MTool使用手册

## 1 简介

为了便于节点进行质押，委托以及治理等相关的操作，PlatON提供了MTool来辅助用户。

- MTool可支持Ubuntu 18.04和Windows 10，本文档分别描述Windows和Ubuntu环境下的安装和使用。
- MTool需要通过RPC接口连接到验证节点。
- 为保证节点安全，建议节点RPC端口通过Nginx代理访问，Nginx使用Https和用户认证加强安全防护。
- MTool对质押等交易提供两种签名方式：在线签名和离线签名。此文档描述在线签名操作，离线签名请参考[离线MTool使用手册.md](./离线MTool使用手册.md)。

## 2 安装在线MTool

如果已经安装在线MTool，可以忽略此步骤。

另外，本文档分别介绍Windows和Ubuntu环境下的MTool操作，用户可根据自己的资源进行选择；如果下载脚本失败，请设置DNS 服务器为8.8.8.8。

### 2.1  Windows下安装MTool

步骤如下：

**step1.**  左下角 windows 田字标识，右键，单击**windows powershell（管理员）**，在powershell 界面输入以下命令。

```bash
$env:chocolateyUseWindowsCompression = 'true'
Set-ExecutionPolicy -ExecutionPolicy Bypass
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
```

提示：

```plain
执行策略更改
执行策略可帮助你防止执行不信任的脚本。更改执行策略可能会产生安全风险，如 https:/go.microsoft.com/fwlink/?LinkID=135170 中的 about_Execution_Policies 帮助主题所述。是否要更改执行策略?
[Y] 是(Y)  [A] 全是(A)  [N] 否(N)  [L] 全否(L)  [S] 暂停(S)  [?] 帮助 (默认值为“N”):
```

请输入：y，并按回车键结束。

**step2. ** 浏览器复制链接 <https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/mtool_install.bat> 或者 <http://47.91.153.183/opensource/scripts/mtool_install.bat> 下载脚本。

**step3.** 鼠标右键点击 mtool_install.bat， 选择以管理员身份运行

> 注意
>
> - 提示 `Enter password:` 时，请输入回车键。
> - 提示 `install and start mtool success` 时，表示 MTool 安装成功，未安装成功时，请通过我们的官方客户联系方式反馈具体问题。
> - 提示 `请按任意键继续. . .` 时，请输入回车键关闭当前 cmd 窗口。

### 2.2  Ubuntu下安装MTool

步骤如下：

**step1.** 下载mtool工具包：(实际mtool版本的链接地址需从公告获取)

``` bash
wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/mtool/X.X.X.X/mtool-all.zip
```

或者

``` bash
wget http://47.91.153.183/mtool/X.X.X.X/mtool-all.zip
```

> 其中X.X.X.X为mtool的版本号，实际版本号需从公告获取。

**step2.** 解压mtool工具包

``` bash
unzip mtool-all.zip && cd mtool-all
```

**step3.** 下载脚本

**注意：脚本下载到mtool_all目录下，否则脚本无法找到新版本mtool的路径；**

``` bash
wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/mtool_install.sh
```

或者

``` bash
wget http://47.91.153.183/opensource/scripts/mtool_install.sh
```

**step4.** 执行命令

```
chmod +x mtool_install.sh && ./mtool_install.sh
```

> 注意：
>
> - 提示 `Install mtool succeed.` 时，表示 MTool 安装成功，未安装成功时，请通过我们的官方客户联系方式反馈具体问题。
> - 安装完成之后，需要**`重启终端`**，让新添加的环境变量生效。

相关配置请参考文档[PlatON节点安装部署手册.md](./PlatON节点安装部署手册.md)。

## 3 配置在线MTool

Windows和Ubuntu下MTool的命令及目录有所区别：

- MTool命令

  - Windows：mtool-client.bat
  - Ubuntu：mtool-client

- MTool目录

  - Windows：%MTOOLDIR%

  - Ubuntu：$MTOOLDIR

>  说明：
>
>   - MTool命令用变量$mtool-client代替；
>   - MTool目录用变量$MTOOLDIR代替；
>
>  **`用户根据自己安装的系统进行选择。`**

### 3.1 创建钱包

PlatON中，参与验证节点进行出块要创建两个钱包。如果已经有钱包，可通过将钱包文件拷贝到`$MTOOLDIR/keystore`目录下，跳过本步骤。

- 质押钱包
  质押钱包用于质押 token，质押成功后才能成为备选节点候选人。
  运行以下命令创建质押钱包：

  ``` shell
  $mtool-client create_wallet --name staking
  ```

  输入一次密码，再输入一次确认密码，即可创建钱包文件，创建成功后会在目录`$MTOOLDIR/keystore`下生成质押钱包文件`staking.json`。

- 收益钱包
  用于收取区块奖励和Staking奖励，Staking奖励统一发放给验证节点，由验证节点自行分配。
  运行以下命令创建收益钱包：

  ``` shell
  $mtool-client create_wallet --name reward
  ```

  输入一次密码，再输入一次确认密码，即可创建钱包文件，创建成功后会在目录`$MTOOLDIR/keystore`下生成质押钱包文件`reward.json`。

### 3.2 配置验证节点信息

根据用户在Windows或Ubuntu上安装的MTool，选择对应系统上的验证节点信息配置：

#### 3.2.1  Windows下配置验证节点信息

操作步骤如下：

**step1.** 浏览器复制链接 <https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/validator_conf.bat> 或者 <http://47.91.153.183/opensource/scripts/validator_conf.bat> 下载脚本

**step2.** 鼠标右键点击 validator_conf.bat， 选择以管理员身份运行

> 注意
>
> - 提示 `Please enter the platon node IP address:` 时，请输入 PlatON 节点服务器 ip 地址。
> - 提示 `Please enter the platon chain id:` 时，请输入链ID。
> - 提示 `Enter your name:` 时，请输入配置 PlatON节点 nginx 时输入的用户名。
> - 提示 `Enter your password:` 时，请输入配置 PlatON节点 nginx 时输入的密码。
> - 提示 `Enter your platon node name:` 时，请输入 PlatON 节点的名称。
> - 提示 `Enter your platon node description:` 时，请输入 PlatON 节点描述。
> - 提示 `validator conf success` 时，表示脚本执行成功，未执行成功时，请通过我们的官方客户联系方式反馈具体问题。
> - 提示 `请按任意键继续. . .` 时，请输入回车键关闭当前 cmd 窗口。

#### 3.2.2  Ubuntu下配置验证节点信息

操作步骤如下：

**step1.** 下载脚本：

``` bash
wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/validator_conf.sh
```

或者

``` bash
wget http://47.91.153.183/opensource/scripts/validator_conf.sh
```

**step2.** 执行命令：

```bash
chmod +x validator_conf.sh && ./validator_conf.sh
```

> 注意
>
> - 提示 `Please enter the platon node IP address:` 时，请输入 PlatON 节点服务器 ip 地址。
> - 提示 `Please enter the platon chain id:` 时，请输入链ID。
> - 提示 `Enter your name:` 时，请输入配置 nginx 时输入的用户名。
> - 提示 `Enter your password:` 时，请输入配置 nginx 时输入的密码。
> - 提示 `Enter your platon node name:` 时，请输入 PlatON 节点的名称。
> - 提示 `Enter your platon node description:` 时，请输入 PlatON 节点描述。
> - 提示 `validator conf success` 并最后打印出的validator_config.json内容正常时，表示脚本执行成功，未执行成功时，请通过我们的官方客户联系方式反馈具体问题。

##  4  在线MTool操作详解

Windows和Ubuntu下MTool的命令及目录有所区别：

- MTool命令

  - Windows：mtool-client.bat
  - Ubuntu：mtool-client

- MTool目录

  - Windows：%MTOOLDIR%

  - Ubuntu：$MTOOLDIR

>  说明：
>
>   - MTool命令用变量$mtool-client代替；
>   - MTool目录用变量$MTOOLDIR代替；
>
>  **`用户根据自己安装的系统进行选择。`**

### 4.1 发起质押操作

​		如果共识节点部署完成，并且已经同步区块成功，您就可以使用MTool进行质押操作。质押资金申请完成后，确保质押账户余额足够，根据用户情况替换{质押金额}，质押最低门槛为100万LAT。

- 执行命令

```bash
$mtool-client staking --amount 1000000 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```
提示：”please input keystore password:“ 输入质押钱包的密码，然后回车，如果显示如下信息则代表质押成功：

```bash
operation finished
transaction hash:
0x89b964d27d0caf1d8bf268f721eb123c4af57aed36187bea90b262f4769eeb9b
SUCCESS
```

- 参数说明

> amount: 质押数，不少于1000000lat-质押门槛，小数点不超过8位
>
> restrictedamount: 不少于1000000lat-质押门槛，小数点不超过8位（使用锁仓余额质押）

### 4.2 修改验证人信息操作

- 执行命令

```bash
$mtool-client update_validator --name VerifierName --url "www.platon.com" --identity IdentifyID --reward 0x33d253386582f38c66cb5819bfbdaad0910339b3 --introduction "Modify the verifier information operation" --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json --a
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

### 4.3 解质押操作

- 执行命令

```bash
$mtool-client unstaking --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> 无

### 4.4 增加质押操作

- 执行命令

```bash
$mtool-client increasestaking --amount 5000000 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> amount：用账户余额来增加质押量(LAT)，不少于10最小增加值，小数点不超过8位
>
> restrictedamount： 用账户锁仓余额来增加质押量，不少于10质押门槛，小数点不超过8位（使用锁仓余额质押）

### 4.5 委托奖励生成报表操作

执行此操作之前，需要启动MTool的服务，如果已经启动，可以跳过此步骤。

- 执行启动MTool服务命令

```bash
$mtool-server
```

> 其中$mtool-server
>
> - Windows下执行为：mtool-server.bat
> - Ubuntu下执行为：mtool-server

此命令会生成**分配奖励明细报表**和**分配奖励汇总报表**，报表以csv的文件格式存储。

- 编辑委托激励计划配置文件

如果reward_config.json文件已经配置好，可以跳过此步骤。

```bash
copy $MTOOLDIR/validator/reward_config.json.example $MTOOLDIR/validator/reward_config.json
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

- 编辑验证节点配置文件

如果节点启动时，启动参数添加了**--db.nogc**选项，说明节点为归档节点，则可以忽略此步骤；否则为非归档节点，只保存最近100个区块的交易信息，获取奖励明细需要连接到归档节点，目前对外开放的归档节点有： **52.233.38.169:6789**和**13.235.119.163:6789**。需要修改验证节点配置文件validator_config.json中的**nodeAddress**参数，其他参数不变：

```json
{
    "nodeRpcPort": "6789", 
    "nodeAddress": "http://52.233.38.169"
}
```

- 执行命令

```bash
$mtool-client gen_reward --start_block 10751 --end_block 107500 --rewardconfig $MTOOLDIR/validator/reward_config.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

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

注：此报表为单个结算周期的分配奖励，如果命令参数中**start_block**到**end_block**起止区块区间有多个结算周期，会生成多个分配奖励明细报表。生成的文件在：$MTOOLDIR/reward_data/VerifierName/Date/目录下。其中VerifierName为验证人的名称，Date为生成报表日期。

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

注：此报表是命令参数中**start_block**到**end_block**起止区块涉及的所有分配明细的汇总；如果起止区块区间有多个结算周期，会将多个结算周期的分配奖励明细汇总到此报表中。生成的文件在：$MTOOLDIR/reward_data/VerifierName/目录下。其中VerifierName为验证人的名称。

### 4.6 委托激励发放操作

执行此操作之前，需要进行其他操作，具体可参考[4.5 委托奖励生成报表操作](#45-委托奖励生成报表操作)的**执行启动MTool服务命令**和**编辑委托激励计划配置文件**步骤。

委托激励发放会在奖励分配文件的基础上回填交易hash和交易状态，生成**奖励分配结果报表**。报表以csv的文件格式存储，生成的文件在：$MTOOLDIR/reward_data/VerifierName/目录下。其中VerifierName为验证人的名称。

- 编辑验证节点配置文件

如果节点启动时，启动参数添加了**--db.nogc**选项，说明节点为归档节点，则可以忽略此步骤；否则为非归档节点，只保存最近100个区块的交易信息，获取奖励明细需要连接到归档节点，目前对外开放的归档节点有： **52.233.38.169:6789**和**13.235.119.163:6789**。需要修改验证节点配置文件validator_config.json中的**nodeAddress**参数，其他参数不变：

```json
{
    "nodeRpcPort": "6789", 
    "nodeAddress": "http://52.233.38.169"
}
```

- 执行命令

```bash
$mtool-client reward_divide --keystore $MTOOLDIR/keystore/reward.json --config $MTOOLDIR/validator/validator_config.json --reward_file $MTOOLDIR/validator/reward_config.json 
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

### 4.7 提交文本提案操作

- 执行命令

```bash
$mtool-client submit_textproposal --pid_id 100 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> pid_id：GitHub ID

### 4.8 提交升级提案操作

- 执行命令

```bash
$mtool-client submit_versionproposal --newversion 0.8.0 --end_voting_rounds 345 --pid_id 100 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> newversion：目标升级版本，x.x.x，数字加标点
>
> end_voting_rounds：投票共识轮数，投票共识轮数N，必须满足0 < N <= 2419（约为2周）
>
> pid_id：GitHub ID

### 4.9 提交取消提案操作

- 执行命令

```bash
$mtool-client submit_cancelproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --end_voting_rounds 12 --pid_id 100 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：需要被取消的提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> end_voting_rounds：投票共识轮数，投票共识轮数N，必须满足0 < N <=2419（约为2周）
>
> pid_id：GitHub ID

### 4.10 文本提案投票操作

- 执行命令

```bash
$mtool-client vote_textproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --opinion yes --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：文本提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> opinion：投票选项，yes、no、abstain-三选一

### 4.11 升级提案投票操作

- 执行命令

```bash
$mtool-client vote_versionproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：升级提案ID，即发起提案交易的hash，66字符，字母数字组成

### 4.12 取消提案投票操作

- 执行命令

```bash
$mtool-client vote_cancelproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --opinion yes --keystore $MTOOLDIR/keystore/staking.json –config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：取消提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> opinion：投票选项，yes、no、abstain-三选一

### 4.13 版本声明操作

- 执行命令

```bash
$mtool-client declare_version --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> 无

### 4.14 查看帮助

- 执行命令

```bash
$mtool-client help
```

- 参数说明

> 无