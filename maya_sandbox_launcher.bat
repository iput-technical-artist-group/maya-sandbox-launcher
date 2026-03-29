:: Maya Sandbox Launcher
:: Core logic managed on GitHub
:: Edit this file to apply changes across all client PCs
@echo off
setlocal

set "AUTODESK_DIR=C:\Program Files\Autodesk"
set "SANDBOX_DIR=%USERPROFILE%\sandbox"
set "MAYA_EXE="

:: Search for the latest Maya version
for /f "delims=" %%D in ('dir /b /ad "%AUTODESK_DIR%\Maya20*" 2^>nul ^| sort /r') do (
    if not defined MAYA_EXE (
        if exist "%AUTODESK_DIR%\%%D\bin\maya.exe" (
            set "MAYA_EXE=%AUTODESK_DIR%\%%D\bin\maya.exe"
        )
    )
)

if not defined MAYA_EXE (
    echo [ERROR] Maya not found.
    pause
    exit /b 1
)

echo [INFO] Maya: %MAYA_EXE%
echo [INFO] Sandbox: %SANDBOX_DIR%

:: Kill any running Maya instances
tasklist /fi "imagename eq maya.exe" 2>nul | find /i "maya.exe" >nul
if not errorlevel 1 (
    echo [INFO] Terminating running Maya process...
    taskkill /f /im maya.exe >nul 2>&1
)

:: Wait until Maya process is fully terminated
:wait_kill
tasklist /fi "imagename eq maya.exe" 2>nul | find /i "maya.exe" >nul
if not errorlevel 1 (
    timeout /t 1 /nobreak >nul
    goto wait_kill
)

:: Reset sandbox directory
if exist "%SANDBOX_DIR%" rmdir /s /q "%SANDBOX_DIR%"
mkdir "%SANDBOX_DIR%"
mkdir "%SANDBOX_DIR%\scripts"
mkdir "%SANDBOX_DIR%\prefs"
mkdir "%SANDBOX_DIR%\shelves"
mkdir "%SANDBOX_DIR%\plug-ins"
mkdir "%SANDBOX_DIR%\modules"

:: Override environment variables with sandbox paths
set "MAYA_APP_DIR=%SANDBOX_DIR%"
set "PYTHONPATH=%SANDBOX_DIR%\scripts"
set "MAYA_SCRIPT_PATH=%SANDBOX_DIR%\scripts"
set "MAYA_PLUG_IN_PATH=%SANDBOX_DIR%\plug-ins"
set "MAYA_MODULE_PATH=%SANDBOX_DIR%\modules"
set "XBMLANGPATH=%SANDBOX_DIR%\prefs"
set "MAYA_SHELF_PATH=%SANDBOX_DIR%\shelves"
set "MAYA_PRESET_PATH=%SANDBOX_DIR%\prefs"

:: Launch Maya before endlocal so it inherits the sandbox environment variables
start "" "%MAYA_EXE%"

endlocal
