@Echo Off
:check
color 0a
@echo.
@echo.                                 [  https://github.com/jekovcar/BatchInnoUnpack  ]
@echo.
@echo.Installed InnoIssFixIconExtract :
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/Issfix_iconextr.exe').VersionInfo.FileVersion"
@echo.
@Echo Off
if not exist "%~dp0utils/innounp.exe" goto :message2
@echo.Installed InnoUnpacker version :
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/innounp.exe').VersionInfo.FileVersion"
@echo.

@Echo Off
if not exist "%~dp0utils/ifpstools/ifpsdasm.exe" goto :message4
@echo.Installed IFPS disassembler version:
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/ifpstools/ifpsdasm.exe').VersionInfo.FileVersion"
@echo.

@Echo Off
if not exist "%~dp0utils/disasm.exe" goto :message3
@echo.Installed ROPS disassembler
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/disasm.exe').VersionInfo.FileVersion"
@echo.

:start
@echo.
@echo.Check online Update or Overwrite the latest "Unicode version of the console application Inno Setup Unpacker" ?
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
@echo.For download (~600kb) latest innounpacker and install
pause
@echo Please wait for download https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip
@echo and unpack it to /utils
powershell -command "Start-BitsTransfer -Source https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip"
powershell -command "Expand-Archive innounp-2.zip utils -Force"
@echo.
@echo Downloaded and unpacked "innounp-2.zip" in utils
DEL innounp-2.zip /S /Q
@echo.
@echo.--- Now innounp.exe exist in utils ---
@echo.--- Close to Exit [ OR ] ---^>^>
pause
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
@echo.To download IFPS disassembler (~530kb) and install
pause
@echo Please wait for download https://github.com/Wack0/IFPSTools.NET/releases/download/v2.0.3/ifpstools-net_v2.0.3.zip
@echo and unpack it to /utils
powershell -command "Start-BitsTransfer -Source https://github.com/Wack0/IFPSTools.NET/releases/download/v2.0.3/ifpstools-net_v2.0.3.zip"
powershell -command "Expand-Archive ifpstools-net_v2.0.3.zip utils/ifpstools -Force"
@echo.
@echo Downloaded and unpacked "ifpstools-net_v2.0.3.zip" in utils
DEL ifpstools-net_v2.0.3.zip /S /Q
@echo.
@echo.--- Now ifpsdasm.exe exist in utils/ifpstools ---
@echo.--- Close to Exit [ OR ] ---^>^>
pause
goto :check
