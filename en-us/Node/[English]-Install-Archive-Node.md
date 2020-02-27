The archive node will save the complete state and receipt history data, and the non-archive node will periodically clear the state and receipt history data. It can only save the corresponding data of the last 10 blocks. For example, if the node needs to query the historical data, the node needs to Turn on archive mode.


## Overview

When the node is started, the historical data of state and receipt are cleared regularly by default, and only the corresponding data of the last 10 blocks can be saved.

Assuming the current blockNumber is 120, enter the platon console and query the account balance of account 0x1000000000000000000000003 at 100 blockNumber:

```
platon.getBalance ('0x1000000000000000000000003', 100)
```

Output result:

```
Error: missing trie node f7e7f0f53eb6dc23d18f8285553c916fdd410e484b611d53883e2a060e7926f8 (path)
```


If the node needs to query historical data, the node needs to enable the archive mode when it starts, and it will not delete the real-time state and receipt historical data after startup.

After opening the archive mode, query the account balance information as follows:

```
platon.getBalance ('0x1000000000000000000000003', 100)
```

Output result:

```
1000000000000000
```



> [!NOTE|style:flat|label:注意]
>
> Enabling archive mode will increase the disk usage by about 3 times.

 
This section describes how to operate as an archive node.


## Steps

The following steps must be completed in order

### synchronised time

Make sure the node's time is correct, so you need to synchronize with the time server in real time. Take the Ubuntu system as an example to explain how to synchronize time


#### Install NTP (Auto Sync)


Install ntp server and set it to boot automatically

```bash
sudo apt-get -y install ntp  &&  sudo systemctl enable ntp
```


#### View synchronization

Enter the following command 

```bash
ntpq -p
```

Output result

![ntpq返回](ntpq.assets/ntpq.png)
 

Property description:

- remote - remote node or server for synchronization
- refid - a remote server that synchronizes to a higher level server
- st - Stratum of remote node or server (level, NTP time synchronization is hierarchical)
- t - type u: unicast or manycast client, b: broadcast or multicast client, l: local clock, s: symmetric node (for backup), A : Anycast server, B: Broadcast server, M: Multicast server,
- when - time since last request (seconds)
- poll - how often the local and remote server are synchronized (seconds)
- reach - is used to test whether it can connect to the server, and its value will increase every time it connects successfully,
- offset - The time offset between the host and the remote node or server time source. The closer the offset is to 0, the closer the time between the host and the NTP server (milliseconds).
- delay – round-trip time (ms) from local to remote node or server communication


Explanation of the symbol in front of remote:

(+) Good and preferred remote node or server (included in combination algorithm)

(*) The remote node or server that is currently the priority master synchronization object
  
  

### Install node

The node server must be Ubuntu 18.04, please follow the part of Ubuntu in [Install Node](/en-us/Node/_[English]-Install-Node.md).


### Generate nodekey and blskey

When the node is started, the node's public and private keys and BLS public and private keys are required. The BLS public and private keys will be used in the consensus protocol.

Refer to [Node KeyPair](/en-us/Node/_[English]-WalletFile-and-KeyPair.md#Node-key) for the key generation method, and save the generated key to the directory where the node is located.

 
> [!NOTE|style:flat|label:注意]
>
> If the key is not generated in advance, the node is automatically generated in the node's data directory at startup.


### Start nodes to join the network

According to your needs, start the node to join the public network or set up the private network. Refer to the following:

- [Join Private Network](/en-us/Network/[English]-SettingUp-Private-Chain.md)
- [Join the Public Network](/en-us/Network/[English]-MainNet-and-TestNet.md)


> [!NOTE|style:flat|label:注意]
>
> Add --db.nogc to the command line when starting a node to join the network