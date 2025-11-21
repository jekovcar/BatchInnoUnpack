#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Unpack.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.1.6
#AutoIt3Wrapper_Res_ProductName=Issfix_iconextr
#AutoIt3Wrapper_Res_ProductVersion=1.0.0
#AutoIt3Wrapper_Res_CompanyName=jekovcar
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#Include <WinAPIEx.au3>
#include <String.au3>
#include <Array.au3>
#include <WinAPIFiles.au3>

;=================Fix UTF with BOM ====================

Local $sFind = "iÂ»?;"
Local $sReplace = ";"
Local $sFind2 = "[Setup]"
Local $sReplace2 = "[Setup]"& @CRLF &"SolidCompression=yes"& @CRLF & _
"SetupIconFile=SetupIcon.ico"& @CRLF &"VersionInfoVersion="& @CRLF &"AppCopyright="
Local $sFileName =  "install_script.iss"
Local $sFileName2 = "install_script2.iss"
Local $sFileReg = "RegistrySection.txt"
Local $sFileINI = "INISection.txt"

_ReplaceStringInFile($sFileName, $sFind, $sReplace)
_ReplaceStringInFile($sFileName, $sFind2, $sReplace2)
If FileRead($sFileName)="" Then
  FileDelete ($sFileName)
Else
 FileClose(FileOpen($sFileName2,2+128))
 FileWrite($sFileName2,FileRead($sFileName))
 FileMove($sFileName2, $sFileName, $FC_OVERWRITE)
EndIf

;=================extract Icon====================

Local $search = FileFindFirstFile("*.exe_unpack")
Local $file = FileFindNextFile($search)
Local $sString = StringReplace($file, "_unpack", "")
Local   $aIcon = _WinAPI_Create32BitHICON(_WinAPI_ExtractIcon(@ScriptDir & '\'&$sString,  0))
If FileExists(@ScriptDir & '\'&$sString &'_unpack\embedded') Then
 _WinAPI_SaveHICONToFile(@ScriptDir & '\SetupIcon.ico', $aIcon)
Else
  Local $sStringE = StringReplace($file, ".exe_unpack", "")
 _WinAPI_SaveHICONToFile(@ScriptDir & '\'&$sStringE&'.ico', $aIcon)
EndIf
 _WinAPI_DestroyIcon($aIcon)

;=================extract sections=====================

Local $sFileReg = "RegistrySection.txt"
Local $sFileINI = "INISection.txt"
Local $sFileISS = FileRead($sFileName)

;----------------------Registry-----------------------
If StringInStr($sFileISS, "[Registry]")=0 Then
	FileDelete($sFileReg)
Else
	local $aExtractReg = _StringBetween($sFileISS, "[Registry]", "[")
    FileOpen($sFileReg, 2)

	FileWrite($sFileReg, $aExtractReg[0])
	FileClose($sFileReg)
EndIf

;-----------------------INI-----------------------
If StringInStr($sFileISS, "[INI]")=0 Then
	FileDelete($sFileINI)
Else
	local $aExtractINI = _StringBetween($sFileISS, "[INI]", "[")
	FileOpen($sFileINI, 2)

	FileWrite($sFileINI, $aExtractINI[0])
	FileClose($sFileINI)
EndIf




