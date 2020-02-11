#!/usr/bin/env bash

if [ -z $1 ]; then
	echo "请输入需要安装的版本号!!!"
	exit 1
fi
platon_latest=platon$1

# 安装工具 add-apt-repository
echo -e '                                                                                  (0%)'
if ! command -v add-apt-repository >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y software-properties-common
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31minstall software-properties-common failed!!! \033[0m"
        exit 1
    fi
fi

# 卸载旧版本 platon
if command -v platon >/dev/null 2>&1; then
    platon_version=$(dpkg --get-selections | grep -v deinstall  | grep platon | awk '{print $1}')
    echo -e "\033[;31mThe old version of ${platon_version} will be uninstalled and the latest version of ${platon_latest} be installed.\033[0m"
    sudo apt-get purge -y ${platon_version}
fi

# 安装新版本 platon
if ! command -v platon >/dev/null 2>&1; then
    sudo add-apt-repository ppa:ppatwo/platon && sudo apt-get update &&  sudo apt-get install -y ${platon_latest}
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31minstall platon from ppa:ppatwo/platonppa failed!!! \033[0m"
        exit 1
    fi

    # 检查安装结果
    if ! command -v platon >/dev/null 2>&1; then
        echo  -e "\033[;31mcheck platon failed!!! \033[0m"
        exit 1
    fi
    echo -e "\033[;32minstall platon from ppa:ppatwo/platonppa succeed \033[0m"
else
    echo  -e "\033[;31mPlaton has been installed!!! \033[0m"
    exit 1
fi

echo -e '#############                                                                     (15%)'
# 停止运行的 platon
platon_num=$(ps aux | grep -v grep | grep -w platon | wc -l)
if [ 0 -ne ${platon_num} ]; then
    if ! command -v killall >/dev/null 2>&1; then
        sudo apt-get install -y killall
        if [ 0 -ne $? ]; then
            echo  -e "\033[;31minstall killall failed!!! \033[0m"
            exit 1
        fi
    fi
    echo  -e "\033[;31mThe running platon process will be stopped\033[0m"
    killall -e platon
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31mstop running platon failed!!! \033[0m"
        exit 1
    fi

    # 等待 5 秒
    sleep 5
fi

# 删除旧数据
if [ -d  ~/platon-node ]; then
    if ! rm -fr ~/platon-node; then
        echo  -e "\033[;31mremove old data directory ${HOME}/platon-node failed!!! \033[0m"
        exit 1
    fi
fi

# 创建工作目录
if [ ! -d ~/platon-node/data ]; then
    if ! mkdir -p ~/platon-node/data; then
        echo  -e "\033[;31make data directory ${HOME}/platon-node/data failed!!! \033[0m"
        exit 1
    fi
fi

# 生成节点公私钥
echo -e '##########################                                                        (30%)'
if ! command -v keytool >/dev/null 2>&1; then
    echo  -e "\033[;31mcheck keytool failed!!! \033[0m"
    exit 1
fi

keytool genkeypair | tee >(grep "PrivateKey" | awk '{print $2}' > ~/platon-node/data/nodekey) >(grep "PublicKey" | awk '{print $3}' > ~/platon-node/data/nodeid)
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mgenerate key pair failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32mgenerate key pair file nodekey and nodeid in ~/platon-node/data succeed \033[0m"

# BLS公私钥
echo -e '########################################                                          (45%)'
keytool genblskeypair | tee >(grep "PrivateKey" | awk '{print $2}' > ~/platon-node/data/blskey) >(grep "PublicKey" | awk '{print $3}' > ~/platon-node/data/blspub)
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mgenerate bls key pair failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32mgenerate bls key pair file blskey and blspub in ~/platon-node/data succeed \033[0m"

# 启动节点
echo -e '###################################################                               (60%)'
nohup platon --identity platon --datadir ~/platon-node/data --port 16789 --rpc --rpcaddr 127.0.0.1 --rpcport 6789 --rpcapi platon,debug,personal,admin,net,web3,txpool --maxpeers 25 --verbosity 3 --nodekey ~/platon-node/data/nodekey --cbft.blskey ~/platon-node/data/blskey >~/platon-node/data/platon.log 2>&1 &
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mstart platon failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32mstart platon succeed \033[0m"

sleep 5

# 检查节点是否正常出块
dir=$(pwd)
cd ~/platon-node/data
for((i=1;i<=30;i++)); 
do
    temp=`expr $i \* 4`
    temp=`expr $temp / 3`
    result=`expr $temp + 60`
    echo -e "###########################################################                       ($result%)"
    block_num=$(platon attach ipc:platon.ipc -exec platon.blockNumber)
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31mplaton attach and get block number failed!!! \033[0m"
        cd ${dir}
        exit 1
    fi
    echo -e "\033[;32mblock number: $block_num \033[0m"

    # check block number
    if [ 0 -ne $block_num ]; then
        echo -e '#################################################################################(100%)'
        echo -e "\033[;32minstall platon and attach platon and get block number succeed \033[0m"
        exit 0
    fi

    sleep 1
done
cd ${dir}
echo  -e "\033[;31mplaton check block number failed!!! \033[0m"

