#!/usr/bin/env bash

#备份数据节点信息
cd ~/platon-node/data
backup_date=`date '+%Y_%m_%d'`         #备份时间

#备份节点数据
#获取块高
block_num=`platon attach ipc:platon.ipc -exec platon.blockNumber`
if [ 0 -ne $? ]; then
    echo -e "\033[;31m获取块高失败!!! \033[0m"
    exit 1
fi 

#暂停进程
pkill -9 platon
if [ $? -eq 0 ];then
	echo -e "\033[;32m节点暂停成功========== \033[0m"
else
	echo -e "\033[;31m节点暂停失败！！！ \033[0m"
	exit 1
fi

#开始备份
echo "开始备份数据..."
tar -zPcvf data_backup_${backup_date}_${block_num}_BAD.tar.gz ./platon
	
# 删除旧数据
echo "备份数据完成,按任意键,删除旧数据..."
read -n 1
if [ $? -eq 0 ];then
	rm -rf platon 
	echo "删除旧数据成功!"
else 
	echo "数据备份失败!" 
fi
