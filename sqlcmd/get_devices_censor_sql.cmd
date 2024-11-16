@echo off
chcp 65001 > nul 2>&1
for /f "delims=" %%i in ('where sqlcmd 2^>nul') do set sqlcmd_location=%%i
if not defined sqlcmd_location (
  echo Ошибка! Программа sqlcmd не найдена...
  timeout 30
) else (
    echo Расположение sqlcmd -- %sqlcmd_location%
  )
@REM Необходимо задать путь к sql файлу или текстовый запрос
@REM Пример 1: set query="D:\1.sql" Пример 2: set query="select @@version"
@REM Задавать внутри ""
set query=
if not defined query echo Не задан путь к sql файлу && timeout 30

@REM Необходимо указать имя БД
@REM Пример 1: set db="database"
@REM Задавать внутри ""
set db=
if not defined db echo Не задано имя БД && timeout 30 

@REM Если sql запрос не из файла, то заменить -i на -Q
echo Попытка подключения к БД %db% и выполнения %query%
sqlcmd -d %db% -i %query% -l 10 -t 30 -f 65001 -o "output.csv" -s "|" -W -b
if %errorlevel% neq 0 echo Ошибка! Подробнее в output.csv
timeout 30
