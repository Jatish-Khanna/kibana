@echo off

SETLOCAL

set SCRIPT_DIR=%~dp0
for %%I in ("%SCRIPT_DIR%..") do set DIR=%%~dpfI

set NODE=%DIR%\node\node.exe

WHERE /Q node
IF %ERRORLEVEL% EQU 0 (
  for /f "delims=" %%i in ('WHERE node') do set SYS_NODE=%%i
)

If Not Exist "%NODE%" (
  IF Exist "%SYS_NODE%" (
    set "NODE=%SYS_NODE%"
  ) else (
    Echo unable to find usable node.js executable.
    Exit /B 1
  )
)

echo.%* | findstr /V /C:"--dev" && set NODE_OPTIONS=--max-old-space-size=256 %NODE_OPTIONS%

TITLE Kibana Server
call "%NODE%" %NODE_OPTIONS% "%DIR%\src\cli" %*

:finally

ENDLOCAL
