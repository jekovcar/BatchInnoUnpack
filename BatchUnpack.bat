@Echo Off
@Echo Off&SetLocal EnableExtensions DisableDelayedExpansion
Set "IntName="&For /F "Tokens=1,2,4" %%G In (
    '%__APPDIR__%ROUTE.EXE -4 PRINT^|%__APPDIR__%findstr.exe /RC:"0.0.0.0\ *0.0.0.0"'
) Do (Set "_=%%I"&For /F Tokens^=1-2Delims^=^" %%J In (
        '%__APPDIR__%cmd.exe /D/V/C "%__APPDIR__%netsh.exe interface IP show config|%__APPDIR__%findstr.exe "\" !_:.=\.!""'
    ) Do (Call Set "$=%%_%%"&Set "_=%%K"
        Echo(%%J|%__APPDIR__%find.exe "%%I">NUL&&(Call Set "IntName=%%$%%"&GoTo Next)))
:Next
:check
color 0a
if not exist "%~dp0utils/innounp.exe" goto :message2
set n=0
for %%a in (*.exe) do set /a n+=1
IF exist "curl.exe" set /a "n=%n%-1"
if %n%==0 goto :message

if not exist "%~dp0utils/ifpstools/ifpsdasm.exe" (
    if not exist "%~dp0utils/disasm.exe" (
        color 0b
@echo.
@echo === disassemblers miss in utils ===
@echo.
@echo.Please run "CheckUtils" to install at last one disassembler.
@echo.
@echo.Inno Unpacked will be without "CodeSection.txt"
@echo.
ECHO waiting 5 seconds...
CHOICE /C:AB /D A /T 5 > NUL
        )
    )

:choi
@echo.===========================================
color 0a
@echo.Unpacking EXE files with Log / Verbose(V) / Check(C) ?
SET choice=
SET /p choice=Pls, ENTER to unpack/enter V to verbose/enter C to check :
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF /i '%choice%'=='V' GOTO verbose
IF /i '%choice%'=='C' GOTO integr
IF /i '%choice%'=='' GOTO unpack
ECHO "%choice%" is not valid
ECHO.    
:verbose
@echo.
color 79    
@echo. --- Verbose about EXE files ---
pause
for %%f in (*.exe) do (
IF not "%%f"=="curl.exe" "%~dp0utils/innounp.exe" -v -m -a "%%f"
IF not "%%f"=="curl.exe" pause
)
@echo.
goto choi

:integr
@echo.
color 7d    
@echo. --- test EXE files for integrity ---
pause
for %%f in (*.exe) do (
IF not "%%f"=="curl.exe" "%~dp0utils/innounp.exe" -t -m -a "%%f"
IF not "%%f"=="curl.exe" pause
)
@echo.
goto choi

:unpack
if not exist "%~dp0utils/wtee.exe" goto :message3
color 0a
@echo --- Unpacking EXE files with Log ---
@echo.
if exist "%~dp0Unpack_Log.txt" DEL /S /Q "%~dp0Unpack_Log.txt"
if exist "%~dp0curl.exe" move "%~dp0curl.exe" "%~dp0utils\curl.exe"
move "%~dp0utils\Unpack" "%~dp0Unpack.cmd" 
Unpack.cmd | "%~dp0utils/wtee.exe" "%~dp0Unpack_Log.txt"
move "%~dp0Unpack.cmd" "%~dp0utils\Unpack"
if exist "%~dp0utils\curl.exe" move "%~dp0utils\curl.exe" "%~dp0curl.exe"
IF EXIST "%~dp0\Output\curl.exe_icon" rmdir /S /Q "%~dp0\Output\curl.exe_icon"
exit

:message
color 0a
@echo. 
@echo === EXE files not exist ===
@echo.
@echo.Put installer in the current directory and:
@echo.--- Close to Exit [ OR ] ---^>^>
pause
goto :check

:message2
color 06
@echo.
If Not Defined IntName color 09 
@echo === innounp.exe miss in utils ===
@echo.
powershell "exit $PSVersionTable.PSVersion.Major"
if %errorlevel% GEQ 5 (
@Echo Off
@echo.For innounp download ~600kb and install
pause
@echo Please wait for download https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip
@echo and unpack it to /utils
If Not Defined IntName Echo Offline && pause && goto :check
powershell -command "Start-BitsTransfer -Source https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip"
powershell -command "Expand-Archive innounp-2.zip utils -Force"
@echo.
@echo Downloaded and unpacked "innounp-2.zip" in utils
DEL innounp-2.zip /S /Q
) else (
color fc
@echo.Download and install are not support by current powershell version:
    powershell -command "(Get-Host).Version.ToString()"
@echo.Download innounp manually and unpack to utils from:  https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip
pause
)
goto :check

:message3
color 0e
If Not Defined IntName color 09
@echo. 
@echo === wtee.exe miss in utils === (wtee writes logfile) 
 
SET /p choice=Pls, ENTER to Unpacking without log / enter W with log:
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF /i '%choice%'=='W' GOTO logf
IF /i '%choice%'=='' GOTO unpw
ECHO "%choice%" is not valid
:logf
@echo.
powershell "exit $PSVersionTable.PSVersion.Major"
if %errorlevel% GEQ 5 (
@Echo Off
@echo.For wtee download ~60kb and install
pause
@echo Please wait for download https://github.com/WinLAFS/wintee/releases/download/v1.0.1/wtee.exe
@echo and move to /utils
If Not Defined IntName Echo Offline && pause && goto :check
powershell -command "Start-BitsTransfer -Source https://github.com/WinLAFS/wintee/releases/download/v1.0.1/wtee.exe"
powershell -command "Move-Item -Path wtee.exe -Destination utils"
) else (
color fc
@echo.Download and install are not support by current powershell version:
    powershell -command "(Get-Host).Version.ToString()"
@echo.Download wtee manually and unpack to utils from: https://github.com/WinLAFS/wintee/releases/download/v1.0.1/wtee.exe
pause
)
goto :unpack
:unpw
if not exist "%~dp0\Output" mkdir "%~dp0\Output"
for %%f in (*.exe) do (
IF EXIST "%~dp0\Output\%%f_unpacked" rmdir /S /Q "%~dp0\Output\%%f_unpacked"
IF EXIST "%~dp0\Output\%%f_icon" rmdir /S /Q "%~dp0\Output\%%f_icon"
 "%~dp0utils/innounp.exe" -x -m -a -"d%~dp0/%%f_unpack" "%~dp0\%%~nxf"
IF EXIST "%~dp0%%f_unpack\embedded\CompiledCode.bin" (
"%~dp0utils/disasm.exe" "%~dp0%%f_unpack\embedded\CompiledCode.bin" "%~dp0%%f_unpack\CodeSection_rops.txt"
"%~dp0utils/ifpstools/ifpsdasm.exe" "%~dp0%%f_unpack\embedded\CompiledCode.bin"
move "%~dp0%%f_unpack\embedded\CompiledCode.txt" "%~dp0%%f_unpack\CodeSection_Ifps.txt"
)
move "%~dp0%%f_unpack\install_script.iss" "%~dp0"
move "%~dp0utils\Issfix_iconextr.exe" "%~dp0"
 "%~dp0Issfix_iconextr.exe"
move "%~dp0install_script.iss" "%~dp0/%%f_unpack"
move "%~dp0*.ico" "%~dp0/%%f_unpack"

IF EXIST "%~dp0RegistrySection.txt" move "%~dp0RegistrySection.txt" "%~dp0/%%f_unpack"
IF EXIST "%~dp0INISection.txt" move "%~dp0INISection.txt" "%~dp0/%%f_unpack"
 
IF EXIST "%~dp0/%%f_unpack\embedded" xcopy /isvy "%~dp0\Languages" "%~dp0/%%f_unpack\embedded"
move "%~dp0Issfix_iconextr.exe" "%~dp0\utils"
IF EXIST "%~dp0/%%f_unpack\embedded" move "%~dp0%%f_unpack" "%~dp0\Output\%%f_unpacked"
IF not EXIST "%~dp0/%%f_unpack\embedded" move "%~dp0%%f_unpack" "%~dp0\Output\%%f_icon"
IF EXIST "%~dp0\Output\curl.exe_icon" rmdir /S /Q "%~dp0\Output\curl.exe_icon"
)
exit
