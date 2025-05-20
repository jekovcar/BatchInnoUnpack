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
@echo.Upd PS to v5.1 or make it manually.WMF5.1: https://www.microsoft.com/en-us/download/details.aspx?id=54616
)

for /F %%I in ('curl.exe -sLo /dev/null -w %%{url_effective} https://github.com/Wack0/IFPSTools.NET/releases/latest') do set ip=%%I
set word=download
set str=%ip%
call set str=%%str:tag=%word%%%
set suffix=
set str1=%ip%
call set str1=%%str1:https://github.com/Wack0/IFPSTools.NET/releases/tag/=%suffix%%%
set str2=%str%/ifpstools-net_%str1%.zip
set str3=ifpstools-net_%str1%.zip

@echo.
@echo.
@echo.Installed InnoIssFixIconExtract :          https://github.com/jekovcar/BatchInnoUnpack/releases
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/Issfix_iconextr.exe').VersionInfo.FileVersion"
@echo.
@Echo Off
if not exist "%~dp0utils/innounp.exe" goto :message2
@echo.Installed InnoUnpacker version :           https://github.com/jrathlev/InnoUnpacker-Windows-GUI
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/innounp.exe').VersionInfo.FileVersion"
@echo.

@Echo Off
if not exist "%~dp0utils/ifpstools/ifpsdasm.exe" goto :message4
@echo.Installed IFPS disassembler version:       https://github.com/Wack0/IFPSTools.NET/releases
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/ifpstools/ifpsdasm.exe').VersionInfo.FileVersion"
@echo.

@Echo Off
if not exist "%~dp0utils/disasm.exe" goto :message3
@echo.Installed ROPS disassembler                https://sourceforge.net/projects/innounp/files/other%20stuff
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/disasm.exe').VersionInfo.FileVersion"
@echo.

:start
@echo.
@echo.Check Update or Overwrite the latest "Unicode version of the console application Inno Setup Unpacker"?
SET choice=
SET /p choice=Pls, enter Y/N/O: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF /i '%choice%'=='Y' GOTO yes
IF /i '%choice%'=='N' GOTO no
IF /i '%choice%'=='O' GOTO over
ECHO "%choice%" is not valid
ECHO.
GOTO start

:no
@echo.
ECHO It will close!
PAUSE
EXIT

:yes
rundll32 url.dll,FileProtocolHandler https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/
GOTO over

:message2
color 06 
@echo. 
@echo === innounp.exe miss in utils ===
@echo.
:over
@echo.
powershell "exit $PSVersionTable.PSVersion.Major"
if %errorlevel% GEQ 5 (
@Echo Off
@echo.For download ~600kb and install
pause
@echo Please wait for download https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip
@echo and unpack it to /utils
powershell -command "Start-BitsTransfer -Source https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip"
powershell -command "Expand-Archive innounp-2.zip utils -Force"
@echo.
@echo Downloaded and unpacked "innounp-2.zip" in utils
DEL innounp-2.zip /S /Q
) else (
color fc
@echo.Download and install are not support by current powershell version:
    powershell -command "(Get-Host).Version.ToString()"
@echo.Download ~600kb it manually from  https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip
pause
)
goto :check

:message3
@echo. 
@echo === disasm.exe miss in utils === (ROPS disassembler writes "CodeSection_rops.txt")
@echo.
@echo.To download ROPS Disassembler (~245kb) and unpack it yourself into "/utils", go to:
@echo.
@echo.https://sourceforge.net/projects/innounp/files/other%20stuff/ROPS%20Disassembler/rops-3.0.53.935-disasm.rar
@echo.
pause
@echo.
@echo. --- Check the latest InnoUnpacker ---
@echo.
goto :start

:message4
color 0b
@echo. 
@echo === ifpsdasm.exe miss in utils/ifpstools === (IFPS disassembler writes "CodeSection_ifps.txt")
@echo.
powershell "exit $PSVersionTable.PSVersion.Major"
if %errorlevel% GEQ 5 (

IF not exist "curl.exe" (
   IF not exist "%SystemRoot%\System32\curl.exe" (

@echo.
@echo.Not exist curl to define and autoinstall the latest IFPS disassembler.
@echo.Download and unpack manually binary curl.exe nearby to CheckUtils from:
@echo.
@echo.https://curl.se/windows/dl-8.13.0_4/curl-8.13.0_4-win32-mingw.zip
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
@echo.Download ~530kb it manually at %str2%
@echo.and unpack into utils/ifpstools
pause
)
goto :check
