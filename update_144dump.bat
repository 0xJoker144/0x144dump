@echo off
echo ==============================================
echo [0x144dump] Atualizando o repositorio do Dump!
echo ==============================================
echo.

:: Vai para a pasta do dumper
cd /d "C:\Users\044\Downloads\cs2-dumper-main\cs2-dumper-main\output"

:: Cria a pastinha pra ficar organizado no GitHub
if not exist "meu-output" (
    mkdir meu-output
) else (
    echo Limpando pasta antiga...
    del /Q meu-output\* >nul 2>&1
)

:: Move todos os arquivos soltos q o dumper gerou para dentro da pasta meu-output
echo Buscando novos arquivos processados...
copy /Y output\*.hpp meu-output\ >nul 2>&1
copy /Y output\*.json meu-output\ >nul 2>&1
copy /Y output\*.cs meu-output\ >nul 2>&1
copy /Y output\*.rs meu-output\ >nul 2>&1
copy /Y output\*.zig meu-output\ >nul 2>&1

:: Inicia o git caso nao exista
if not exist ".git" (
    echo Iniciando o repositorio pela primeira vez...
    git init
    git branch -M main
    git remote add origin https://github.com/0xJoker144/0x144dump.git
    git config user.name "0xJoker144"
    git config user.email "0xJoker144@users.noreply.github.com"
)

:: Aborta qualquer rebase travado de antes
git rebase --abort >nul 2>&1

:: Adiciona os arquivos
echo Preparando atualizacao para o GitHub...
git add .

:: Faz o commit
echo Criando o commit...
git commit -m "Atualizando Dumps e Pastas"

:: Sobe pro GitHub forçando (para resolver o erro fetch first se você recriou o repo na mão)
echo.
echo Enviando para o GitHub (0xJoker144/0x144dump)...
git push --force origin main

echo.
echo ==============================================
echo Pronto! Dumps atualizados com sucesso na nova pasta!
echo ==============================================
pause
