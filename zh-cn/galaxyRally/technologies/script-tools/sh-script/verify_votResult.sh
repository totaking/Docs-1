#!/bin/bash

# 判断是否输入提案ID
if [ ! -n "$1" ]
then 
	echo "请输入提案ID!!!"
	exit 0
fi

:<<!
查找指定字符串的值(json)
函数入参：  
    param[0] : 原字符串
    param[1] : 左边截取子字符串
	param[2] : 右边截取子字符串
    param[3] : 是否是十六进制字符串(0:否,1:是)
    return:	0:成功, 1:失败
!
arrParams=("" "" "" 0)
# 保存每次查找的值
g_strValue=""
g_textOrigin=""
function findSubStrValue()
{
	strOrigin=${arrParams[0]}
	strLeftSub=${arrParams[1]}
	strRightSub=${arrParams[2]}
	isHex=${arrParams[3]}
	
	if [ $isHex == 1 ];then
		# 十六进制字符串转换成文本字符串
		length=`echo $strOrigin|wc -L`
		string=$strOrigin
		g_textOrigin=""
		# 从0x后面的字符串开始转换
		for (( i = 1; i < $length/2; i++)); do
			tmp='\x'${string:$(($i*2)):2}
			g_textOrigin=$g_textOrigin$tmp
		done
		# 去掉\转义符号
		g_textOrigin=`echo -e $g_textOrigin|sed 's/\\\//g'`
	else
		g_textOrigin=$strOrigin
	fi
	
	# echo "g_textOrigin:$g_textOrigin"
	
	# 开始查找
	g_strValue=${g_textOrigin#*$strLeftSub}
	g_strValue=${g_strValue%%$strRightSub*}
	
	return 1
}

# 验证节点升级结果
bin=platon
toolBin=./ppos_tool
work_dir=$PWD
data_dir=~/platon-node/data

# 提案ID
ProposalID=$1
# 查询升级提案
rlpVersion=`$toolBin --funcType 2100 --proposalID $ProposalID`
cd $data_dir
result=`$bin attach ipc:platon.ipc -exec "platon.call({'to':'0x1000000000000000000000000000000000000005','data':'$rlpVersion'})"`
if [ ! $? -eq 0 ];then
    echo -e "\033[;31mattch platon.ipc失败,请检查路径!!!\033[0m"
    exit 1
fi

cd $work_dir
VersionProposal=`echo $result|sed 's/\"//g'`

# 验证提案的code
arrParams[0]=$VersionProposal
arrParams[1]="\"Code\":"
arrParams[2]=","
arrParams[3]=1

findSubStrValue
if [ $g_strValue != 0 ]; then
	echo -e "\033[;31m查询提案失败!!!提案ID不存在,请检查!!!\033[0m"
	exit
fi 

#保存提案
textVerProposal=$g_textOrigin

# 获取提案的生效块高
arrParams[0]=$g_textOrigin
arrParams[1]="\"ActiveBlock\":"
arrParams[2]="\}"
arrParams[3]=0
activeBlock=""
findSubStrValue
if [ $g_strValue == 0 ]; then
	echo -e "\033[;31m获取提案生效块高失败!!!\033[0m"
	exit 1
fi 

activeBlock=$g_strValue
echo -e "\033[;32m提案生效块高为：$activeBlock\033[0m"

# 获取当前块高
cd $data_dir
blockNumber=`$bin attach ipc:platon.ipc -exec 'platon.blockNumber'`
cd $work_dir
echo -e "\033[;32m当前块高为：$blockNumber\033[0m"

if [ "$blockNumber" -lt "$activeBlock" ]
then
	echo -e "\033[;31m区块高度未到达提案生效区块高度，退出验证！！！\033[0m"
	exit 1
fi

echo -e "\033[;32m区块高度已到达提案生效区块高度，开始验证==========\033[0m"

# 不能通过提案版本号和节点版本号判断，有可能二进制升级成功，但是投票或版本声明失败
# 查询提案投票结果
rlpProResult=`$toolBin --funcType 2101 --proposalID $ProposalID`
#echo $rlpProResult

#rlpProResult="0xe683820835a1a06539334c616571db01eb2f90e092bc70004d94954e354d893fb6f04b23c3698a"
cd $data_dir
result=`$bin attach ipc:platon.ipc -exec "platon.call({'to':'0x1000000000000000000000000000000000000005','data':'$rlpProResult'})"`
cd $work_dir
proposal=`echo $result|sed 's/\"//g'`

# 验证投票状态
echo -e "\033[;32m开始验证升级提案投票结果========== \033[0m"
status=""
arrParams[0]=$proposal
arrParams[1]="\"status\":"
arrParams[2]=","
arrParams[3]=1

findSubStrValue
status=$g_strValue
if [ $status == 3 ]
then
	echo -e "\033[;31m投票失败!!!\033[0m"
	exit 1
else if [ $status == 6 ]
then
	echo -e "\033[;31m升级提案被取消!!!\033[0m"
	exit 1
fi
fi

echo -e "\033[;32m升级提案投票结果验证成功========== \033[0m"

echo -e "\033[;32m开始验证提案版本号==二进制的版本号==链上生效版本号========== \033[0m"

# 获取提案版本号
arrParams[0]=$textVerProposal
arrParams[1]="\"NewVersion\":"
arrParams[2]=","
arrParams[3]=0

findSubStrValue
newVersion=$g_strValue
#echo $newVersion

# 获取二进制版本
cd $data_dir
result=`$bin attach ipc:platon.ipc -exec 'admin.getProgramVersion()'`
cd $work_dir
result=`echo $result|sed 's/\ //g'`
#echo $result

binVersion=${result#*Version:}
binVersion=${binVersion%%\}*}
# 有可能二进制升级成功，但是投票或版本声明失败
if [ $newVersion != $binVersion ]
then
	echo -e "\033[;31m二进制版本号{$binVersion}和提案版本号{$newVersion}不匹配，请检查！！！\033[0m"
#	exit 1
fi

# 获取链上生效版本号
cd $data_dir
result=`$bin attach ipc:platon.ipc -exec 'platon.call({"to":"0x1000000000000000000000000000000000000005","data":"0xc483820837"})'`
cd $work_dir
atVersion=`echo $result|sed 's/\"//g'`

arrParams[0]=$atVersion
arrParams[1]="\"Data\":\""
arrParams[2]="\""
arrParams[3]=1
findSubStrValue
atVersion=$g_strValue

if [ $binVersion != $atVersion ]
then
	echo -e "\033[;31m提案版本号{$binVersion}和链上生效版本号{$atVersion}不匹配，请检查！！！\033[0m"
	exit 1
fi

echo -e "\033[;32m升级提案版本验证成功==============\033[0m"
echo -e "\033[;32m开始验证节点的质押状态=============\033[0m"

# 从提案中获取节点ID
nodeID=${textVerProposal#*\"Proposer\":\"}
nodeID=${nodeID%%\"*}
#echo -e "\033[;32m获取的NodeID为：$nodeID\033[0m"

#查询当前节点的质押信息
rlpStaking=`$toolBin --funcType 1105 --nodeID $nodeID`
#echo $rlpStaking

cd $data_dir
result=`$bin attach ipc:platon.ipc -exec "platon.call({'to':'0x1000000000000000000000000000000000000002','data':'$rlpStaking'})"`
cd $work_dir
stakingInfo=`echo $result|sed 's/\"//g'`

arrParams[0]=$stakingInfo
arrParams[1]="\"Code\":"
arrParams[2]=","
arrParams[3]=1
findSubStrValue
if [ $g_strValue != 0 ]; then
	echo -e "\033[;31m获取节点质押信息失败,请检查!!!\033[0m"
	exit 1
fi

echo -e "\033[;32m获取节点质押信息成功========== \033[0m"

stakingStatus=${g_textOrigin#*\"Status\":}
stakingStatus=${stakingStatus%%,*}
#echo -e "\033[;32m质押状态：$stakingStatus\033[0m"

if [ $stakingStatus == 0 ]
then 
	echo -e "\033[;32m节点未退出验证人列表，升级版本成功，当前链生效版本为：$atVersion\033[0m"
else
	echo -e "\033[;32m节点退出验证人列表，升级版本失败，当前链生效版本为：$atVersion\033[0m"
fi

