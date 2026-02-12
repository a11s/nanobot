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
echo 实时监控日志: %LOG_FILE%
echo 按 Ctrl+C 退出
echo.
echo ========================================
echo.

REM 使用 PowerShell 实现 tail -f 功能，支持 UTF-8
powershell -NoProfile -Command "Get-Content -Path '%LOG_FILE%' -Encoding UTF8 -Wait -Tail 20"
