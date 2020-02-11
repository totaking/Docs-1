#!/usr/bin/env bash

sudo apt-get update 

#  安装 ngnix
echo -e '###########                                                                        (10%)'
if ! command -v nginx >/dev/null 2>&1; then 
    sudo apt-get -y install nginx
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31minstall nginx failed!!! \033[0m"
        exit 1
    fi
fi
echo -e "\033[;32minstall nginx succeed \033[0m"

# 安装 openssl
echo -e '####################                                                               (20%)'
if ! command -v openssl >/dev/null 2>&1; then 
    sudo apt-get -y install openssl
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31minstall openssl failed!!! \033[0m"
        exit 1
    fi
fi
echo -e "\033[;32minstall openssl succeed \033[0m"

# 生成自签名证书
echo -e '###########################                                                        (30%)'
dir=$(pwd)
cd /etc/nginx/conf.d
sudo openssl genrsa -out ca.key 4096 && sudo openssl req -new -x509 -days 365 -key ca.key -out ca.crt -subj "/C=CN/ST=mykey/L=mykey/O=mykey/OU=mykey/CN=domain1/CN=domain2/CN=domain3"
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mgenerate ca certificate failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32mgenerate ca certificate succeed \033[0m"

echo -e '####################################                                               (45%)'
sudo openssl genrsa -out server.key 4096 && sudo openssl req -new -key server.key -out server.csr -subj "/C=CN/ST=mykey/L=mykey/O=mykey/OU=mykey/CN=domain1/CN=domain2/CN=domain3"
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mgenerate server certificate failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32mgenerate server certificate succeed \033[0m"

echo -e '#############################################                                      (60%)'
sudo openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
if [ 0 -ne $? ]; then
    echo  -e "\033[;31msignature server certificate failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32msignature server certificate succeed \033[0m"

# 拷贝 ca 证书
if [ ! -d ~/platon-node/file ]; then
    mkdir -p ~/platon-node/file
fi

if ! cp /etc/nginx/conf.d/ca.crt ~/platon-node/file/; then
    echo  -e "\033[;31mcopy ca.crt failed!!! \033[0m"
    exit 1
fi

# 创建用户密码
echo -e '#########################################################                          (75%)'
if ! command -v htpasswd >/dev/null 2>&1; then 
    sudo apt-get -y install apache2-utils
    if [ 0 -ne $? ]; then
        echo  -e "\033[;31minstall apache2-utils failed!!! \033[0m"
        exit 1
    fi
fi

echo "please input ngnix username and password"
read -p "Enter your name:" name
read -p "Enter your password:" password

sudo htpasswd -bc /etc/nginx/conf.d/platonpasswd ${name} ${password}
if [ 0 -ne $? ]; then
    echo  -e "\033[;31m generate user and password file /etc/nginx/conf.d/platonpasswd failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32mgenerate user and password file /etc/nginx/conf.d/platonpasswd succeed \033[0m"

# 获取节点公钥
nodeid=$(cat ~/platon-node/data/nodeid)
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mget node public key failed!!! \033[0m"
    exit 1
fi

# 获取 bls 公钥
blsPubKey=$(cat ~/platon-node/data/blspub)
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mget bls public key failed!!! \033[0m"
    exit 1
fi

# 生成 validator_config.json
cat>~/platon-node/file/validator_config.json<<EOF
{
  "chainId": "Chain_Id",
  "nodePublicKey": "${nodeid}",
  "blsPubKey": "${blsPubKey}",
  "benefitAddress": "rewardWalletAddress",
  "nodeAddress": "https://${name}:${password}@127.0.0.1",
  "nodePort": "16789",
  "nodeRpcPort": "443",
  "nodeName": "MyNodeName",
  "details": "MyNodeDescription",
  "externalId": "MyKeyBaseId",
  "webSite": "http://www.mycompany.com",
  "certificate": "C:/tools/mtool/current/ca.crt"
}
EOF

if [ 0 -ne $? ]; then
    echo  -e "\033[;31mgenerate validator_config.json failed!!! \033[0m"
    exit 1
fi

# 生成 ngnix 配置文件
echo -e '#######################################################################            (90%)'
filename="/etc/nginx/conf.d/platon.conf"
if [ ! -f ${filename} ]; then
    sudo touch ${filename}
fi

sudo sh -c "cat>${filename}<<EOF
server {
    listen 443 ssl;                # 监听443端口, 开启ssl(必须)
    server_name 0.0.0.0;

    ssl_certificate      /etc/nginx/conf.d/server.crt;
    ssl_certificate_key  /etc/nginx/conf.d/server.key;

    location / {
        proxy_pass http://127.0.0.1:6789;                     # platon http rpc 接口地址
        auth_basic \"input password\";                        # 这里是提示信息
        auth_basic_user_file /etc/nginx/conf.d/platonpasswd;  # 这里填写刚才生成的密码文件路径
    }

    location /file {
        auth_basic \"input password\";                        # 这里是提示信息
        auth_basic_user_file /etc/nginx/conf.d/platonpasswd;  # 这里填写刚才生成的密码文件路径
        root ~/platon-node; # 存放文件的目录
        autoindex on;
        autoindex_exact_size on; # 显示文件大小
        autoindex_localtime on; # 显示文件时间
   }
}
EOF"
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mgenerate nginx config file /etc/nginx/conf.d/platon.conf failed!!! \033[0m"
    exit 1
fi
echo -e "\033[;32mgenerate nginx config file /etc/nginx/conf.d/platon.conf succeed \033[0m"

# 重启 ngnix
echo -e '###################################################################################(100%)'
sudo nginx -s reload
if [ 0 -ne $? ]; then
    echo  -e "\033[;31mnginx reload config failed!!! \033[0m"
    exit 1
fi

echo -e "\033[;32mngnix conf succeed \033[0m"

