@Echo Off

:check
color 0a
if not exist "%~dp0utils/innounp.exe" goto :message2
if not exist "%~dp0utils/wtee.exe" goto :message3
if not exist "%~dp0*.exe" goto :message

if not exist "%~dp0utils/ifpstools/ifpsdasm.exe" (
    if not exist "%~dp0utils/disasm.exe" (
        color 0b
@echo.
@echo === disassemblers miss in utils ===
@echo.
@echo.Please run "CheckUtils" to install at last one disassembler.
@echo.
@echo.Inno Unpacked will be without "CodeSection.txt"
@echo.
ECHO waiting 5 seconds...
CHOICE /C:AB /D A /T 5 > NUL
        )
    )

@echo.
@echo --- Unpacking EXE files with Log ---
@echo.
if exist "%~dp0Unpack_Log.txt" DEL /S /Q "%~dp0Unpack_Log.txt"
move "%~dp0utils\Unpack" "%~dp0Unpack.cmd" 
Unpack.cmd | "%~dp0utils/wtee.exe" "%~dp0Unpack_Log.txt"
move "%~dp0Unpack.cmd" "%~dp0utils\Unpack"
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
color 0e
@echo. 
@echo === wtee.exe miss in utils === (wtee writes logfile) 
@echo.
powershell "exit $PSVersionTable.PSVersion.Major"
if %errorlevel% GEQ 5 (
@Echo Off
@echo.For download ~60kb and install
pause
@echo Please wait for download https://github.com/WinLAFS/wintee/releases/download/v1.0.1/wtee.exe
@echo and move to /utils
powershell -command "Start-BitsTransfer -Source https://github.com/WinLAFS/wintee/releases/download/v1.0.1/wtee.exe"
powershell -command "Move-Item -Path wtee.exe -Destination utils"
) else (
color fc
@echo.Download and install are not support by current powershell version:
    powershell -command "(Get-Host).Version.ToString()"
@echo.Download ~60kb it manually from https://github.com/WinLAFS/wintee/releases/download/v1.0.1/wtee.exe
pause
)
goto :check
