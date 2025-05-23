@echo off
REM Ensures variables set within the batch file are local to
REM this script only and will be removed when finished.
setlocal

REM Altere o caminho abaixo para a pasta onde o script deve começar
cd /D "%~dp0\cs16"

REM Compacta todos os arquivos recursivamente, ignorando .gz, .cmd e pastas
for /r %%X in (*) do (
    REM Verifica se NÃO é um arquivo .gz ou .cmd
    if /I not "%%~xX"==".gz" if /I not "%%~xX"==".cmd" (
        REM Verifica se é um arquivo (não uma pasta)
        if exist "%%X" (
            echo Compactando: %%X
            "C:\Program Files\7-Zip\7z.exe" a -tgzip "%%X.gz" "%%X" >nul
            if exist "%%X.gz" (
                echo Excluindo original: %%X
                del "%%X"
            )
        )
    )
)

echo.
echo Operação finalizada.
pause

