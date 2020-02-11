#!/usr/bin/env bash

sudo apt-get update 

# 下载 backup_task.sh 脚本
if ! command -v wget >/dev/null 2>&1; then 
    sudo apt-get -y install wget
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31minstall wget failed!!! \033[0m"
        exit 1
    fi
fi

wget http://47.91.153.183/opensource/scripts/node_back.sh -O ~/platon-node/backup_task.sh
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mwget download backup_task.sh failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32mwget download backup_task.sh succeed\n \033[0m"

# 增加可执行权限
if ! chmod +x ~/platon-node/backup_task.sh; then
    echo  -e "\033[;31madd execution permission to ${HOME}/platon-node/backup_task.sh failed!!! \033[0m"
    exit 1
fi

# 加入到 crontab
if ! command -v crontab >/dev/null 2>&1; then 
    sudo apt-get -y install crontab
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31minstall crontab failed!!! \033[0m"
        exit 1
    fi
fi

if crontab -l; then
    crontab -l > conf
fi

echo 0 0 \* \* \* ~/platon-node/backup_task.sh >> conf && crontab conf && rm -f conf
if [ 0 -ne $? ]; then
    echo  -e "\033[;31madd backup_task.sh to crontab failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32madd backup_task.sh to crontab succeed\n \033[0m"