@echo off
set "LOCAL_VERSION=1.0.0"

:: Start

if "%~1"=="check_launcher_update" (
    call :check_github soft
    exit /b
)

:: Check GitHub

:check_github
chcp 437 > nul
cls

:: Latest Version and URLs

set "GITHUB_VERSION_URL=https://raw.githubusercontent.com/ShrikerChestTrees/Minecraft-Pixel/main/.launcher/version.txt"
set "GITHUB_RELEASE_URL=https://github.com/ShrikerChestTrees/Minecraft-Pixel/releases/tag/launcher-"
set "GITHUB_DOWNLOAD_URL=https://github.com/ShrikerChestTrees/Minecraft-Pixel/releases/latest/download/launcher-"

:: Get Latest Version from GitHub
for /f "delims=" %%A in ('powershell -command "(Invoke-WebRequest -Uri \"%GITHUB_VERSION_URL%\" -Headers @{\"Cache-Control\"=\"no-cache\"} -TimeoutSec 5).Content.Trim()" 2^>nul') do set "GITHUB_VERSION=%%A"

:: ERROR
if not defined GITHUB_VERSION (
    echo !!!WARNING!!! Failed fetch Latest version. Check your Internet Connection!
    pause
    if "%1"=="soft" exit /b 
    goto menu
)

:: Version Comparison
if "%LOCAL_VERSION%"=="%GITHUB_VERSION%" (
    echo Latest version Installed: %LOCAL_VERSION%
    
    if "%1"=="soft" exit /b
    pause
    goto menu
)

echo New version Available: %GITHUB_VERSION%
echo Page: %GITHUB_RELEASE_URL%%GITHUB_VERSION%

:: Choice

set "CHOICE="
set /p "CHOICE=Do you want auto-download new version? (Y/N) (Default: Y) "
if "%CHOICE%"=="" set "CHOICE=Y"
if /i "%CHOICE%"=="y" set "CHOICE=Y"

if /i "%CHOICE%"=="Y" (
    echo Loading...
    start "" "%GITHUB_DOWNLOAD_URL%%GITHUB_VERSION%.rar"
)


if "%1"=="soft" exit /b
pause
goto menu
