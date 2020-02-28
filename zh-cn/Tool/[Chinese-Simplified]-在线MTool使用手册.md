## 安装在线MTool

如果已经安装在线MTool，可以忽略此步骤。

另外，本文档分别介绍Windows和Ubuntu环境下MTool的操作，用户可根据自己的资源进行选择。

### Windows下安装MTool

步骤如下：

- 下载MTool安装包

  在在线机器上，复制链接<https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/mtool/mtool-setup/0.8.0.0/mtool-setup.exe>或者 <http://47.91.153.183/mtool/mtool-setup/0.8.0.0/mtool-setup.exe> 到浏览器下载MTool安装包。

- 安装MTool

  双击mtool-setup.exe进行安装。默认安装目录为 C:\tools，建议不要更改此安装目录。弹出界面显示**Completing the mtool Setup Wizard**信息表示安装成功，点击**Finish**即可。

### Ubuntu下安装MTool

步骤如下：

**step1.** 下载mtool工具包

``` bash
wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/mtool/0.8.0.0/mtool-client.zip
```

或者

``` bash
wget http://47.91.153.183/mtool/0.8.0.0/mtool-client.zip
```

**step2.** 解压mtool工具包

``` bash
unzip mtool-client.zip && cd mtool-client
```

**step3.** 下载脚本

>[!NOTE|style:flat|label:注意]
>
>脚本下载到<font color=red>mtool-client</font> 目录下，否则脚本无法找到新版本mtool的路径。

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

> [!NOTE|style:flat|label:注意]
>
> - 提示 <font color=red>Install mtool succeed.</font> 时，表示 MTool 安装成功，未安装成功时，请通过我们的官方客服联系方式反馈具体问题。
> - 安装完成之后，需要<font color=red>重启终端</font>，让新添加的环境变量生效。

## 配置在线MTool

Windows和Ubuntu下MTool目录使用环境变量有所区别：

- MTool目录

  - Windows：`%MTOOLDIR%`

  - Ubuntu：`$MTOOLDIR`

>  说明：
>
>   - MTool目录用变量`$MTOOLDIR`代替；
>
>  **`用户根据自己安装的系统进行选择。`**

### 创建钱包

PlatON中，参与验证节点进行出块要创建两个钱包。如果已经有钱包，可通过将钱包文件拷贝到`$MTOOLDIR/keystore`目录下，跳过本步骤。

- 质押钱包
  质押钱包用于质押 token，质押成功后才能成为备选节点候选人。
  运行以下命令创建质押钱包：

  ``` shell
  mtool-client account new staking
  ```

  输入一次密码，再输入一次确认密码，即可创建钱包文件，创建成功后会在目录`$MTOOLDIR/keystore`下生成质押钱包文件`staking.json`。

- 收益钱包
  用于收取区块奖励和Staking奖励，Staking奖励统一发放给验证节点，由验证节点自行分配。
  运行以下命令创建收益钱包：

  ``` shell
  mtool-client account new reward
  ```

  输入一次密码，再输入一次确认密码，即可创建钱包文件，创建成功后会在目录`$MTOOLDIR/keystore`下生成质押钱包文件`reward.json`。

### 配置验证节点信息

根据用户在Windows或Ubuntu上安装的MTool，选择对应系统上的验证节点信息配置。

#### Windows下配置验证节点信息

操作步骤如下：

**step1.**  windows键 + x ，点击 Windows PowerShell(管理员)(A)，弹出窗口选择是，调出管理员：powershell 窗口，复制以下2条命令执行。

```bash
$env:chocolateyUseWindowsCompression = 'true'
Set-ExecutionPolicy -ExecutionPolicy Bypass
```

提示：

```plain
执行策略更改
执行策略可帮助你防止执行不信任的脚本。更改执行策略可能会产生安全风险，如 https:/go.microsoft.com/fwlink/?LinkID=135170 中的 about_Execution_Policies 帮助主题所述。是否要更改执行策略?
[Y] 是(Y)  [A] 全是(A)  [N] 否(N)  [L] 全否(L)  [S] 暂停(S)  [?] 帮助 (默认值为“N”):
```

请输入：y，并按回车键结束。

**step2.** 浏览器复制链接 <https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/validator_conf.bat> 或者 <http://47.91.153.183/opensource/scripts/validator_conf.bat> 下载脚本。

**step3.** 鼠标右键点击 validator_conf.bat， 选择以管理员身份运行:

> [!NOTE|style:flat|label:注意]
>
> - 提示 <font color=red> Please enter the platon node IP address: </font>时，请输入 PlatON 节点服务器 ip 地址。
> - 提示 <font color=red> Please enter the platon chain id: </font>时，请输入链ID，根据节点所连网络是主网还是测试网选择输入(测试网:101)。
> - 提示 <font color=red> Please enter the delegatedRewardRate(0~10000):</font>时，请输入比例分红，范围从0到10000。
> - 提示 <font color=red> Enter your name: </font> 时，请输入配置 PlatON节点 nginx 时输入的用户名。
> - 提示 <font color=red> Enter your password: </font>时，请输入配置 PlatON节点 nginx 时输入的密码。
> - 提示<font color=red> Enter your platon node name:</font>时，请输入 PlatON 节点的名称。
> - 提示<font color=red> Enter your platon node description:</font>时，请输入 PlatON 节点描述。
> - 提示<font color=red> validator conf success</font>时，表示脚本执行成功，未执行成功时，请通过我们的官方客服联系方式反馈具体问题。
> - 提示<font color=red> 请按任意键继续. . .</font> 时，请输入回车键关闭当前 cmd 窗口。

#### Ubuntu下配置验证节点信息

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

> [!NOTE|style:flat|label:注意]
>
> - 提示 <font color=red> Please enter the platon node IP address: </font>时，请输入 PlatON 节点服务器 ip 地址。
> - 提示 <font color=red> Please enter the platon chain id: </font>时，请输入链ID，根据所连网络是主网还是测试网选择输入(测试网:101)。
> - 提示 <font color=red> Please enter the delegatedRewardRate(0~10000):</font>时，请输入比例分红，范围从0到10000。
> - 提示 <font color=red> Enter your name: </font> 时，请输入配置 PlatON节点 nginx 时输入的用户名。
> - 提示 <font color=red> Enter your password: </font>时，请输入配置 PlatON节点 nginx 时输入的密码。
> - 提示<font color=red> Enter your platon node name:</font>时，请输入 PlatON 节点的名称。
> - 提示<font color=red> Enter your platon node description:</font>时，请输入 PlatON 节点描述。
> - 提示<font color=red> validator conf success</font>，并最后打印出的validator_config.json内容正常时，表示脚本执行成功，未执行成功时，请通过我们的官方客服联系方式反馈具体问题。

#### 验证节点信息配置文件说明
完成配置验证节点信息后，会在MTool的安装目录的validator子目录下，生成验证节点信息文件validator_config.json，文件内容如下：
```json
{
  "chainId": "101",
  "delegatedRewardRate": "5000",
  "nodePublicKey": "79ca603ef75d5954ec270802fa4e7b9bf045842bb7f3e95b849173f61d8a7cfef82b8687abef67f29645e068ff371da514f32b009b05f48062daa84f0b58ab6d",
  "blsPubKey": "a2e1c2e60eb8bb2af05fff4d07c8fce7c408fbe944be1a58194d9e9c9078cb7bb55b63311c8af107453ac182eef22a04cb9ff28cc3367f1e8459f8dcbe9f5c965a6f377f9ff9bb39a78e4e04fd27876137bb0a9aa4066d0277464f018e989e94",
  "benefitAddress": "0x32bec384344c2dc1ea794a4e149c1b74dd8467ef",
  "nodeAddress": "https://test:test@domain3",
  "nodePort": "16789",
  "nodeRpcPort": "443",
  "nodeName": "water-node",
  "details": "this is water-node",
  "externalId": "MyKeyBaseId",
  "webSite": "http://www.mycompany.com",
  "certificate": "C:/tools/mtool/current/ca.crt"
}
```

> [!NOTE|style:flat|label:参数说明] 
>
> - chainId: 贝莱世界的链为101。
> - delegatedRewardRate: 用来设置给委托人分红的比例。
> - nodePublicKey: 节点ID，可通过节点数据目录data下的nodeid文件查看。
> - blsPubKey: BLS公钥，可通过节点数据目录data下的blspub文件查看。
> - benefitAddress: 收益钱包地址。
> - nodeAddress: 节点地址，分使用Nginx和不使用Nginx两种情况:
>   - 如果使用Nginx，需要用**https**协议，格式为：`https://test:test@domain3`。
>   - 如果不使用Nginx，需要用**http**协议，如果MTool和节点在同一台机器或同一个局域网内，可以使用内网IP，否则使用公网IP，格式为：`http://18.238.183.12`。
> - nodePort: 节点P2P端口，默认为16789。
> - nodeRpcPort: 分使用Nginx和不使用Nginx两种情况:
>   - 如果使用了Nginx，端口默认为443。
>   - 如果不使用Nginx，端口默认为6789。
> - nodeName: 节点名称。
> - details: 节点描述信息。
> - externalId: 对应为浏览器显示的头像，可在[keybase.io](https://keybase.io)官网进行注册，对应的值为：注册账户，生成16位的公钥 。
> - webSite: 公司网址。
> - certificate: ca证书地址，如果不使用Nginx反向代理，可删除此参数。

##  在线MTool操作详解

### 普通转账操作

- 执行命令

```bash
mtool-client tx transfer --keystore $MTOOLDIR/keystore/staking.json --amount "1" --recipient $to_address --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

>keystore：发送转账交易的钱包路径
>
>amount：转账金额，单位：LAT
>
>recipient：接收地址

### 查看钱包列表

- 执行命令

```bash
mtool-client account list
```

### 根据钱包名称查询余额

- 执行命令

```bash
mtool-client account balance $keystorename --config $MTOOLDIR/validator/validator_config.json
```

- 变量说明

>$keystorename：钱包文件名称

### 根据地址查询余额

- 执行命令

```bash
mtool-client account balance -a $address --config $MTOOLDIR/validator/validator_config.json
```

- 参数

> a：钱包地址

### 发起质押操作

如果共识节点部署完成，并且已经同步区块成功，您就可以使用MTool进行质押操作。质押资金申请完成后，确保质押账户余额足够，根据用户情况替换质押金额，质押最低门槛为100万LAT。

注意：请保持质押账户里面有足够LAT，以备后续发起节点管理的交易有足够的交易手续费，比如升级提案的投票，解质押等交易。

- 执行命令

```bash
mtool-client staking --amount 1000000 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```
提示：**please input keystore password:** 输入质押钱包的密码，然后回车，如果显示如下信息则代表质押成功：

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

### 修改验证人信息操作

- 执行命令

```bash
mtool-client update_validator --name VerifierName --url "www.platon.com" --identity IdentifyID --delegated-reward-rate 100 --reward 0x33d253386582f38c66cb5819bfbdaad0910339b3 --introduction "Modify the verifier information operation" --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> name：验证人名称,不超过30字节，支持字母、数字、空格、上下划线及#,必须字母开头
>
> url：官网路径,不超过70字节，数字字母组成
>
> identity：身份认证ID，不超过140字节
>
> delegated-reward-rate：委托奖励比例，单位：万分比，整数，范围0~10000
>
> reward：收益地址，42字符（字母数字）
>
> introduction：简介，验证人简要介绍说明，不超过280字节，建议英文
>
> a：执行命令时，用配置文件里面的值作参数去修改验证人信息

### 解质押操作

- 执行命令

```bash
mtool-client unstaking --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> 无

### 增加质押操作

- 执行命令

```bash
mtool-client increasestaking --amount 5000000 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> amount：用账户余额来增加质押量(LAT)，不少于10最小增加值，小数点不超过8位
>
> restrictedamount： 用账户锁仓余额来增加质押量，不少于10质押门槛，小数点不超过8位（使用锁仓余额质押）

### 提交文本提案操作

- 执行命令

```bash
mtool-client submit_textproposal --pid_id 100 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> pid_id：GitHub ID

### 提交升级提案操作

- 执行命令

```bash
mtool-client submit_versionproposal --newversion 0.8.0 --end_voting_rounds 345 --pid_id 100 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> newversion：目标升级版本，x.x.x，数字加标点
>
> end_voting_rounds：投票共识轮数，投票共识轮数N，必须满足0 < N <= 4838（约为2周）
>
> pid_id：GitHub ID

### 提交取消提案操作

- 执行命令

```bash
mtool-client submit_cancelproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --end_voting_rounds 12 --pid_id 100 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：需要被取消的提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> end_voting_rounds：投票共识轮数，投票共识轮数N，必须满足0 < N <= 4838（约为2周）
>
> pid_id：GitHub ID

### 文本提案投票操作

- 执行命令

```bash
mtool-client vote_textproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --opinion yes --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：文本提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> opinion：投票选项，yes、no、abstain-三选一

### 升级提案投票操作

- 执行命令

```bash
mtool-client vote_versionproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：升级提案ID，即发起提案交易的hash，66字符，字母数字组成

### 取消提案投票操作

- 执行命令

```bash
mtool-client vote_cancelproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --opinion yes --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：取消提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> opinion：投票选项，yes、no、abstain-三选一

### 提交参数提案操作

- 执行命令

```bash
mtool-client submit_paramproposal --pid_id 200 --module $module --paramname $paramname --paramvalue $paramvalue --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> module：治理模块参数
>
> paramname：治理模块参数名，注意字母大小写
>
> paramvalue：治理模块参数值
>
> pid_id：GitHub ID

###  参数提案投票操作

- 执行命令

``` bash
mtool-client  vote_paramproposal --proposalid 0x444c3df404bc1ce4d869166623514b370046cd37cdfa6e932971bc2f98afd1a6 --opinion yes --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> proposalid：取消提案ID，即发起提案交易的hash，66字符，字母数字组成
>
> opinion：投票选项，yes、no、abstain-三选一

### 版本声明操作

- 执行命令

```bash
mtool-client declare_version --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

- 参数说明

> 无

### 查看帮助

- 执行命令

```bash
mtool-client -h
```

- 参数说明

> 无
