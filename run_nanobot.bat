@echo off
chcp 65001 >nul
set PYTHONIOENCODING=utf-8

REM Check if dependencies are installed
python -c "import prompt_toolkit" 2>nul
if errorlevel 1 (
    echo Error: Dependencies not installed.
    echo Please run: pip install -e .
    exit /b 1
)

python -m nanobot %*
