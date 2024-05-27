Конечно, вот код с переводом на английском языке рядом:

```batch
@echo off
setlocal enabledelayedexpansion

REM Установка переменных для прокси
REM Setting variables for proxy
set proxyAddress=YOUR.PROXY.IP
set proxyPort=YOUR.PORT

REM Можно установить свои исключаемые сайты.
REM You can set your own excluded sites.
set proxyExceptions=*.local;127.0.0.1;www.youtube.com;*vk.com;*telegram*

REM Получение текущего состояния прокси
REM Getting the current proxy status
set "ProxyStatus="
for /f "tokens=3 delims= " %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>nul') do (
    set "ProxyStatus=%%a"
)

REM Если ProxyStatus не установлен, установить значение по умолчанию (0 - прокси отключен)
REM If ProxyStatus is not set, set the default value (0 - proxy disabled)
if not defined ProxyStatus set "ProxyStatus=0"

REM Удаление пробелов из ProxyStatus
REM Removing spaces from ProxyStatus
set "ProxyStatus=!ProxyStatus: =!"

REM Удаление 0x из ProxyStatus, если присутствует
REM Removing 0x from ProxyStatus if present
if "!ProxyStatus:~0,2!"=="0x" set "ProxyStatus=!ProxyStatus:~2!"

REM Отображение текущего состояния прокси
REM Displaying the current proxy status
echo Current proxy status: !ProxyStatus!

REM Включение или отключение прокси в зависимости от текущего состояния
REM Enabling or disabling the proxy depending on the current status
if "!ProxyStatus!"=="0" (
    echo Enabling proxy...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "%proxyAddress%:%proxyPort%" /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "%proxyExceptions%" /f
    netsh winhttp import proxy source=ie
    echo Proxy enabled.
) else (
    echo Disabling proxy...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
    netsh winhttp reset proxy
    echo Proxy disabled.
)

endlocal
exit
```
