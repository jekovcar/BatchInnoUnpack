for %%f in (*.exe) do ( 
 %~dp0utils/innounp.exe -x -m -a -d%~dp0/%%f_unpack %~dp0\%%~nxf
move %~dp0%%f_unpack\install_script.iss "%~dp0"
move %~dp0utils\Issfix_iconextr.exe "%~dp0"
 %~dp0Issfix_iconextr.exe
move %~dp0install_script.iss "%~dp0/%%f_unpack"
move %~dp0SetupIcon.ico "%~dp0/%%f_unpack"
move %~dp0Issfix_iconextr.exe "%~dp0\utils"
move %~dp0/%%f_unpack "%~dp0/%%f_unpacked"
)
