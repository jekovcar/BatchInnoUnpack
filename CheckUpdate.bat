@Echo Off
if not exist "%~dp0utils/innounp.exe" goto :message2
@echo.Installed InnoUnpacker version :
powershell -NoLogo -NoProfile -Command "(Get-Item -Path '%~dp0utils/innounp.exe').VersionInfo.FileVersion"
@echo. 

:start
@echo.Check the latest "Unicode version of the console application Inno Setup Unpacker" online?
SET choice=
SET /p choice=Pls, enter Y[N]: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF /i '%choice%'=='Y' GOTO yes
IF /i '%choice%'=='N' GOTO no
ECHO "%choice%" is not valid
ECHO.
GOTO start

:no
ECHO It will close!
PAUSE
EXIT

:yes
rundll32 url.dll,FileProtocolHandler https://www.rathlev-home.de/tools/prog-e.html#unpack
 
:update
ECHO.
@echo.Update to the latest "Unicode version of the console application Inno Setup Unpacker"?
SET choice=
SET /p choice=Pls, enter U[L]: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF /i '%choice%'=='U' GOTO upd
IF /i '%choice%'=='L' GOTO lve
ECHO "%choice%" is not valid
ECHO.
GOTO update

:lve
ECHO It will close!
PAUSE
EXIT

:upd
@echo.
@echo Please wait for download https://www.rathlev-home.de/tools/download/innounp-2.zip
@echo and unpack it to /utils
powershell -command "Start-BitsTransfer -Source https://www.rathlev-home.de/tools/download/innounp-2.zip -Destination innounp-2.zip"
powershell -command "Expand-Archive innounp-2.zip utils -Force"
@echo.
@echo Downloaded and unpacked "innounp-2.zip" in utils
DEL innounp-2.zip /S /Q
@echo.
@echo. --- Now innounp.exe is updated ---
@echo.
pause
exit
EXIT

:message2 
@echo. 
@echo === innounp.exe miss in utils ===
@echo.
@echo Please wait for download https://www.rathlev-home.de/tools/download/innounp-2.zip
@echo and unpack it to /utils
powershell -command "Start-BitsTransfer -Source https://www.rathlev-home.de/tools/download/innounp-2.zip -Destination innounp-2.zip"
powershell -command "Expand-Archive innounp-2.zip utils -Force"
@echo.
@echo Downloaded and unpacked "innounp-2.zip" in utils
DEL innounp-2.zip /S /Q
@echo.
@echo. --- Now innounp.exe exist in utils, to check the Version Run again. ---
@echo.
pause
exit