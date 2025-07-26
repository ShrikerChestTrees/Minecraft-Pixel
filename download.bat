@echo off
set "LOCAL_VERSION=1.0.0"

if "%~1"=="check_updates" (
    call :service_check_updates soft
    exit /b
)
