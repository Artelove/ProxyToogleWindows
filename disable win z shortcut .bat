@echo off

:: Create a backup of the registry
reg export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "%userprofile%\Desktop\Explorer_Advanced_Backup.reg"

:: Disable Win+Z
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisabledHotkeys /t REG_SZ /d "Z" /f

:: Refresh Explorer to apply changes
taskkill /f /im explorer.exe
start explorer.exe

echo Win+Z hotkey disabled.
pause
