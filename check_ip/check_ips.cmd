@echo off
chcp 65001 > nul 2>&1
set location=
set /p location=Enter a directory where ips.txt and log.txt files will be located: 2>nul
if "%location%"=="" (
  echo No directory was specified. Exiting...
  exit /b
)
cd /d %location%
:menu
echo.
echo ======================
echo Select an option:
echo ips.txt [1]
echo manual [2]
echo manual by ip range [3]
echo remove ips.txt [4]
echo remove log.txt [5]
echo exit [6]
echo ======================
echo.
choice /c 123456 /n /m "Your decision: "  
if %errorlevel% == 1 (
  if exist ips.txt (
    goto parse
  ) else (
      echo No ips.txt file is found! Please create ips.txt file or select manual input option.
      goto menu
    )
)
if %errorlevel% == 4 (
  if exist ips.txt (
    del /p ips.txt
    ) else (
    echo No ips.txt is found in location %location%
  )
  goto menu
)
if %errorlevel% == 5 (
  if exist log.txt (
    del /p log.txt
  ) else (
    echo No log.txt in location %location%
  )
  goto menu
)
if %errorlevel% == 6 exit /b
echo Enter values (one per line), then type "done" on a blank line to finish:
:setip
set /p ipaddr=
if /i "%ipaddr%"=="done" goto parse
echo address %ipaddr% is added
echo %ipaddr% >> ips.txt
goto setip
:parse
for /f %%i in (ips.txt) do (
echo TIMESTAMP is %date% %time% >> log.txt
echo HOST is %%i >> log.txt
ping %%i -w 1000 | find "TTL" > nul
if not errorlevel 1 (
  echo Host %%i is reachable >> log.txt
  ) else echo Host %%i is unreachable >> log.txt
echo. >> log.txt
)
