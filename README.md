# Use BatchInnoUnpack
<br>Run on Windows 7 and later. IFPSdasm require NET Framework 4.7.2 and above. [Windows Management Framework (WMF) 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616&msockid=14111bf5f44a694b1ced0e47f53f6822) is required(Win10,11 contain) for autoinstall components or download the [latest complete archiv](https://disk.yandex.ru/d/izU_tWfE_oJ43Q).
<br>BatchInnoUnpack use J.Rathlev's InnoUnpacker for unpacks each installer(EXE) into a folder "Output" with the _unpacked suffix.
<br>If the EXE file is not Inno Setup(or not decrypted), its icon will be extracted to "Output" with the _icon suffix.
<br>Run BatchUnpack.bat next to the InnoSetup or simple EXE files.
<br>The script will automatically download innounp.exe and install it in utils.
<br>In utils must be:
<br>1. innounp.exe([innounp-2.zip](https://github.com/jrathlev/InnoUnpacker-Windows-GUI/raw/refs/heads/master/innounp-2/bin/innounp-2.zip)), unpacker autoinstall by CheckUtils
<br>2. Issfix_iconextr.exe adds an installer icon, bom utf8  "install_script.iss":"SolidCompression=yes"&"SetupIconFile=SetupIcon.ico"&"VersionInfoVersion=" &"AppCopyright="
<br>Optional disassemblers for "CodeSection.txt":
<br> ifpsdasm.exe(https://github.com/Wack0/IFPSTools.NET/releases/) autoinstall by CheckUtils
<br> disasm.exe([rops-3.0.53.935-disasm.rar](https://sourceforge.net/projects/innounp/files/other%20stuff/ROPS%20Disassembler/rops-3.0.53.935-disasm.rar)) manually install
# Reference
<p2>https://github.com/jrathlev/InnoUnpacker-Windows-GUI/tree/master/innounp-2
<br>https://www.rathlev-home.de/tools/prog-e.html#unpack
