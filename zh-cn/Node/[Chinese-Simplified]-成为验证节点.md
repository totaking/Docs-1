## 成为PlatON验证节点


先决条件教程： 

1）  安装部署节点

2）  安装部署mtool 


### 1 验证节点概述
PlatON 是实行民主治理的区块链项目，验证节点由所有 Energon 持有者共同推选，以维护和发展 PlatON 网络。得票数最多的101名节点将成为备选节点，从中用 VRF 随机选出25个验证节点，参与管理整个 PlatON 网络。


### 2 成为验证节点的基本要求

#### 2.1 最低质押要求

最低质押要求为100万Energon，可以增加质押，但是只能一次性全部取消所有质押。

#### 2.2 硬件要求

- 服务器: 运行PlatON软件的服务器和备份服务器(都需要具备防火墙)
- 内存: 8GB RAM 
- 本地存储: 512GB SSD, 支持动态扩容，单卷容量上限16TB
- 处理器: 64位4 核 (每核2.4 GHz以上)
- 带宽: 100 Mbps

#### 2.3 软件要求

建议使用Ubuntu 18.04，因为这个版本经过完整测试。

#### 2.4 运营要求

- 网络监控及实时支持
- 99.9%的正常运行时间
- 跨地域失效备援和数据备份
- 安全保障措施
- 支持软件升级

### 3 成为验证节点操作步骤

####  3.1 安装节点
[见文档](./[Chinese-Simplified]-安装部署节点.md)

####  3.2 安装mtool
 [见文档](../Tool/[Chinese-Simplified]-在线MTool使用手册.md)

#### 3.3. 创建钱包
PlatON中，参与验证节点进行出块要创建两个钱包。

其中Windows和Ubuntu下MTool的命令及目录有所区别：

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

- 质押钱包
  质押钱包用于质押 token，质押成功后才能成为备选节点候选人。
  打开终端，运行以下命令创建质押钱包：
  
  ``` shell
  $mtool-client account new staking
  ```

  输入一次密码，再输入一次确认密码，即可创建钱包文件，创建成功后会在目录`$MTOOLDIR/keystore`下生成质押钱包文件`staking.json`。

- 收益钱包
  用于收取区块奖励和Staking奖励，Staking奖励统一发放给验证节点，由验证节点自行分配。
  运行以下命令创建收益钱包：
  
  ``` shell
  $mtool-client account new reward
  ```

  输入一次密码，再输入一次确认密码，即可创建钱包文件，创建成功后会在目录`$MTOOLDIR/keystore`下生成质押钱包文件`reward.json`。


#### 3.4  配置验证节点信息

根据用户在Windows或Ubuntu上安装的MTool，选择对应系统上的验证节点信息配置：

##### 3.4.1  Windows下配置验证节点信息

操作步骤如下：

**step1.** 浏览器复制链接  

 [下载脚本validator_conf.bat]( <https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/validator_conf.bat>)

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
> - 请到 `C:/tools/mtool/current/validator` 目录下，查看 validator_config.json 内容，是否有异常。

##### 3.4.2  Ubuntu下配置验证节点信息

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


#### 3.5 验证节点质押

利用节点工具 MTool 执行节点质押与委托等操作，对于有能力的开发者，可以在 Java SDK 和 Javascript SDK 基础上面开发自己的节点工具，SDK请参考文档。

- [Java-SDK](./Java-SDK.md)
- [JavaScript-API](./JavaScript-API.md)

确保质押账户余额充足，根据用户情况替换{质押金额}，质押最低门槛为100万LAT。

``` shell
$mtool-client staking --amount {质押金额} --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

例如：

``` shell
$mtool-client staking --amount 1000000 --keystore $MTOOLDIR/keystore/staking.json --config $MTOOLDIR/validator/validator_config.json
```

> 注意
>
> - 提示 `please input keystore password:` 时，输入质押钱包的密码。
> - 提示 `operation finished` 并且提示 `SUCCESS` 表明质押成功。

#### 3.6 验证节点确认

完成质押操作后，可在 PlatON 官方区块链浏览器 [PlatScan](https://platscan.platon.network) 上点击主页上方验证节点列表，查看所有验证节点，或者在输入框输入节点名称查询节点具体信息，查看是否成为验证节点。











