SET BATCH_DIR=%~dp0

@ECHO OFF

SET REG_KEY=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 219990
SET VALUE_NAME=InstallLocation
FOR /F "tokens=2*" %%A IN ('REG.exe query "%REG_KEY%" /v "%VALUE_NAME%"') DO (set pInstallDir=%%B)
echo %pInstallDir%

REM UPDATE DAIL
SET TARGET=DAIL
CALL :UPDATE

REM UPDATE DAIL - RIFT
SET TARGET=DAIL - RIFT
CALL :UPDATE

REM UPDATE DAIL - Survival
SET TARGET=DAIL - Survival
CALL :UPDATE

REM GOTO END ECHO
GOTO :ENDECHO

:UPDATE
copy /Y "%BATCH_DIR%updatearcs.bat" "%BATCH_DIR%%TARGET%\resources"
PUSHD "%BATCH_DIR%%TARGET%\resources"
robocopy "%BATCH_DIR%\DAILmergeGQ" "%BATCH_DIR%%TARGET%" /S /NFL /NDL
ECHO call updatearcs.bat
call updatearcs.bat
del /Q updatearcs.bat
POPD
GOTO :EOF

:ENDECHO
echo MAKE SURE YOU CTRL+C HERE