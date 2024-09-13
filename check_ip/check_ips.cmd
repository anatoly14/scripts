@echo off
@chcp 65001
set /p ScriptLocation=Define a directory where cmd script is located:
cd %ScriptLocation%
set /p Choise=Enter 0 if you use ips.txt. Enter 1 if you want to enter ips manually:
if "%Choise%"=="0" goto endend
@echo Enter values (one per line), then type "done" on a blank line to finish:
:loop
set /p IpAddr=
if /i "%IpAddr%"=="done" goto end
echo address %IpAddr% is added
echo %IpAddr% >> temp.txt
goto loop
:end
for /F "delims=" %%i in (temp.txt) do (
@echo TIMESTAMP is %date% %time% >> log.txt
@echo HOST is %%i >> log.txt
@ping %%i -w 1000 > nul 2>&1 && (@echo %%i is reachable >> log.txt) || (@echo %%i is unreachable >> log.txt)
@echo. >> log.txt
)
del temp.txt
exit
:endend
for /F "skip=1" %%i in (ips.txt) do (
@echo TIMESTAMP is %date% %time% >> log.txt
@echo HOST is %%i >> log.txt
@ping %%i -w 1000 > nul 2>&1 && (@echo %%i is reachable >> log.txt) || (@echo %%i is unreachable >> log.txt)
@echo. >> log.txt
)