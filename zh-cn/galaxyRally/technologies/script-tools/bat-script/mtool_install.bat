@echo off

rem  安装 choco
where choco 
if not %ERRORLEVEL% == 0 (
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
    call RefreshEnv.cmd
)

rem 安装 mtool
where mtool-client.bat 
if NOT %ERRORLEVEL% == 0 (
    choco install -y platon_mtool_all --version=0.7.4
    setx "MTOOLDIR"  "C:\tools\mtool\current"
    call RefreshEnv.cmd
) else (
    echo The install of platon_mtool was successful
)

rem 修改 mysql 密码
mysql -uroot -p -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';"
if not %ERRORLEVEL% == 0 (
    echo set password for mysql failed!!!
    goto fail
)

rem 创建库 mtool
mysql -uroot -p123456 -e "CREATE DATABASE IF NOT EXISTS mtool;"
if not %ERRORLEVEL% == 0 (
    echo create database mtool failed!!!
    goto fail
)

rem 启动  mtool-server.bat
start /min mtool-server.bat
if not %ERRORLEVEL% == 0 (
    echo start mtool-server.bat failed!!!
    goto fail
)

echo install and start mtool success

:fail
pause