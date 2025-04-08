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

:message2 
@echo. 
@echo === innounp.exe miss in utils ===
@echo.
pause
