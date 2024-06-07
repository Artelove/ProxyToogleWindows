@echo off
setlocal enabledelayedexpansion

REM Setting variables for proxy
set proxyAddress=YOUR.PROXY.IP
set proxyPort=YOUR.PORT

REM You can set your own excluded sites.
set proxyExceptions=*.local;127.0.0.1;www.youtube.com;*vk.com;

REM Getting the current proxy status
set "ProxyStatus="
for /f "tokens=3 delims= " %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>nul') do (
    set "ProxyStatus=%%a"
)

REM If ProxyStatus is not set, set the default value (0 - proxy disabled)
if not defined ProxyStatus set "ProxyStatus=0"

REM Removing spaces from ProxyStatus
set "ProxyStatus=!ProxyStatus: =!"

REM Removing 0x from ProxyStatus if present
if "!ProxyStatus:~0,2!"=="0x" set "ProxyStatus=!ProxyStatus:~2!"

REM Displaying the current proxy status
echo Current proxy status: !ProxyStatus!

REM Enabling or disabling the proxy depending on the current status
if "!ProxyStatus!"=="0" (
    echo Enabling proxy...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "%proxyAddress%:%proxyPort%" /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "%proxyExceptions%" /f
    netsh winhttp import proxy source=ie
    powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; $form = New-Object System.Windows.Forms.Form; $form.Text = 'Proxy Status'; $form.Size = New-Object System.Drawing.Size(300,200); $form.StartPosition = 'CenterScreen'; $label = New-Object System.Windows.Forms.Label; $label.Text = 'Proxy enabled.'; $label.ForeColor = 'Green'; $label.AutoSize = $true; $label.Font = New-Object System.Drawing.Font('Arial', 18); $label.Location = New-Object System.Drawing.Point(50,50); $form.Controls.Add($label); $timer = New-Object System.Windows.Forms.Timer; $timer.Interval = 400; $timer.Add_Tick({$form.Close()}); $timer.Start(); $form.ShowDialog();}"
    echo Proxy enabled.
) else (
    echo Disabling proxy...
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
    netsh winhttp reset proxy
    powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; $form = New-Object System.Windows.Forms.Form; $form.Text = 'Proxy Status'; $form.Size = New-Object System.Drawing.Size(300,200); $form.StartPosition = 'CenterScreen'; $label = New-Object System.Windows.Forms.Label; $label.Text = 'Proxy disabled.'; $label.ForeColor = 'Red'; $label.AutoSize = $true; $label.Font = New-Object System.Drawing.Font('Arial', 18); $label.Location = New-Object System.Drawing.Point(50,50); $form.Controls.Add($label); $timer = New-Object System.Windows.Forms.Timer; $timer.Interval = 400; $timer.Add_Tick({$form.Close()}); $timer.Start(); $form.ShowDialog();}"
    echo Proxy disabled.
)

endlocal
exit
