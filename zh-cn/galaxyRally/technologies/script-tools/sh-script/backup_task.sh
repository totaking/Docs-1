#!/usr/bin/env bash

# 获取区块高度和备份时间
backup_date=`date '+%Y_%m_%d'` 
cd ~/platon-node/data
block_num=`platon attach ipc:platon.ipc -exec platon.blockNumber`
if [ 0 -ne $? ]; then
    echo -e "\033[;31mplaton attach and get block number failed!!! \033[0m"
    exit 1
fi        

# 停止 platon 进程
pkill -9 platon
if [ $? -eq 0 ];then
	echo -e "\033[;32mOK! platon has been stop \033[0m"
else
	echo -e "\033[;31mstop platon error, Please check platon's status \033[0m"
	exit 1
fi

# 备份数据
tar -zPcvf data_backup_${backup_date}_${block_num}.tar.gz ./platon
if [ $? -eq 0 ];then
	echo -e "\033[;32mthe backup task has benn finished \033[0m"
else
	echo -e "\033[;31mbackup task error \033[0m"
	exit 1
fi

# 重启节点
nohup platon --identity platon --datadir ~/platon-node/data --datadir ~/platon-node/data --port 16789 --rpc --rpcaddr 127.0.0.1 --rpcport 6789 --rpcapi platon,debug,personal,admin,net,web3,txpool --maxpeers 25 --verbosity 3 --nodekey ~/platon-node/data/nodekey --cbft.blskey ~/platon-node/data/blskey &
if [ $? -eq 0 ];then
	echo -e "\033[;32mplaton has been started, backup succeed \033[0m"
else 
	echo -e "\033[;31mplaton startup failed \033[0m"
	exit 1
fi
