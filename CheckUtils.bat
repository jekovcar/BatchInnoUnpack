@Echo Off

:check
powershell "exit $PSVersionTable.PSVersion.Major"
if %errorlevel% GEQ 5 (
    @Echo Off
    color 0a 
) else (
color fc
@echo.Download and install are not support by current powershell version:
    powershell -command "(Get-Host).Version.ToString()"
@echo.Upd PS to v5.1 manually WMF5.1: https://www.microsoft.com/en-us/download/details.aspx?id=54616
)
@Echo Off&SetLocal EnableExtensions DisableDelayedExpansion
Set "IntName="&For /F "Tokens=1,2,4" %%G In (
    '%__APPDIR__%ROUTE.EXE -4 PRINT^|%__APPDIR__%findstr.exe /RC:"0.0.0.0\ *0.0.0.0"'
) Do (Set "_=%%I"&For /F Tokens^=1-2Delims^=^" %%J In (
        '%__APPDIR__%cmd.exe /D/V/C "%__APPDIR__%netsh.exe interface IP show config|%__APPDIR__%findstr.exe "\" !_:.=\.!""'
    ) Do (Call Set "$=%%_%%"&Set "_=%%K"
        Echo(%%J|%__APPDIR__%find.exe "%%I">NUL&&(Call Set "IntName=%%$%%"&GoTo Next)))
:Next
IF exist "curl.exe" set or_=true
IF exist "%SystemRoot%\System32\curl.exe" set or_=true
if defined or_ for /F %%I in ('curl.exe -sLo /dev/null -w %%{url_effective} https://github.com/Wack0/IFPSTools.NET/releases/latest') do set ip=%%I
set word=download
set str=%ip%
call set str=%%str:tag=%word%%%
set suffix=
set str1=%ip%
call set str1=%%str1:https://github.com/Wack0/IFPSTools.NET/releases/tag/=%suffix%%%
set str2=%str%/ifpstools-net_%str1%.zip
set str3=ifpstools-net_%str1%.zip

if defined or_ for /F %%I in ('curl.exe -sLo /dev/null -w %%{url_effective} https://github.com/jekovcar/BatchInnoUnpack/releases/latest') do set ip2=%%I
set str4=%ip2%
call set str4=%%str4:tag=%word%%%
set str5=%ip2%
call set str5=%%str5:https://github.com/jekovcar/BatchInnoUnpack/releases/tag/BatchInnoUnpack_=%suffix%%%

@Echo.------------------------------------
If Not Defined IntName color 09 & Echo..............OFFLINE............
if not exist "%~dp0utils/innounp.exe" goto :message2

@echo.Installed InnoUnpacker version :           https://github.com/jrathlev/InnoUnpacker-Windows-GUI
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/innounp.exe').VersionInfo.FileVersion"
@echo.

IF exist "curl.exe" set or_=true
IF exist "%SystemRoot%\System32\curl.exe" set or_=true
if defined or_ echo GitHub:%str5%
@echo.Installed InnoIssFixIconExtract :          https://github.com/jekovcar/BatchInnoUnpack/releases
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/Issfix_iconextr.exe').VersionInfo.FileVersion"
@echo.

@Echo Off
if not exist "%~dp0utils/ifpstools/ifpsdasm.exe" goto :message4
IF exist "curl.exe" set or_=true
IF exist "%SystemRoot%\System32\curl.exe" set or_=true
if defined or_ echo GitHub:IFPSTools %str1%
@echo.Installed IFPS disassembler version:       https://github.com/Wack0/IFPSTools.NET/releases
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/ifpstools/ifpsdasm.exe').VersionInfo.FileVersion"
@echo.

@Echo Off
if not exist "%~dp0utils/disasm.exe" goto :message3
@echo.Installed ROPS disassembler                https://sourceforge.net/projects/innounp/files/other%20stuff
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/disasm.exe').VersionInfo.FileVersion"
@echo.------------------------------------
:start
@echo.
@echo.Check Upd(Y),Owrite(O) InnoSetupUnpacker/Ifpsdasm(N),Owrite(I)/LastInnoSetup(L)?
SET choice=
SET /p choice=Pls, enter Y/N/O/I/L: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF /i '%choice%'=='Y' GOTO yes
IF /i '%choice%'=='N' GOTO no
IF /i '%choice%'=='O' GOTO over
IF /i '%choice%'=='I' GOTO ifps
IF /i '%choice%'=='L' GOTO last
ECHO "%choice%" is not valid
ECHO.
GOTO start

:last
"%~dp0utils/innounp.exe" -i
echo Above are supported InnoSetup Versions by Unpacker
echo To the index of latest InnoSetup on:    https://files.jrsoftware.org/is/6/
pause
IF exist "curl.exe" set or_=true
IF exist "%SystemRoot%\System32\curl.exe" set or_=true
if defined or_ curl https://files.jrsoftware.org/is/6/
if not defined or_ goto curl
pause
GOTO start

:yes
ECHO.
for /d %%a in ("utils/innounp.exe") do echo Installed Unpacker date: %%~ta
If Defined IntName @Echo.GitHub Unpacker Last-Commit: & powershell -NoLogo -NoProfile -Command (iwr -me HEAD -usebasic "https://api.github.com/repos/jrathlev/InnoUnpacker-Windows-GUI/commits/master").Headers.'Last-Modified'
pause
goto :start 

:message2
color 06 
@echo.
If Not Defined IntName color 09
@echo === innounp.exe miss in utils ===
@echo.
:over
@echo.
powershell "exit $PSVersionTable.PSVersion.Major"
if %errorlevel% GEQ 5 (
@Echo Off
@echo.For download Inno Setup Unpacker ~600kb and install
pause
@echo Please wait for download https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip
@echo and unpack in /utils
If Not Defined IntName Echo Offline && pause && goto :start
powershell -command "Start-BitsTransfer -Source https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip"
powershell -command "Expand-Archive innounp-2.zip utils -Force"
@echo.
@echo Downloaded and unpacked "innounp-2.zip" in utils
DEL innounp-2.zip /S /Q
) else (
color fc
@echo.Download and install are not support by current powershell version:
    powershell -command "(Get-Host).Version.ToString()"
@echo.Download Inno Setup Unpacker manuallyand unpack to utils from:  https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip
pause
)
goto :check

:message3
@echo. 
@echo === disasm.exe miss in utils === (ROPS disassembler writes "CodeSection_rops.txt")
@echo.
@echo.To download ROPS Disassembler ~245kb and unpack it yourself into "/utils", go to:
@echo.
@echo.https://sourceforge.net/projects/innounp/files/other%20stuff/ROPS%20Disassembler/rops-3.0.53.935-disasm.rar
@echo.
pause
@echo.
@echo. --- Check the latest InnoUnpacker ---
@echo.
goto :start

:no
ECHO.
for /d %%a in ("utils/ifpstools/ifpsdasm.exe") do echo Installed IFPSDasm date: %%~ta
If Defined IntName @Echo.GitHub IFPSDasm Last-Commit: & powershell -NoLogo -NoProfile -Command (iwr -me HEAD -usebasic "https://api.github.com/repos/Wack0/IFPSTools.NET/commits/master").Headers.'Last-Modified'
pause
goto :start

:message4
color 0b
@echo. 
@echo === ifpsdasm.exe miss in utils/ifpstools === (IFPS disassembler writes "CodeSection_ifps.txt")
echo.
:ifps
If Not Defined IntName Echo Offline && echo For download IFPS disassembler ~530kb and unpack in utils/ifpstools && echo.https://github.com/Wack0/IFPSTools.NET/releases/latest && pause && goto :start
:curl
@echo.
powershell "exit $PSVersionTable.PSVersion.Major"
if %errorlevel% GEQ 5 (

IF not exist "curl.exe" (
   IF not exist "%SystemRoot%\System32\curl.exe" (

@echo.
@echo.Not exist curl to define and autoinstall.
@echo.Download Curl ~7.7Mb and unpack manually the binary 'curl.exe' nearby to CheckUtils from: https://curl.se/windows/latest.cgi?p=win32-mingw.zip
@echo.
pause
goto :check
   )
)
@Echo Off
@echo.For download IFPS disassembler ~530kb and install

echo %str2%
pause
@echo Please wait for download %str2%
@echo and unpack it to /utils
powershell -command "Start-BitsTransfer -Source %str2%"
powershell -command "Expand-Archive %str3% utils/ifpstools -Force"
@echo.
@echo Downloaded and unpacked %str3% in utils
DEL %str3% /S /Q
) else (
color fc
@echo.Download and install are not support by current powershell version:
    powershell -command "(Get-Host).Version.ToString()"
@echo.Download IFPS disassembler manually at %str2%
@echo.and unpack into utils/ifpstools
pause
)
goto :check
