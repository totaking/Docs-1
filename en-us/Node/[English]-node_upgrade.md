
During the operation of the PlatON network, to ensure that the network can continuously iterate and improve, all nodes need to follow the on-chain governance process to upgrade local nodes. The alternative validator  need to vote.


- Each alternative validator  can only vote once for each proposal

- If you miss the voting period and are reduced to a alternative validator	 candidate, you can send a version declaration transaction after upgrading to the specified version locally to become a alternative validator again

## Get upgrade proposal information

In order to ensure that the nodes can be upgraded in a timely manner without affecting the normal participation in consensus, the nodes need to pay attention to the upgrade proposal information in a timely manner. Information on upgrade proposals can be obtained through community announcements and on-chain inquiries.

### Focus on community governance announcements

You can get the information of the upgrade proposal in time by following the announcement of the community. When a node is required to vote on an upgrade proposal, the community will post [relevant](https://forum.latticex.foundation/c/PlatON-EN/20). E.g:

```bash
Proposal details：
  PIPID：100
  Proposal address：https://platscan.test.platon.network/proposal-detail?proposalHash=0xad330d8a5fddf3526a8622dab22454f8861fee968b6482eebbd360c8d15691c3

  ProposalID：0xad330d8a5fddf3526a8622dab22454f8861fee968b6482eebbd360c8d15691c3

  Target version ：0.9.0
  Voting epoch：Start block height 533681, cut-off block height 619980

   Code address：
  Code&Branch：https://github.com/PlatONnetwork/PlatON-Go/tree/pip_v0.7.3
  commit ID: d2b7bf51a68158bfa61d622ffde3841c55634a18
```


As shown in the proposal details example above, the released proposal information will describe the ID of the proposal, the new version number, the voting period, and the new version code.

### Query directly from the chain

The upgrade proposal can also be queried directly in the blockchain browser [PlatScan](https://platscan.test.platon.network/proposal).

## Upgrade operation process

### Upgrade the node to the specified version

According to the new version number (assuming 0.9.0) in the upgrade proposal obtained from the community announcement or blockchain browser, then download the official script provided by PlatON for node upgrade. Perform the following steps on **the machine where the node is deployed**:

> If the download script fails, set the DNS server to 8.8.8.8。

- Download the script first (the script can be stored anywhere)

  ```bash
  wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/update_platon.sh
  ```

  or

  ```bash
  wget http://47.91.153.183/opensource/scripts/update_platon.sh
  ```

    **Note: If the default directory address of node data storage is modified when the node of the PlatON network is installed, you need to change the node_dir = ~ / platon-node attribute value in the update_platon.sh script to the modified node data directory address.**

- Execute the command to update the node version

  ```bash
  chmod u+x update_platon.sh && ./update_platon.sh 0.9.0 --xxxnet
  ```
  
    **Notice：**
  
    0.9.0 is the specified version number that needs to be upgraded (the version number can be obtained from the relevant announcement issued by the community or from the chain through the blockchain browser).

    ​--xxxnet specifies a certain network. If you leave this field blank, it will default to the main network.
  
    When the prompt **”[sudo] password for platon:“** appears, you need to enter the user password of the currently logged in machine.

    When the prompt **”Do you want to continue?“** Appears, enter:  **y**  (to continue execution, otherwise vice versa).

    When the execution result is as follows, the version upgrade is successful:
  
    ```
     当前已安装版本：0.8.0==========
     开始安装：0.9.0版本==========
     节点暂停成功==========
     Do you want to continue? [Y/n] y
     卸载当前版本：platon0.8.0成功==========
     安装版本：platon0.9.0成功==========
     重启节点成功============ 
    ```
  
    >When the following situations occur, no version upgrade is performed, and the node will continue to run with the previously installed version：
    >
    >- The specified version does not exist。
    >- Specifies that the version to be upgraded is not higher than the installed version。
    >

### Vote

The following voting operations need to be implemented with the help of the MTool tool. The tool is divided into offline and online methods. You can choose the version to use as required. For details, please refer to:

- [Online MTool](/en-us/Tool/[English]-Online-MTool-user-manual.md)
- [Offline MTool](/zh-cn/Tool/[English]-Offline-MTool-user-manual.md)

>  The commands and directories of MTool are different due to different systems, so the following commands and directories use Ubuntu as an example (please replace with the actual command and directory of the user's actual system and installation)：
>
>  mtool-client means MTool command
>
>  ~/MTool means MTool directory
>
>  ~/platon-node  represents the directory address of the node data

#### Get the current block height

```bash
cd ~/platon-node/data && platon attach ipc:platon.ipc -exec platon.blockNumber
```

This command returns the current block height, which can be used to determine whether it is within the range of the voting period of the proposal. Link address reference: [Focus on community governance announcements](#Focus-on-community-governance-announcements ). For example, the voting period published by the community is [533681, 619980]. If the current block height is 600,000, it is within the voting period; if the current block height is greater than 619980, it indicates that the voting period has passed. Only when it is within the voting period, the following voting operations for the promotion proposal are performed.

#### Upgrade Proposal Vote

- If it is within the voting period, you need to vote for the upgrade proposal, otherwise skip this section.

  ```bash
  mtool-client vote_versionproposal --proposalid 0xad330d8a5fddf3526a8622dab22454f8861fee968b6482eebbd360c8d15691c3 --keystore ~/MTool/keystore/staking.json --config ~/MTool/validator/validator_config.json
  ```

  **Notice:**
  0xad330d8a5fddf3526a8622dab22454f8861fee968b6482eebbd360c8d15691c3 is the ProposalID of the upgrade proposal provided by the community announcement. For details, please refer to:[Focus on community governance announcements](#Focus-on-community-governance-announcements ).

  If after the execution of the above command, the voting transaction is successfully sent back to the **voting transaction hash**. For example, when the following information appears, the voting transaction was sent successfully, otherwise the upgrade proposal failed to vote:

  ```bash
  operation finished
  transaction hash: 0x344d5c916a070453567fe95c6b79cd86bb70c248f96da98fb0ec3aa6617cc9a3
  SUCCESS
  ```

- Verify that the vote was successful

   When the voting transaction is successfully sent, it can only indicate that the transaction was successfully executed, so it is necessary to verify whether the voting was successful. Download the following script anywhere on **the machine where the node is deployed** and execute the commands in order:

  ```bash
  wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/verify_transaction.sh
  ```
  
  or

  ```bash
  wget http://47.91.153.183/opensource/scripts/verify_transaction.sh
  ```
  
  **Note: If the default directory address of node data storage is modified when installing a node of the PlatON network, you need to change the node_dir=~/platon-node attribute value in the verify_transaction.sh script to the modified node data directory address.**

  After downloading the script, you need to modify the execution permissions before executing the script:
  
  ```bash
  chmod u+x verify_transaction.sh && ./verify_transaction.sh 0x344d5c916a070453567fe95c6b79cd86bb70c248f96da98fb0ec3aa6617cc9a3
  ```
  
  **Note:** where 0x344d5c916a070453567fe95c6b79cd86bb70c248f96da98fb0ec3aa6617cc9a3 is **the hash of the voting transaction** returned by the voting operation of the upgrade proposal, please replace it according to the actual return value.

  After the script is executed, if the following message appears, it means that the upgrade proposal vote was successful, otherwise the upgrade proposal vote failed.
  
  ```bash
  获取交易回执成功==========
  解析交易回执中==========
  交易成功！！！
  ```

#### Version declaration

- If the voting period is not currently completed and the voting operation has not been completed, you need to perform a version declaration operation. Use the following MTool command to perform the version declaration operation:

  ```bash
  mtool-client declare_version --keystore ~/MTool/keystore/staking.json --config ~/MTool/validator/validator_config.json
  ```

  **Note:** After executing the above command, if the version declaration transaction is sent successfully, **the version declaration transaction hash** will be returned. For example, the following information indicates that the transaction was sent successfully, otherwise the version declaration failed:

  ```bash
  operation finished
  transaction hash: 0x776d5be7363451540b7113771cf4263de6a18973ed8904796a561acf37e58ff2
  SUCCESS
  ```

- Verify version declaration succeeded

  When the version declaration transaction is successfully sent, it can only indicate that the transaction was executed successfully, so you also need to verify whether the version declaration was successful. Download the following script anywhere on **the machine where the node is deployed** and execute the commands in sequence (**if you have downloaded the verify_transaction.sh script , You don't need to download it again, just execute the command**):

  ```bash
  wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/verify_transaction.sh
  ```
  
  or

  ```bash
  wget http://47.91.153.183/opensource/scripts/verify_transaction.sh
  ```
  
  **Note: If the default directory address of node data storage is modified when installing a node of the PlatON network, you need to change the node_dir=~/platon-node attribute value in the verify_transaction.sh script to the modified node data directory address.**
    
  After downloading the script, you need to modify the execution permissions before executing the script:
  ```bash
  chmod u+x verify_transaction.sh && ./verify_transaction.sh 0x776d5be7363451540b7113771cf4263de6a18973ed8904796a561acf37e58ff2
  ```
  
  **Note:**  where 0x776d5be7363451540b7113771cf4263de6a18973ed8904796a561acf37e58ff2 is the transaction hash returned by the version declaration operation, please modify it according to the actual return value.

  After executing the script, if the following message appears, the version declaration was successful, otherwise the version declaration failed.
  
  ```bash
  获取交易回执成功==========
  解析交易回执中==========
  交易成功！！！·
  ```

## Verify node upgrade results

After performing all the operations above, you need to verify whether the operation result is successful. You first need to download the following verification script, which will perform the verification operation and print the verification result. Download and operate the following script anywhere on **the machine where the node is deployed**:

- Download verification script

  ```bash
  wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/verify_votResult.sh
  ```

  or

  ```bash
  wget http://47.91.153.183/opensource/scripts/verify_votResult.sh
  ```

  **Note: If the default directory address of node data storage is modified when installing a node of the PlatON network, you need to change the node_dir=~/platon-node attribute value in the verify_transaction.sh script to the modified node data directory address.**

- Download rlp tool

  Since the verification script relies on the ppos_tool tool, you need to download the tool in the same directory as the verification script. First execute the following download command:
  
  ```bash
  wget https://7w6qnuo9se.s3.eu-central-1.amazonaws.com/opensource/scripts/ppos_tool
  ```
  
  or
  
  ```bash
  wget http://47.91.153.183/opensource/scripts/ppos_tool
  ```
  
- Execute validation script

  The order needs to pass 1000 blocks after the proposal voting cut-off block height (a consensus round is 250 blocks, 1000 blocks is the number of blocks of four consensus rounds, assuming the cut-off block height is 610,000, then 611,000 is Deadline) Then execute the following script to check the upgrade result:
  
  ```bash
  chmod u+x verify_votResult.sh && chmod u+x ppos_tool && ./verify_votResult.sh 0x85083f1d4f3e5e1aeafbd29df1db9764c25216e94fa0b446caa36f89ffa8f26f
  ```

  > Among them 0x85083f1d4f3e5e1aeafbd29df1db9764c25216e94fa0b446caa36f89ffa8f26f is **the ProposalID of the upgrade proposal**, please replace it according to the proposal ID in the actual announcement, the link address reference: [Focus on community governance announcements](#Focus-on-community-governance-announcements )
  
  When the script is executed, the following print results indicate that the upgrade was successful:
  
  ```bash
  获取提案成功==========
  提案生效块高为：620980
  当前块高为：621010
  区块高度已到达提案生效区块高度，开始验证==========
  开始验证升级提案投票结果==========
  升级提案投票结果验证成功==========
  开始验证提案版本号==二进制的版本号==链上生效版本号==========
  升级提案版本验证成功==============
  开始验证节点的质押状态=============
  获取节点质押信息成功==========
  节点未退出验证人列表，升级版本成功，当前链生效版本为：2304
  ```
  
  > The verification script does the following checks：
  >
  >  - Whether the proposal is approved
  >
  >  - Whether the current node version number is consistent with the proposal version number
  > 
  >  - The pledged status of the current node. If it is not 0, exit the candidate node candidate.
