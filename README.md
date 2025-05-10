# Use BatchInnoUnpack
<br>Run on Windows 7 and later. IFPSdasm require NET Framework 4.7.2 and above. PowerShell v5.1 and above is required for autoinstall components or download the latest complete archiv.
<br>BatchInnoUnpack use J.Rathlev's InnoUnpacker for unpacks each installer(EXE) into a folder "Output" with the _unpacked suffix.
<br>If the EXE file is not Inno Setup(or not decrypted), its icon will be extracted to "Output" with the _icon suffix.
<br>Run BatchUnpack.bat next to the InnoSetup or simple EXE files.
<br>The script will automatically download innounp.exe and install it in utils.
<br>In utils must be:
<br>1. innounp.exe([innounp-2.zip](https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip)), unpacker autoinstall by CheckUtils
<br>2. Issfix_iconextr.exe (https://www.autoitscript.com) adds an installer icon, bom utf8  "install_script.iss":"SolidCompression=yes"&"SetupIconFile=SetupIcon.ico"&"VersionInfoVersion=" &"AppCopyright="
<br>Optional disassemblers for "CodeSection.txt":
<br> ifpsdasm.exe(https://github.com/Wack0/IFPSTools.NET/releases/) autoinstall by CheckUtils
<br> disasm.exe([rops-3.0.53.935-disasm.rar](https://sourceforge.net/projects/innounp/files/other%20stuff/ROPS%20Disassembler/rops-3.0.53.935-disasm.rar)) manually install
<br> Optional In Languages: .isl files from the releases at https://files.jrsoftware.org/is/6/, can be removed to extract the embedded installer's isl.
<br>The latest complete archiv : [BatchInnoUnpack2_6.x.7z](https://disk.yandex.ru/d/izU_tWfE_oJ43Q)
# Reference
<p2>https://github.com/jrathlev/InnoUnpacker-Windows-GUI/tree/master/innounp-2
<br>https://www.rathlev-home.de/tools/prog-e.html#unpack
