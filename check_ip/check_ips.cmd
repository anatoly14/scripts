@echo off
chcp 65001 > nul 2>&1
set /p location=Enter a directory where ips.txt and log.txt files will be located: 2>nul
if "%location%"=="" (
  echo.
  echo No directory was specified. Exiting...
  timeout /t 3
  exit
)
cd /d %location%
echo Select an option:
echo If you have an ips.txt file with ips to check, enter [1]
echo If you want to enter ips manually, enter [2]
choice /c 12 /m "Your decision:"  
if %errorlevel%==1 (
  if exist ips.txt (
    goto parse
  ) else (
      echo No ips.txt file is found! Please create ips.txt file or select manual input option && timeout /t 10 && exit
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
