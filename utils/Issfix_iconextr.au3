#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Unpack.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=0.9
#AutoIt3Wrapper_Res_ProductName=Issfix_iconextr
#AutoIt3Wrapper_Res_ProductVersion=0.9
#AutoIt3Wrapper_Res_CompanyName=jekovcar
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#Include <WinAPIEx.au3>

Local $sFind = "iÂ»?;"
Local $sReplace = ";"
Local $sFind2 = "[Setup]"
Local $sReplace2 = "[Setup]"& @CRLF &"SolidCompression=yes"& @CRLF & _
"SetupIconFile=SetupIcon.ico"& @CRLF &"VersionInfoVersion="& @CRLF &"AppCopyright="
Local $sFileName =  "install_script.iss"
Local $sFileName2 = "install_script2.iss"

_ReplaceStringInFile($sFileName, $sFind, $sReplace)
_ReplaceStringInFile($sFileName, $sFind2, $sReplace2)

FileClose(FileOpen($sFileName2,2+128))
FileWrite($sFileName2,FileRead($sFileName))
FileMove($sFileName2, $sFileName, $FC_OVERWRITE)

Local $search = FileFindFirstFile("*.exe_unpack")
Local $file = FileFindNextFile($search)
Local $sString = StringReplace($file, "_unpack", "")
Local   $aIcon = _WinAPI_Create32BitHICON(_WinAPI_ExtractIcon(@ScriptDir & '\'&$sString,  0))
 _WinAPI_SaveHICONToFile(@ScriptDir & '\SetupIcon.ico', $aIcon)
 _WinAPI_DestroyIcon($aIcon)



