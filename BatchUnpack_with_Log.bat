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
pause
exit

:message2 
@echo. 
@echo === innounp.exe miss in utils ===
@echo.
@echo Download https://www.rathlev-home.de/tools/download/innounp-2.zip
@echo and unpack innounp.exe to /utils
@echo.
pause
exit
