# PlatON节点安装部署手册

## 1. 节点安装部署

### 1.1 环境要求

- 硬件

| 需求项     | 建议配置       |
| ------    | ----------    |
| Cores     | \>=4          |
| CPU       | \>=2.4 GHz    |
| RAM       | \>=8GB        |
| DISK      | \>=500G       |

> 注意：
>
> - 表中DISK容量为基本配置，随着网络的长期运行，DISK实际需求量会逐步提高，建议采用可在线动态扩容的SSD磁盘

- 软件

PlatON节点目前完整测试过 Ubunt18.04 版本的操作系统，建议使用Ubunt18.04。本文档中的所有节点相关操作都以Ubunt18.0.4为基础。

- 网络

| 端口      | 服务名称       |
| ------    | ----------    |
| 443       | https         |
| 16789     | p2p           |

PlatON 的网络带宽要求大于等于20Mbps，同时云主机需要开放以上服务端口的外部访问权限。

- MTool 环境

MTool为节点管理工具，为方便操作，建议使用 Windows 10 操作系统。本文档中的所有MTool相关操作都以Windows为基础。

### 1.2 安装 PlatON

PlatON 的数据和日志会生成在运行脚本的非 root 用户的根目录下面，请确保用户根目录有足够的空间存储这些文件。

**step1.** 以非 root 账户下载 platon_setup.sh 脚本

``` bash
wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/platon_setup.sh
```

或者

``` bash
wget http://47.91.153.183/opensource/scripts/platon_setup.sh
```

**step2.** 执行脚本

``` bash
chmod +x platon_setup.sh && ./platon_setup.sh 0.7.4
```

> 注意
>
> - 安装过程中会卸载旧版本的 platon，停止正在运行的 platon 进程，同时删除旧版本的数据。
> - 0.7.4为指定安装的版本号，根据实际的版本号进行修改。
> - 提示 `[sudo] password for` 时，请输入当前账户密码。
> - 提示 `Press [ENTER] to continue or Ctrl-c to cancel adding it` 时，请输入回车键。
> - 提示 `install platon and attach platon and get block number succeed` 时, 表示安装 PlatON 成功，未安装成功时，请通过我们的官方客户联系方式反馈具体问题。

### 1.3 配置 nginx

安全考虑，不建议节点 rpc 端口对外直接开放。可以考虑使用 Nginx 进行反向代理，并通过用户鉴权和 HTTPS 加强 Nginx 端口的安全性。Nginx 配置步骤如下：

**step1.** 以非 root 账户下载 nginx_conf.sh

``` bash
wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/nginx_conf.sh
```

或者

``` bash
http://47.91.153.183/opensource/scripts/nginx_conf.sh
```

**step2.** 执行脚本

``` bash
chmod +x nginx_conf.sh && ./nginx_conf.sh
```

> 注意
>
> - 提示 `[sudo] password for` 时，输入当前账户密码。
> - 提示 `Enter your name:` 时，输入用户名，提示 `Enter your password:` 时，输入密码。务必牢记用户名和密码，后续MTool 配置验证节点信息时需要填写。
> - 提示 `ngnix conf succeed` 时，表示配置 nginx 成功，未配置成功时，请通过我们的客户联系方式反馈具体问题。

## 2. 接入测试网 

### 2.1 验证节点概述

PlatON 是实行民主治理的区块链项目，验证节点由所有 Energon 持有者共同推选，以维护和发展 PlatON 网络。得票数最多的101名节点将成为备选节点，从中用 VRF 随机选出25个验证节点，参与管理整个 PlatON 网络。

- 质押100万 Energon 成为备选节点候选人，并可接受委托
- 每个 Staking 周期期初，总票数（包括节点自质押和其他人的委托）排名前 101 名的节点，成为当前Staking周期的备选节点
- 每个共识周期（250个区块一轮）的第230个区块，从当前 Staking 周期的101名备选节点中, 按总得票数权重随机选出 25 名验证节点来生产区块

### 2.2  安装前准备

360 安全卫士，腾讯电脑管家等杀毒软件会将工具文件误判为病毒文件进而删除，操作前建议关闭这些杀毒软件。

windows键 + x ，点击 Windows PowerShell(管理员)(A)，弹出窗口选择是，调出管理员：powershell 窗口，执行 `mtool-client.bat --version` 命令。

执行结果显示`无法将“mtool-client.bat”项识别为 cmdlet、函数、脚本文件或可运行程序的名称。请检查名称的拼写，如果包括路径，请确保路径正确，然后再试一次。`，表示没有安装旧版本不需要执行下面操作。

执行结果显示版本号，时间戳等信息表示安装了旧版本，此时需要备份重要信息，然后再手工卸载旧版本，操作步骤：

**step1.** 备份目录 `C:\tools\mtool\current\keystore` 下的所有文件到 D 盘或其他非 `C:\tools` 的目录下。安装完新版本之后需要将备份文件拷贝回 `C:\tools\mtool\current\keystore` 目录下。

**step2.** 备份目录 `C:\tools\mtool\current\validator` 下的所有文件到 D 盘或其他非 `C:\tools` 的目录下。安装完新版本之后需要将备份文件拷贝回 `C:\tools\mtool\current\validator` 目录下。

**step3.**  在前面调出的 powershell 窗口中执行以下命令卸载 mtool 相关的旧版本工具软件。

执行 `choco list --local-only` 命令， 获取包含 mtool 关键字的相关工具，如：`platon_mtool_other 0.7.3`, `platon_mtool_all 0.7.3`, `mtool 0.7.3` 等。

执行 `choco uninstall platon_mtool_other 0.7.3`， `choco uninstall platon_mtool_all 0.7.3` 等命令，逐个卸载旧的相关工具。

**step4.** 删除 `C:\tools\mtool`, `C:\tools\platon_mtool_other` 等 `C:\tools` 下包含 mtool 关键字的目录。

### 2.3 安装 MTool

MTool 是一个命令行版本的节点管理工具，可以方便地发起质押等交易，MTool对质押等交易提供两种签名方式：在线签名和离线签名。

- 在线签名相对比较方便，本文档主要介绍在线签名操作过程
- 对安全性要求比较高的用户可以参考[离线MTool使用手册.md](./离线MTool使用手册.md)使用离线签名。

另外，本文档主要介绍 Windows 环境下的MTool操作，如果下载脚本失败，请设置DNS 服务器为8.8.8.8。

Windows环境下Mtool的安装步骤如下：

**step1.**  在[安装前准备](#22-安装前准备)步骤调出的管理员：powershell 窗口中，复制以下2条命令执行。

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

**step2.** 浏览器复制链接 <https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/mtool_install.bat> 或者 <http://47.91.153.183/opensource/scripts/mtool_install.bat> 下载脚本

**step3.** 鼠标右键点击 mtool_install.bat， 选择以管理员身份运行

> 注意
>
> - 首次安装 mysql 密码为空，提示 `Enter password:` 时，请直接按回车键。如果已经安装过 mysql，提示 `Enter password:` 时，请输入自己设置的mysql的root账户密码（如果之前是用mtool_install.bat脚本安装的mysql，此时密码为 123456），然后按回车键。
> - 提示 `install and start mtool success` 时，表示 MTool 安装成功，未安装成功时，请通过我们的官方客户联系方式反馈具体问题。
> - 提示 `请按任意键继续. . .` 时，请输入回车键关闭当前 cmd 窗口。

### 2.4 创建钱包

PlatON中，参与验证节点进行出块要创建两个钱包。

- 质押钱包
  质押钱包用于质押 token，质押成功后才能成为备选节点候选人。
  Windows+R，输入 cmd 进入终端，运行以下命令创建质押钱包：
  
  ``` shell
  mtool-client.bat create_wallet --name staking
  ```

  输入一次密码，再输入一次确认密码，即可创建钱包文件，创建成功后会在目录`C:\tools\mtool\current\keystore`下生成质押钱包文件`staking.json`。

- 收益钱包
  用于收取区块奖励和Staking奖励，Staking奖励统一发放给验证节点，由验证节点自行分配。
  Windows+R，输入 cmd 进入终端，运行以下命令创建收益钱包：
  
  ``` shell
  mtool-client.bat create_wallet --name reward
  ```

  输入一次密码，再输入一次确认密码，即可创建钱包文件，创建成功后会在目录`C:\tools\mtool\current\keystore`下生成质押钱包文件`reward.json`。

### 2.5 配置验证节点信息

**step1.** 浏览器复制链接 <https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/validator_conf.bat> 或者 <http://47.91.153.183/opensource/scripts/validator_conf.bat> 下载脚本

**step2.** 鼠标右键点击 validator_conf.bat， 选择以管理员身份运行

> 注意
>
> - 提示 `Please enter the platon node IP address:` 时，请输入 PlatON 节点服务器 ip 地址。
> - 提示 `Please enter the platon chain id:` 时，请输入链ID。
> - 提示 `Enter your name:` 时，请输入配置 nginx 时输入的用户名。
> - 提示 `Enter your password:` 时，请输入配置 nginx 时输入的密码。
> - 提示 `Enter your platon node name:` 时，请输入 PlatON 节点的名称。
> - 提示 `Enter your platon node description:` 时，请输入 PlatON 节点描述。
> - 提示 `validator conf success` 时，表示脚本执行成功，未执行成功时，请通过我们的官方客户联系方式反馈具体问题。
> - 提示 `请按任意键继续. . .` 时，请输入回车键关闭当前 cmd 窗口。
> - 请到 `C:\tools\mtool\current\validator` 目录下，查看 validator_config.json 内容，是否有异常。

### 2.6 申请质押资金

质押资金 LAT 要向 PlatON 官方申请，请发送邮件到 PlatON 官方邮箱 <support@platon.network> ，格式如下：

``` plain
【拉力赛-LAT申请】

申请人/申请组织/机构：{XXX}

|  节点ID  |   节点名称  | 节点IP和端口  | 质押账户地址  | 收益账户地址  |
| -------- | ---------- | ------------ | ------------ | ------------ |
| {nodeId} | {nodeName} | {ip}:{port}  | {address}     | {address}    |
```

- nodeId：在 `~/platon-node/data/nodeid` 中获取
- nodeName：为 PlatON 节点所有者为节点取的名称
- ip：节点的IP地址
- port：节点端口号，默认值为 16789
- address：质押钱包地址和收益钱包地址，MTool 创建完钱包之后，可以在钱包文件中获取。钱包文件中 `address` 字段加上0x即为有效地址。

申请提交之后，请耐心等待，可在 PlatON 官方区块链浏览器 [PlatScan](https://platscan.platon.network) 主页面搜索框输入质押账户地址，确认官方发放的 token 是否已到账。

### 2.7 验证节点质押

利用节点工具 MTool 执行节点质押与委托等操作，对于有能力的开发者，可以在 Java SDK 和 Javascript SDK 基础上面开发自己的节点工具，SDK请参考文档。

- [Java-SDK](./Java-SDK.md)
- [JavaScript-API](./JavaScript-API.md)

质押资金申请到账后，确保质押账户余额充足，根据用户情况替换{质押金额}，质押最低门槛为100万LAT。

``` shell
mtool-client.bat staking --amount {质押金额} --keystore %MTOOLDIR%\keystore\staking.json --config %MTOOLDIR%\validator\validator_config.json
```

例如：

``` shell
mtool-client.bat staking --amount 1000000 --keystore %MTOOLDIR%\keystore\staking.json --config %MTOOLDIR%\validator\validator_config.json
```

> 注意
>
> - 提示 `please input keystore password:` 时，输入质押钱包的密码。
> - 提示 `operation finished` 并且提示 `SUCCESS` 表明质押成功。

### 2.8 验证节点确认

完成质押操作后，可在 PlatON 官方区块链浏览器 [PlatScan](https://platscan.platon.network) 上点击主页上方验证节点列表，查看所有验证节点，或者在输入框输入节点名称查询节点具体信息，查看是否成为验证节点。

## 3. 数据备份

当验证人节点的数据不一致导致链无法正常运行时，需要验证节点将数据回滚到最近达成共识状态的区块，验证节点可以使用社区提供的备份数据。

**从实时性和安全上考虑，建议有条件的节点自行搭建备份节点。数据备份配置步骤如下：**

**step1.** 按照[节点安装部署](#1-节点安装部署)另行安装一个备份节点

**step2.** 以非 root 账户下载 timing_backup.sh 脚本

``` bash
wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/timing_backup.sh
```

或者

``` bash
wget http://47.91.153.183/opensource/scripts/timing_backup.sh
```

**step3.** 执行以下脚本

``` bash
chmod +x timing_backup.sh && ./timing_backup.sh
```

> 注意
>
> - 提示 `[sudo] password for` 时，输入当前账户密码。
> - 提示 `add backup_task.sh to crontab succeed` 时，表示配置数据库备份定时任务成功，未配置成功时，请通过我们的官方客户联系方式反馈具体问题。
> - `crontab -l` 查看有 `0 0 * * * ${HOME}/platon-node/backup_task.sh`字段, 其中 `${HOME}` 替换为用户的根目录，表示成功。
> - 数据库备份定时任务每日0点执行，备份文件生成在 `${HOME}/platon-node/data`目录下。

## 4. 紧急情况处理

请实时关注社区最新消息，底层链的重大事情会第一时间在社区公布。

当底层链出现问题无法继续正常运行时， 请执行[链下数据回滚升级指南](./链下数据回滚升级指南.md)，让底层链恢复正常运行。

当自己发现任何底层链的问题，请第一时间在社区通告。
