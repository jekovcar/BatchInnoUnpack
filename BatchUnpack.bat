if not exist "%~dp0utils/innounp.exe" goto :message2
if not exist "%~dp0*.exe" goto :message

for %%f in (*.exe) do ( 
 %~dp0utils/innounp.exe -x -m -a -d%~dp0/%%f_unpack %~dp0\%%~nxf
move %~dp0%%f_unpack\install_script.iss "%~dp0"
move %~dp0utils\Issfix_iconextr.exe "%~dp0"
 %~dp0Issfix_iconextr.exe
move %~dp0install_script.iss "%~dp0/%%f_unpack"
move %~dp0SetupIcon.ico "%~dp0/%%f_unpack"
xcopy /isvy %~dp0\Languages "%~dp0/%%f_unpack\embedded"
move %~dp0Issfix_iconextr.exe "%~dp0\utils"
move %~dp0/%%f_unpack "%~dp0/%%f_unpacked"
)
exit

:message 
@echo. 
@echo === EXE files not exist ===
pause

:message2 
@echo. 
@echo === innounp.exe miss in utils ===
pause
