if not exist "%~dp0utils/innounp.exe" goto :message2
if not exist "%~dp0*.exe" goto :message

@echo.
@echo --- Unpacking EXE files with Log --- 
BatchUnpack.bat >%~dp0Unpack_Log.txt
exit

:message 
@echo. 
@echo === EXE files not exist ===
pause

:message2 
@echo. 
@echo === innounp.exe miss in utils ===
pause
