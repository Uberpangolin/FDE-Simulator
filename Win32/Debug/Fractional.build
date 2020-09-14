set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\bin\HostX86\x86;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE;C:\Program Files (x86)\Windows Kits\10\bin;C:\D\dmd2\windows\bin;%PATH%
set DMD_LIB=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\lib\x86;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\ucrt\x86;C:\Program Files (x86)\Windows Kits\10\lib\10.0.18362.0\um\x86
set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\
set VCTOOLSINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\
set VSINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\
set WindowsSdkDir=C:\Program Files (x86)\Windows Kits\10\
set WindowsSdkVersion=10.0.18362.0
set UniversalCRTSdkDir=C:\Program Files (x86)\Windows Kits\10\
set UCRTVersion=10.0.18362.0
"C:\Users\Kill-me\3D Objects\VisualD\pipedmd.exe" -deps Win32\Debug\Fractional.dep dmd -debug -m32mscoff -g -gf -X -Xf"Win32\Debug\Fractional.json" -c -of"Win32\Debug\Fractional.obj" ExtraMath.d Fractional.d function.d functionCollection.d numFunction.d polynomial.d simpleDifEq.d
if %errorlevel% neq 0 goto reportError

set LIB=C:\D\dmd2\windows\bin\..\lib32mscoff
echo. > C:\Users\Kill-me\source\repos\Fractional\Fractional\Win32\Debug\Fractional.link.rsp
echo "Win32\Debug\Fractional.obj" /OUT:"Win32\Debug\Fractional.exe" user32.lib  >> C:\Users\Kill-me\source\repos\Fractional\Fractional\Win32\Debug\Fractional.link.rsp
echo kernel32.lib  >> C:\Users\Kill-me\source\repos\Fractional\Fractional\Win32\Debug\Fractional.link.rsp
echo legacy_stdio_definitions.lib /LIBPATH:"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\lib\x86" /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\ucrt\x86" /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\lib\10.0.18362.0\um\x86" /DEBUG /PDB:"Win32\Debug\Fractional.pdb" /INCREMENTAL:NO /NOLOGO /NODEFAULTLIB:libcmt libcmtd.lib /SUBSYSTEM:WINDOWS >> C:\Users\Kill-me\source\repos\Fractional\Fractional\Win32\Debug\Fractional.link.rsp
"C:\Users\Kill-me\3D Objects\VisualD\mb2utf16.exe" C:\Users\Kill-me\source\repos\Fractional\Fractional\Win32\Debug\Fractional.link.rsp

"C:\Users\Kill-me\3D Objects\VisualD\pipedmd.exe" -msmode -deps Win32\Debug\Fractional.lnkdep "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\bin\HostX86\x86\link.exe" @C:\Users\Kill-me\source\repos\Fractional\Fractional\Win32\Debug\Fractional.link.rsp
if %errorlevel% neq 0 goto reportError
if not exist "Win32\Debug\Fractional.exe" (echo "Win32\Debug\Fractional.exe" not created! && goto reportError)

goto noError

:reportError
echo Building Win32\Debug\Fractional.exe failed!

:noError
