@echo off
setlocal

:: Check for administrator privileges
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo -----------------------
echo Installing PBFMIS fonts
echo Code maintained by SDF
echo -----------------------
pause

REM Path to the fonts directory
set fontdir=%SystemRoot%\Fonts

REM Path to the directory containing font files
set sourcedir=%~dp0

REM Loop through all .ttf files in the source directory
for %%f in ("%sourcedir%*.ttf") do (
    echo Installing %%~nxf
    copy "%%f" "%fontdir%"
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d %%~nxf /f
)

echo Fonts installed successfully.
endlocal
pause
