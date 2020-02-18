# 成为验证节点


PlatON 是实行民主治理的区块链项目，验证节点由所有 Energon 持有者共同推选，以维护和发展 PlatON 网络。得票数最多的101名节点将成为备选节点，从中用 VRF 随机选出25个验证节点，参与管理整个 PlatON 网络。

##  成为验证节点操作步骤

须按顺序完成以下步骤

### 同步时间
验证节点所在的服务器(服务器默认Ubuntu 18.04)需要保证时间的准确性，如何同步系统时间[见文档](zh-cn/Node/[Chinese-Simplified]-时钟同步.md)

###  安装节点
节点服务器须为Ubuntu 18.04，请按照[文档](zh-cn/Node/[Chinese-Simplified]-安装节点.md)中Ubuntu的部分进行操作

### 配置 nginx

安全考虑，不建议节点 rpc 端口对外直接开放（节点服务器默认Ubuntu 18.04）。可以考虑使用 Nginx 进行反向代理，并通过用户鉴权和 HTTPS 加强 Nginx 端口的安全性。如果用户在安装PlatON做了节点数据目录的修改，nginx_conf.sh脚本也需要修改成相同的节点数据目录。 Nginx 配置步骤如下：

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


###  MTool
为了便于节点进行质押，委托以及治理等相关的操作，PlatON提供了MTool来辅助用户。
MTool对质押等交易提供两种签名方式：在线签名和离线签名。根据用户需要选择对应的操作方式。

#### 在线MTool操作流程
  按照以下流程安装在线MTool并发起质押成为质押节点:
- [安装MTool](zh-cn/Tool/[Chinese-Simplified]-在线MTool使用手册#安装在线MTool)
- [配置MTool](zh-cn/Tool/[Chinese-Simplified]-在线MTool使用手册#配置在线MTool)
- [创建钱包](zh-cn/Tool/[Chinese-Simplified]-在线MTool使用手册#创建钱包)
- [配置验证节点信息](zh-cn/Tool/[Chinese-Simplified]-在线MTool使用手册#配置验证节点信息)
- [发起质押操作](zh-cn/Tool/[Chinese-Simplified]-在线MTool使用手册#发起质押操作)

#### 离线MTool操作流程
按照以下流程安装离线MTool并发起质押成为质押节点:
- [安装MTool](zh-cn/Tool/[Chinese-Simplified]-离线MTool使用手册#安装MTool)
- [配置MTool](zh-cn/Tool/[Chinese-Simplified]-离线MTool使用手册#配置)
- [钱包配置](zh-cn/Tool/[Chinese-Simplified]-离线MTool使用手册#钱包配置)
- [连接到验证节点](zh-cn/Tool/[Chinese-Simplified]-离线MTool使用手册#连接到验证节点)
- [发起质押操作](zh-cn/Tool/[Chinese-Simplified]-离线MTool使用手册#发起质押操作)


> 注：离线交易的签名须离线完成，操作流程参考[文档](zh-cn/Tool/[Chinese-Simplified]-离线MTool使用手册#基本操作流程)。
> 利用节点工具 MTool 执行节点质押与委托等操作，对于有能力的开发者，可以在 Java SDK 和 Javascript SDK 基础上面开发自己的节点工具，SDK请参考文档。
> -  [Java-SDK](zh-cn/Development/[Chinese-Simplified]-Java-SDK.md)
> - [JavaScript-API](zh-cn/Development/[Chinese-Simplified]-JS-SDK.md)


## 验证节点确认

完成质押操作后，可在 PlatON 官方区块链浏览器 [PlatScan](https://platscan.platon.network) 上点击主页上方验证节点列表，查看所有验证节点，或者在输入框输入节点名称查询节点具体信息，查看是否成为验证节点。











