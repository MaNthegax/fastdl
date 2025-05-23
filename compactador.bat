@echo off
setlocal enabledelayedexpansion

REM Caminho do 7-Zip
set "compressor=C:\Program Files\7-Zip\7z.exe"

REM Extensão a ser gerada (.gz por padrão)
set "extension=gz"

REM Verifica se o 7-Zip existe
if not exist "%compressor%" (
    echo [ERRO] 7-Zip nao encontrado em: %compressor%
    pause
    exit /b
)

REM Define o diretório inicial como a subpasta \cs16 do .bat
cd /D "%~dp0\cs16"

echo Iniciando compactacao recursiva em: %CD%
echo Usando compressor: %compressor%
echo.

REM Compacta todos os arquivos recursivamente, exceto .gz e .cmd
for /r %%X in (*) do (
    REM Extensao atual do arquivo
    set "ext=%%~xX"
    
    REM Ignora arquivos .gz e .cmd
    if /I not "!ext!"==".%extension%" if /I not "!ext!"==".cmd" (
        REM Define o arquivo .gz de destino
        set "gzFile=%%X.%extension%"

        REM Só compacta se o arquivo .gz ainda não existir
        if not exist "!gzFile!" (
            echo Compactando: %%X
            "%compressor%" a -tgzip "!gzFile!" "%%X" >nul
        ) else (
            echo Ja existe: !gzFile!
        )
    )
)

echo.
echo Compactacao finalizada.
pause
