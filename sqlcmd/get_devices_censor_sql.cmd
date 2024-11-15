@echo off
chcp 65001 > nul 2>&1
for /f "delims=" %%i in ('where sqlcmd 2^>nul') do set sqlcmd_location=%%i
if not defined sqlcmd_location (
  echo Ошибка! Программа sqlcmd не найдена...
  timeout 60
) else (
    echo Расположение sqlcmd -- %sqlcmd_location%
  )
set query="SELECT * FROM HR.Employees"
set db="TSQL2012"
echo Подключение к БД %db%
echo Выполняем скрипт %query%
sqlcmd -d %db% -Q %query% > 1.txt
timeout