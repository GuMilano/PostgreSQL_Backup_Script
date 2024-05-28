@echo off
chcp 65001 > nul
setlocal

REM Obter data e hora atual para adicionar ao nome do arquivo de backup
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "dt=%%I"
set "data=%dt:~0,4%%dt:~4,2%%dt:~6,2%_%dt:~8,2%%dt:~10,2%%dt:~12,2%"

REM Caminho para o executável pg_dump.exe
set "pg_dump=C:\Program Files\PostgreSQL\15\bin\pg_dump.exe"

REM Nome do banco de dados PostgreSQL
set "dbname="

REM Caminho completo para a pasta de backup
set "backup_folder="

REM Caminho completo para o arquivo de backup
set "backup_file=%backup_folder%\%dbname%_%data%.sql"

REM Senha do usuário postgres (substitua pela sua senha)
set "PGPASSWORD="

REM Verifica se a pasta de backup existe, se não, cria-a
if not exist "%backup_folder%" mkdir "%backup_folder%"

REM Comando para realizar o backup diretamente no servidor PostgreSQL
"%pg_dump%" -h localhost -U postgres -w -F c %dbname% > "%backup_file%"

echo Backup concluído em %backup_file%

endlocal
