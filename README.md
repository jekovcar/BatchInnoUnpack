# BatchInnoUnpack
Inno Setup Files Batch Unpacker, Extracts its Setup Icon.ico, Fixed Script.iss
BatchInnoUnpack unpacks each installer into a folder with the _unpacked suffix.
Run BatchUnpack.bat next to the InnoSetup files.
In utils must be:
<br>1.innounp.exe(can be updated from https://www.rathlev-home.de/tools/download/innounp-2.zip), console unpacker
<br>2.Issfix_iconextr.exe(Issfix_iconextr.au3 thttps://www.autoitscript.com) adds an installer icon, bom utf8  "install_script.iss":"SolidCompression=yes"&"SetupIconFile=SetupIcon.ico"&"VersionInfoVersion=" &"AppCopyright="
