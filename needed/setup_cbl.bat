@echo off
setlocal

:: 
if not exist ".git.zip" (
    echo ERROR: git zip not found in the current directory.
    pause
    exit /b 1
)

echo Extracting .git.zip into .mine...
if not exist ".mine" mkdir ".mine"

powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '.git.zip' -DestinationPath '.mine' -Force"

echo Copying contents to ..\cbl...
if not exist "..\cbl" mkdir "..\cbl"

:: xcopy flags: /E (subdirectories), /I (assume directory), /Y (overwrite), /H (hidden files), /Q (quiet)
xcopy ".mine\*" "..\cbl\" /E /I /Y /H /Q >nul

echo cleaning up
rmdir /s /q ".mine"

echo Opening folder...
cd ..\cbl

echo "updating from server"
git pull
git reset --hard

echo opening folder
start .

echo Done!
endlocal