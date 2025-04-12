# Use BatchInnoUnpack
BatchInnoUnpack unpacks each installer into a folder with the _unpacked suffix.
<br>If the EXE files are not Inno Setup, then their icon will simply be unpacked as "Setup Icon.ico"
<br>Run BatchUnpack.bat(BatchUnpack_with_Log.bat) next to the InnoSetup files.
<br>The script will automatically download innounp.exe and install it in utils.
<br>In utils must be:
<br>1. innounp.exe(can be download/update from https://www.rathlev-home.de/tools/download/innounp-2.zip), console unpacker
<br>2. Issfix_iconextr.exe (https://www.autoitscript.com) adds an installer icon, bom utf8  "install_script.iss":"SolidCompression=yes"&"SetupIconFile=SetupIcon.ico"&"VersionInfoVersion=" &"AppCopyright="
<br> In Languages(Optional): .isl files from the releases at https://files.jrsoftware.org/is/6/
# Reference
<p2>https://github.com/jrathlev/InnoUnpacker-Windows-GUI/tree/master/innounp-2
<br>https://www.rathlev-home.de/tools/prog-e.html#unpack
