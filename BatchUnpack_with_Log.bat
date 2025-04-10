@Echo Off

if not exist "%~dp0utils/innounp.exe" goto :message2
if not exist "%~dp0*.exe" goto :message

@echo.
@echo --- Unpacking EXE files with Log ---
@echo. 
BatchUnpack.bat >%~dp0Unpack_Log.txt
exit

:message 
@echo. 
@echo === EXE files not exist ===
@echo.
@echo.Put installer in the current directory and Run again.
ECHO Now It will close!
@echo.
pause
exit

:message2 
@echo. 
@echo === innounp.exe miss in utils ===
@echo.
@echo.For download and install
pause
@echo Please wait for download https://www.rathlev-home.de/tools/download/innounp-2.zip
@echo and unpack it to /utils
powershell -command "Start-BitsTransfer -Source https://www.rathlev-home.de/tools/download/innounp-2.zip -Destination innounp-2.zip"
powershell -command "Expand-Archive innounp-2.zip utils -Force"
@echo.
@echo Downloaded and unpacked "innounp-2.zip" in utils
DEL innounp-2.zip /S /Q
@echo.
@echo. --- Now innounp.exe exist in utils, please Run again. ---
@echo.
pause
exit
