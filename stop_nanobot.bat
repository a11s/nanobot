@echo off
chcp 65001 >nul
echo 正在停止 nanobot 进程...
echo.

REM 查找并停止所有运行 nanobot 的 Python 进程
for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq python.exe" /FO LIST ^| findstr /C:"PID:"') do (
    wmic process where "ProcessId=%%i" get CommandLine 2>nul | findstr /C:"nanobot" >nul
    if not errorlevel 1 (
        echo 找到 nanobot 进程 PID: %%i
        taskkill /F /PID %%i >nul 2>&1
        if not errorlevel 1 (
            echo ✓ 已停止进程 %%i
        )
    )
)

echo.
echo 完成！
pause
