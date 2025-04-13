@Echo Off

if not exist "%~dp0utils/innounp.exe" goto :message2
if not exist "%~dp0*.exe" goto :message

for %%f in (*.exe) do (
IF EXIST "%~dp0%%f_unpacked" rmdir /S /Q "%~dp0%%f_unpacked"
 "%~dp0utils/innounp.exe" -x -m -a -"d%~dp0/%%f_unpack" "%~dp0\%%~nxf"
IF EXIST "%~dp0%%f_unpack\embedded\CompiledCode.bin" "%~dp0utils/disasm.exe" "%~dp0%%f_unpack\embedded\CompiledCode.bin" "%~dp0%%f_unpack\CodeSection.txt"
move "%~dp0%%f_unpack\install_script.iss" "%~dp0"
move "%~dp0utils\Issfix_iconextr.exe" "%~dp0"
 "%~dp0Issfix_iconextr.exe"
move "%~dp0install_script.iss" "%~dp0/%%f_unpack"
move "%~dp0SetupIcon.ico" "%~dp0/%%f_unpack"
IF EXIST "%~dp0\Languages" xcopy /isvy "%~dp0\Languages" "%~dp0/%%f_unpack\embedded"
move "%~dp0Issfix_iconextr.exe" "%~dp0\utils"
move "%~dp0%%f_unpack" "%~dp0%%f_unpacked"
)
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
