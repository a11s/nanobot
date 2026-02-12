@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set LOG_DIR=C:\Users\a11s\AppData\Local\Temp\claude\d--nanobot\tasks

echo 正在查找最新的日志文件...
echo.

REM 找到最新的 .output 文件
set "LATEST_LOG="
for /f "delims=" %%f in ('dir /b /o-d "%LOG_DIR%\*.output" 2^>nul') do (
    if not defined LATEST_LOG set "LATEST_LOG=%%f"
)

if not defined LATEST_LOG (
    echo 未找到日志文件！
    pause
    exit /b 1
)

set "LOG_FILE=%LOG_DIR%\%LATEST_LOG%"
echo 日志文件: %LOG_FILE%
echo.
echo ========================================
echo.

REM 使用 PowerShell 读取 UTF-8 编码的文件
powershell -NoProfile -Command "Get-Content -Path '%LOG_FILE%' -Encoding UTF8"

echo.
echo ========================================
echo.
pause
