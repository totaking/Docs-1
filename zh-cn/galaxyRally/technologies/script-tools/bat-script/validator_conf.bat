@echo off

rem 获取节点 ip 地址
set /p hostip=Please enter the platon node IP address:
if not %ERRORLEVEL% == 0 (
    echo get the platon node IP failed!!!
    goto fail
)

rem 获取链 id
set /p chainid=Please enter the platon chain id:
if not %ERRORLEVEL% == 0 (
    echo get the platon chain id failed!!!
    goto fail
)

rem 获取用户名
set /p username=Enter your name:
if not %ERRORLEVEL% == 0 (
    echo get http user name failed!!!
    goto fail
)

rem 获取密码
set /p password=Enter your password:
if not %ERRORLEVEL% == 0 (
    echo get http user password failed!!!
    goto fail
)

rem 获取节点名称
set /p nodename=Enter your platon node name:
if not %ERRORLEVEL% == 0 (
    echo get the platon node name failed!!!
    goto fail
)

rem 获取节点描述
set /p nodedescription=Enter your platon node description:
if not %ERRORLEVEL% == 0 (
    echo get the platon node description failed!!!
    goto fail
)

rem 安装 curl
where curl
if NOT %ERRORLEVEL% == 0 (
    choco install -y curl
)

rem 安装 awk
where awk
if NOT %ERRORLEVEL% == 0 (
    choco install -y awk
)

rem 安装 sed
where sed
if NOT %ERRORLEVEL% == 0 (
    choco install -y sed
)

rem 刷新加载最新环境变量
call RefreshEnv.cmd

rem 下载证书
curl -o C:\tools\mtool\current\ca.crt -u %username%:%password% -k https://%hostip%/file/ca.crt 
if not %ERRORLEVEL% == 0 (
    echo get ca.crt failed!!!
    goto fail
)
echo get ca.crt success

rem 修改 host
echo %hostip%  domain3 >> C:\Windows\System32\drivers\etc\hosts

rem 下载 validator_config.json
curl -o C:\tools\mtool\current\validator\validator_config.json -u %username%:%password% -k https://%hostip%/file/validator_config.json 
if not %ERRORLEVEL% == 0 (
    echo get validator_config.json failed!!!
    goto fail
)
echo get validator_config.json success

rem 修改配置 nodeAddress
sed -i "s/127\.0\.0\.1/domain3/g" C:\tools\mtool\current\validator\validator_config.json
if not %ERRORLEVEL% == 0 (
    echo modify nodeAddress failed!!!
    goto fail
)

rem 修改链 id
sed -i "s/Chain_Id/%chainid%/g" C:\tools\mtool\current\validator\validator_config.json
if not %ERRORLEVEL% == 0 (
    echo modify chain id failed!!!
    goto fail
)

rem 获取 reward wallet address
for /f "usebackq" %%s in (`awk -F "[:,]" "{print $2}" C:\tools\mtool\current\keystore\reward.json`) do set str=%%s
if not %ERRORLEVEL% == 0 (
    echo get reward wallet address failed!!!
    goto fail
)

for /f "usebackq" %%s in (`echo %str%^|sed "s/^.//g"^|sed "s/.$//g"`) do set result=%%s
if not %ERRORLEVEL% == 0 (
    echo get reward wallet address failed!!!
    goto fail
)

rem 修改 收益钱包地址
set result=0x%result%
sed -i "s/rewardWalletAddress/%result%/g" C:\tools\mtool\current\validator\validator_config.json
if not %ERRORLEVEL% == 0 (
    echo modify reward wallet address failed!!!
    goto fail
)

rem 修改节点名称
sed -i "s/MyNodeName/%nodename%/g" C:\tools\mtool\current\validator\validator_config.json
if not %ERRORLEVEL% == 0 (
    echo modify platon node name failed!!!
    goto fail
)

rem 修改节点描述
sed -i "s/MyNodeDescription/%nodedescription%/g" C:\tools\mtool\current\validator\validator_config.json
if not %ERRORLEVEL% == 0 (
    echo modify platon node description failed!!!
    goto fail
)

echo validator conf success

:fail
pause