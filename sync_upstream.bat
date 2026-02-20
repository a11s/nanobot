@echo off
chcp 65001 >nul
set PYTHONIOENCODING=utf-8

echo ========================================
echo Syncing with upstream repository
echo ========================================
echo.

REM Check if we're in a git repository
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo Error: Not a git repository.
    pause
    exit /b 1
)

REM Check if upstream remote exists
git remote get-url upstream >nul 2>&1
if errorlevel 1 (
    echo Error: Upstream remote not configured.
    echo Please run: git remote add upstream https://github.com/HKUDS/nanobot.git
    pause
    exit /b 1
)

REM Save current branch
for /f "tokens=*" %%i in ('git branch --show-current') do set CURRENT_BRANCH=%%i
echo Current branch: %CURRENT_BRANCH%
echo.

REM Fetch from upstream
echo Fetching from upstream...
git fetch upstream
if errorlevel 1 (
    echo Error: Failed to fetch from upstream.
    pause
    exit /b 1
)
echo.

REM Switch to main branch
echo Switching to main branch...
git checkout main
if errorlevel 1 (
    echo Error: Failed to checkout main branch.
    pause
    exit /b 1
)
echo.

REM Merge upstream/main into local main
echo Merging upstream/main into local main...
git merge upstream/main
if errorlevel 1 (
    echo.
    echo Error: Merge conflict detected.
    echo Please resolve conflicts manually and run:
    echo   git merge --continue
    echo   git push origin main
    pause
    exit /b 1
)
echo.

REM Push to origin
echo Pushing to origin...
git push origin main
if errorlevel 1 (
    echo Error: Failed to push to origin.
    pause
    exit /b 1
)
echo.

REM Switch back to original branch if it wasn't main
if not "%CURRENT_BRANCH%"=="main" (
    echo Switching back to %CURRENT_BRANCH%...
    git checkout %CURRENT_BRANCH%
    echo.
    echo Do you want to rebase %CURRENT_BRANCH% on top of updated main? (Y/N)
    set /p REBASE_CHOICE=
    if /i "%REBASE_CHOICE%"=="Y" (
        echo Rebasing %CURRENT_BRANCH% on main...
        git rebase main
        if errorlevel 1 (
            echo.
            echo Error: Rebase conflict detected.
            echo Please resolve conflicts manually and run:
            echo   git rebase --continue
            pause
            exit /b 1
        )
        echo Rebase completed successfully.
    )
)

echo.
echo ========================================
echo Sync completed successfully!
echo ========================================
echo.
echo Summary:
echo - Fetched latest changes from upstream
echo - Merged upstream/main into local main
echo - Pushed updates to your fork
if not "%CURRENT_BRANCH%"=="main" (
    echo - Returned to branch: %CURRENT_BRANCH%
)
echo.
pause
