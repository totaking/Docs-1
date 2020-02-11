#!/bin/bash
rpc_port=6789

# 查询提案列表
result=`platon attach http://localhost:$rpc_port -exec 'platon.call({"to":"0x1000000000000000000000000000000000000005","data":"0xc483820836"})'`
listProposal=`echo $result|sed 's/\"//g'`
#echo $listProposal

# 十六进制字符串转换成文本字符串
lenth=`expr length $listProposal`
printstr=""
string=$listProposal
# 从0x后面的字符串开始转换
for (( i = 1; i < $lenth/2; i++)); do
tmp='\x'${string:$(($i*2)):2}
printstr=$printstr$tmp
done

# n:不换行输出; e:处理特殊字符
ret=`echo $printstr | grep '\"ProposalType\":2'`
echo -en $ret
