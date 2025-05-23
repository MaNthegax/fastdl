@echo off
REM Ensures variables set within the batch file are local to
REM this script only and will be removed when finished.
setlocal

REM Altere o caminho abaixo para a pasta onde o script deve começar
cd /D "%~dp0\cs16"

REM Compacta todos os arquivos recursivamente, exceto .gz e .cmd
for /r %%X in (*) do (
    REM Pula arquivos com extensão .gz ou .cmd
    if /I not "%%~xX"==".gz" if /I not "%%~xX"==".cmd" (
        REM Verifica se é um arquivo (não diretório)
        if exist "%%X" (
            set "gzPath=%%X.gz"
            REM Verifica se o arquivo .gz ainda não existe
            if not exist "!gzPath!" (
                echo Compactando: %%X
                "C:\Program Files\7-Zip\7z.exe" a -tgzip "!gzPath!" "%%X" >nul
            ) else (
                echo Já compactado, ignorando: %%X
            )
        )
    )
)

echo.
echo Operação finalizada.
pause

