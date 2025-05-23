@echo off
REM Ensures variables set within the batch file are local to
REM this script only and will be removed when finished.
setlocal

REM Altere o caminho abaixo para a pasta onde o script deve começar
cd /D "%~dp0\cs16"

if exist *.gz goto zip_exist

for /r %%X in (*) do (
    REM Verifica se é um arquivo, não uma pasta
    if not "%%~aX"=="d" (
        cls
        REM Compacta arquivos
        "c:\Program Files\7-Zip\7z.exe" a -r -x!*.gz -x!*.cmd "%%X.gz" "%%X"
        if exist "%%X.gz" (
            echo Excluindo original: %%X
            del "%%X"
        )
    )
)
goto end

:zip_exist
Echo.
Echo Note: for this script to work, compression of
Echo pre-existing zip files is not possible.

:end
pause