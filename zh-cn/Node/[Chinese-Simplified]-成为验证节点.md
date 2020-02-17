# 成为验证节点


## 验证节点概述
PlatON 是实行民主治理的区块链项目，验证节点由所有 Energon 持有者共同推选，以维护和发展 PlatON 网络。得票数最多的101名节点将成为备选节点，从中用 VRF 随机选出25个验证节点，参与管理整个 PlatON 网络。


## 成为验证节点的基本要求

### 先决条件

1）  安装部署节点

2）  安装部署mtool 


### 最低质押要求

最低质押要求为100万Energon，可以增加质押，但是只能一次性全部取消所有质押。

### 硬件要求

- 服务器: 运行PlatON软件的服务器和备份服务器(都需要具备防火墙)
- 内存: 8GB RAM 
- 本地存储: 512GB SSD, 支持动态扩容，单卷容量上限16TB
- 处理器: 64位4 核 (每核2.4 GHz以上)
- 带宽: 100 Mbps

### 软件要求

建议使用Ubuntu 18.04，因为这个版本经过完整测试。

### 运营要求

- 网络监控及实时支持
- 99.9%的正常运行时间
- 跨地域失效备援和数据备份
- 安全保障措施
- 支持软件升级

##  成为验证节点操作步骤

###  安装节点
[见文档](zh-cn/Tool/[Chinese-Simplified]-安装节点.md)

###  安装mtool
 [见文档](zh-cn/Tool/[Chinese-Simplified]-在线MTool使用手册.md)

### 创建钱包
PlatON中，参与验证节点进行出块要创建两个钱包。

其中Windows和Ubuntu下MTool的命令及目录有所区别：

- MTool命令

  - Windows：mtool-client.bat
  - Ubuntu：mtool-client

- MTool目录

  - Windows：`%MTOOLDIR%`

  - Ubuntu：`$MTOOLDIR`

>  说明：
>
>   - MTool命令用变量`$mtool-client`代替；
>   - MTool目录用变量`$MTOOLDIR`代替；
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

### 时钟同步

验证节点的时间需要保持正确，因此需要和时间服务器实时同步，以Ubuntu为例，如何进行时间同步:

#### 安装NTP(自动同步)

```bash
apt-get -y install ntp
#设置开机自启
systemctl enable ntp
```

#### 查看同步情况

```bash
#ntpq -p
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 LOCAL(0)        .LOCL.          10 l   73   64    2    0.000    0.000   0.000
-120.25.115.20   10.137.53.7      2 u    1   16   37  367.287  -84.725  25.222
+100.100.5.2     10.137.55.181    2 u    -   16   37  117.241   26.126  27.217
+100.100.3.1     10.137.55.181    2 u   17   16   17  117.581   34.371  21.132
+100.100.5.1     10.137.55.181    2 u    1   16   37  119.670   25.698  27.093
+100.100.5.3     10.137.55.181    2 u    -   16   37  114.533   26.214  27.230
*100.100.61.88   .BD.             1 u    -   16   37    0.733   26.100  27.230

```

#### 属性说明

- remote – 用于同步的远程节点或服务器

- refid – 远程的服务器进行同步的更高一级服务器

- st – 远程节点或服务器的 Stratum（级别，NTP 时间同步是分层的）

- t  类型 u: unicast（单播） 或 manycast（选播） 客户端, b: broadcast（广播） 或 multicast（多播） 客户端, l: 本地时钟, s: 对称节点（用于备份）, A: 选播服务器, B: 广播服务器, M: 多播服务器,

- when 距离上次请求时间（秒）

- poll   本机和远程服务器多长时间进行一次同步（秒）

- reach  用来测试能否和服务器连接，每成功连接一次它的值就会增加，

- offset  主机与远程节点或服务器时间源的时间偏移量，offset 越接近于0，主机和 NTP 服务器的时间越接近（毫秒）

- delay – 从本地到远程节点或服务器通信的往返时间（毫秒）

#### remote前面符号的说明

（ + ）良好的且优先使用的远程节点或服务器（包含在组合算法中）
  ( * ）当前作为优先主同步对象的远程节点或服务器

#### 安装ntpdate(手动同步)

```bash
#安装
apt install ntpdate
#同步，需要先停止ntp
systemctl stop ntp
ntpdate <ntp-server>(域名或者ip)
```




### 配置验证节点信息

根据用户在Ubuntu上安装的MTool，选择对应系统上的验证节点信息配置：


#### Ubuntu下配置验证节点信息

##### 配置 nginx

安全考虑，不建议节点 rpc 端口对外直接开放。可以考虑使用 Nginx 进行反向代理，并通过用户鉴权和 HTTPS 加强 Nginx 端口的安全性。如果用户在安装PlatON做了节点数据目录的修改，nginx_conf.sh脚本也需要修改成相同的节点数据目录。 Nginx 配置步骤如下：

**step1.** 下载 nginx_conf.sh

``` bash
wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/nginx_conf.sh
```

或者

``` bash
wget http://47.91.153.183/opensource/scripts/nginx_conf.sh
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

##### 配置节点

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


## 验证节点质押

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

## 验证节点确认

完成质押操作后，可在 PlatON 官方区块链浏览器 [PlatScan](https://platscan.platon.network) 上点击主页上方验证节点列表，查看所有验证节点，或者在输入框输入节点名称查询节点具体信息，查看是否成为验证节点。











