@echo off
chcp 65001 > nul 2>&1
set /p location=Enter a directory where ips.txt and log.txt files will be located:
cd %location%
set /p choice=Enter 0 if you use ips.txt. Enter 1 if you want to enter ips manually:
if "%choice%"=="0" (
  if exist ips.txt (
    goto parse
  ) else (
      echo No ips.txt file is found! Please create ips.txt file or select manual input option && exit
    )
)
@echo Enter values (one per line), then type "done" on a blank line to finish:
:setip
set /p ipaddr=
if /i "%ipaddr%"=="done" goto parse
echo address %ipaddr% is added
echo %ipaddr% >> ips.txt
goto setip
:parse
for /f %%i in (ips.txt) do (
@echo TIMESTAMP is %date% %time% >> log.txt
@echo HOST is %%i >> log.txt
@ping %%i -w 1000 > nul 2>&1 && (@echo %%i is reachable >> log.txt) || (@echo %%i is unreachable >> log.txt)
@echo. >> log.txt
)