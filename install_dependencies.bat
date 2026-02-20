@echo off
chcp 65001 >nul
set PYTHONIOENCODING=utf-8

echo Installing nanobot dependencies...
echo.

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is not installed or not in PATH.
    echo Please install Python first.
    pause
    exit /b 1
)

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip

REM Install nanobot in editable mode with all dependencies
echo.
echo Installing nanobot and dependencies...
pip install -e .

if errorlevel 1 (
    echo.
    echo Error: Installation failed.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Installation completed successfully!
echo ========================================
echo.
echo You can now run: run_nanobot.bat agent
echo.
pause
