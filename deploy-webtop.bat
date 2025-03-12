@echo off
REM ICC Desktop Deployment - Windows Batch Datei
REM Dieses Skript startet den PowerShell-Wrapper für Windows-Unterstützung

setlocal EnableDelayedExpansion

REM Skript-Verzeichnis ermitteln
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%"

REM Farbdefinitionen für Batch
set "RED=[91m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "BLUE=[96m"
set "NC=[0m"

REM Banner anzeigen
echo %BLUE%=================================================%NC%
echo %BLUE%  ICC Ubuntu Desktop Deployment - Windows Starter %NC%
echo %BLUE%=================================================%NC%
echo.

REM Parameter auswerten
set "ACTION=menu"
if not "%~1"=="" set "ACTION=%~1"

REM Prüfe, ob PowerShell verfügbar ist
where powershell >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo %RED%Fehler: PowerShell ist nicht installiert oder nicht im PATH.%NC%
    echo Dieses Skript benötigt PowerShell für die Ausführung.
    echo.
    echo Bitte installieren Sie PowerShell oder verwenden Sie WSL/Git Bash mit den originalen Bash-Skripten.
    exit /b 1
)

REM PowerShell-Skript ausführen
echo %GREEN%Starte PowerShell-Wrapper...%NC%
powershell -ExecutionPolicy Bypass -File "%ROOT_DIR%\deploy-webtop.ps1" -Action %ACTION%

REM Rückgabewert verarbeiten
if %ERRORLEVEL% neq 0 (
    echo %RED%Fehler bei der Ausführung des PowerShell-Skripts (Code: %ERRORLEVEL%).%NC%
    exit /b %ERRORLEVEL%
)

exit /b 0
