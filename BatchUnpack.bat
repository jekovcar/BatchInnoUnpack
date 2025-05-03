@Echo Off

:check
color 0a
if not exist "%~dp0utils/innounp.exe" goto :message2
if not exist "%~dp0utils/wtee.exe" goto :message3
if not exist "%~dp0*.exe" goto :message

IF not EXIST "%~dp0utils/disasm.exe" (
color 0b
@echo.
@echo === disasm.exe miss in utils ===
@echo.
@echo.Please run "CheckUtils" to install ROPS disassembler.
@echo.
@echo.Inno Unpacked will be without "CodeSection.txt"
@echo.
ECHO waiting 5 seconds...
CHOICE /C:AB /D A /T 5 > NUL
)

@echo.
@echo --- Unpacking EXE files with Log ---
@echo.
if exist "%~dp0Unpack_Log.txt" DEL /S /Q "%~dp0Unpack_Log.txt"
move "%~dp0utils\Unpack" "%~dp0Unpack.cmd" 
Unpack.cmd | "%~dp0utils/wtee.exe" "%~dp0Unpack_Log.txt"
move "%~dp0Unpack.cmd" "%~dp0utils\Unpack"
powershell -command "Invoke-Item Output"
exit

:message
color 0a
@echo. 
@echo === EXE files not exist ===
@echo.
@echo.Put installer in the current directory and:
@echo.--- Close to Exit [ OR ] ---^>^>
pause
goto :check

:message2
color 06
@echo. 
@echo === innounp.exe miss in utils ===
@echo.
@echo.For download (~600kb) and install
pause
@echo Please wait for download https://www.rathlev-home.de/tools/download/innounp-2.zip
@echo and unpack it to /utils
powershell -command "Start-BitsTransfer -Source https://www.rathlev-home.de/tools/download/innounp-2.zip -Destination innounp-2.zip"
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
color 0e
@echo. 
@echo === wtee.exe miss in utils === (wtee writes logfile) 
@echo.
@echo.For download (~60kb) and install
pause
@echo Please wait for download https://github.com/WinLAFS/wintee/releases/download/v1.0.1/wtee.exe
@echo and move to /utils
powershell -command "Start-BitsTransfer -Source https://github.com/WinLAFS/wintee/releases/download/v1.0.1/wtee.exe"
powershell -command "Move-Item -Path wtee.exe -Destination utils"
goto :check
