#!/bin/bash

# 验证(ppos)交易是否成功
# 查询交易回执
cd ~/platon-node/data
tx_receipt=`platon attach ipc:platon.ipc -exec "platon.getTransactionReceipt('$1')"`
if [ 0 -ne $? ]; then
    echo -e "\033[;31m获取交易回执失败!!! \033[0m"
    exit 1
fi 

echo -e "\033[;32m获取交易回执成功========== \033[0m"
echo -e "\033[;32m解析交易回执中========== \033[0m"
# 获取data中的值
right=${tx_receipt#*logs:}
data=${right#*data:}
data=${data#*\"}

# 获取交易的code
code=${data%%\"*}
#echo -e "\033[;32m交易回执中的code值：$code\033[0m"

# 获取二进制版本
result=`platon attach ipc:platon.ipc -exec 'admin.getProgramVersion()'`
result=`echo $result|sed 's/\ //g'`
#echo $result
binVersion=${result#*Version:}
binVersion=${binVersion%%\}*}
if [[ $binVersion -le 1795 ]] || [[ $binVersion -eq 2048 ]]
then
	# 判断版本号：0.7.3之前的(1795)和0.8.0(2048)走老版本
	# 十六进制字符串转换成文本字符串
	length=`echo $code|wc -L`
	textData=""
	string=$code
	# 从0x后面的字符串开始转换
	for (( i = 1; i < $length/2; i++)); do
		tmp='\x'${string:$(($i*2)):2}
		textData=$textData$tmp
	done
	
	textData=`echo -e $textData|sed 's/\\\//g'`
	
	code=${textData#*\"Code\":}
	code=${code%%,*}
	if [ $code -eq 0 ] 
	then
		echo -e "\033[;32m交易成功！！！\033[0m"
	else
		echo -e "\033[;31m交易失败！！！\033[0m"
	fi
#	exit 1
else
	# 0xc130：0的rlp值
	if [ $code == '0xc130' ] 
	then
		echo -e "\033[;32m交易成功！！！\033[0m"
	else
		echo -e "\033[;31m交易失败！！！\033[0m"
	fi
fi
