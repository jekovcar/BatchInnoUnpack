# Use BatchInnoUnpack
BatchInnoUnpack use jratlev's InnoUnpacker for unpacks each installer into a folder "Output" with the _unpacked suffix.
<br>If the EXE files are not Inno Setup, then only the EXE's icon will be simply unpacked as "Setup Icon.ico".
<br>Run BatchUnpack.bat next to the InnoSetup or simple EXE files.
<br>The script will automatically download innounp.exe and install it in utils.
<br>In utils must be:
<br>1. innounp.exe(can be download/update from https://www.rathlev-home.de/tools/download/innounp-2.zip), console unpacker
<br>2. Issfix_iconextr.exe (https://www.autoitscript.com) adds an installer icon, bom utf8  "install_script.iss":"SolidCompression=yes"&"SetupIconFile=SetupIcon.ico"&"VersionInfoVersion=" &"AppCopyright="
<br> In Languages(Optional): .isl files from the releases at https://files.jrsoftware.org/is/6/, can be removed to extract the embedded installer's isl.
<br>3. disasm.exe([https://master.dl.sourceforge.net/project/innounp/other stuff/ROPS Disassembler/rops-3.0.53.935-disasm.rar](https://sourceforge.net/projects/innounp/files/other%20stuff/ROPS%20Disassembler/rops-3.0.53.935-disasm.rar)) ROPS disassembler writes "CodeSection.txt"
# Reference
<p2>https://github.com/jrathlev/InnoUnpacker-Windows-GUI/tree/master/innounp-2
<br>https://www.rathlev-home.de/tools/prog-e.html#unpack
