#!/bin/bash

if [ -z $1 ]; then
	echo "请输入需要安装的版本号!!!"
	exit 1
fi

# ppa方式更新platon二进制
update_version=$1

# 版本比较函数
arrCompare=("" "")
function compareVersion()
{
	# 版本位数
	verDigit=3
	# 当前安装版本
	currVersion=${arrCompare[0]}
	# 更新版本
	updateVersion=${arrCompare[1]}
	while [ $verDigit -ge 0 ]
	do
		currLeftTmp=${currVersion%%.*}
		updateLeftTmp=${updateVersion%%.*}
		
		if [ $updateLeftTmp -gt $currLeftTmp ];then
			return 1
		elif [ $updateLeftTmp -lt $currLeftTmp ];then
			return 0
		fi
		
		# 没有小版本补0
		currVersion=`echo $currVersion | grep "\."`
		if [ -z $currVersion ]; then
			currVersion=0
		else
			currVersion=${currVersion#*.}
		fi
		
		updateVersion=`echo $updateVersion | grep "\."`
		if [ -z $updateVersion ]; then
			updateVersion=0
		else
			updateVersion=${updateVersion#*.}
		fi
		
		verDigit=`expr $verDigit - 1`
	done

	return 0
}

#更新版本
sudo apt update

#查看当前安装的版本，以及新版本
all_platon=`apt search platon`

#echo $all_platon

# 判断版本是否存在,不能用grep方式，.可以匹配任意字符
len1=`echo $all_platon|wc -L`
update_platon_version=platon${update_version}
update_platon=${all_platon%%$update_platon_version/*}

len2=`echo $update_platon|wc -L`
if [ "$len1" -eq "$len2" ] 
then
	echo -e "\033[;31m没有找到此版本：$update_version，请检查\033[0m"
	exit 1
fi

# 当前安装版本
curr_platon_version=`apt search platon |awk '/installed/' |awk -F "/" '{print $1}'`

if [ "$curr_platon_version" == "" ]
then
	echo -e "\033[;32m当前节点没有安装platon========== \033[0m"
else
	echo -e "\033[;32m当前已安装版本：$curr_platon_version========== \033[0m"

	# 比较版本号
	arrCompare=($curr_platon_version $update_platon_version)
	compareVersion
	
	if [ $? -eq 0 ]; then
		echo -e "\033[;31m当前版本号不需要更新：$curr_platon_version\033[0m"
		exit 1
	fi
fi

echo -e "\033[;32m开始安装$update_platon_version版本========== \033[0m"

# 暂停节点
pid=`ps -ef | grep platon | grep -v grep | grep -v "update_platon.sh" | awk '{print $2}'`
if [ ! -z "$pid" ] 
then
	kill -9 $pid
	if [ $? -eq 0 ];then
		echo -e "\033[;32m节点暂停成功========== \033[0m"
	else
		echo -e "\033[;31m节点暂停失败，更新platon失败！！！ \033[0m"
		exit 1
	fi
fi

# 卸载当前版本
if [ "$curr_platon_version" != "" ]
then
	sudo apt remove $curr_platon_version --purge
	if [ $? -eq 0 ];then
		echo -e "\033[;32m卸载当前版本：$curr_platon_version成功========== \033[0m"
	else
		echo -e "\033[;31m卸载当前版本：$curr_platon_version失败，更新platon失败！！！ \033[0m"
		exit 1
	fi
fi

# 安装指定版本
sudo apt install $update_platon_version
if [ $? -eq 0 ];then
	echo -e "\033[;32m安装版本：$update_platon_version成功========== \033[0m"
else
	echo -e "\033[;31m安装版本：$update_platon_version失败，更新platon失败！！！ \033[0m"
	exit 1
fi

# 是否启动节点
if [ -n "$2" ] 
then
	if [ $2 == "nostart" ]
	then
	#	echo "节点不重启"
		exit 0
	fi
fi

# 重启节点
cd ~/platon-node
nohup platon --identity "platon" --datadir ./data --port 16789 --rpc --rpcaddr 127.0.0.1 --maxpeers 25 --rpcport 6789 --rpcapi "platon,debug,personal,admin,net,web3" --nodekey "./data/nodekey" --cbft.blskey ./data/blskey >> platon.log 2>&1 &
if [ $? -eq 0 ];then
	echo -e "\033[;32m重启节点成功============ \033[0m"
else
	echo -e "\033[;31m重启节点失败！！！ \033[0m"
	exit 1
fi






