@echo off
chcp 65001 >nul
echo ===== [project-name] Context Refresh =====
echo.
echo --- CURRENT.md ---
for %%f in ("%~dp0CURRENT.md") do echo Last modified: %%~tf
echo.
echo --- Recent 5 Cards ---
if exist "%~dp0docs\pm-kb\cards\" (
  for /f "delims=" %%f in ('dir /b /o-d "%~dp0docs\pm-kb\cards\2*.md" 2^>nul') do (
    echo   %%f
  )
) else (
  echo   (no cards yet)
)
echo.
echo --- Running Processes ---
tasklist /fi "IMAGENAME eq python.exe" 2>nul | find /i "python" >nul && (
  tasklist /fi "IMAGENAME eq python.exe" 2>nul | find /i "python"
) || (
  echo   (no Python processes)
)
echo.
echo ===== Refresh complete =====
echo Tip: say "kickoff" to start work, "wrap" to save progress
