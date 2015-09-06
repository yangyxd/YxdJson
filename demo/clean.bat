cd Source
del *.dcu;*.zip;*.7z;*.hpp;*.identcache;*.local /q /s
del __history\*.* /q /s
rd __history

cd ..
cd Qdac
del *.dcu;*.zip;*.7z;*.hpp;*.identcache;*.local /q /s
del __history\*.* /q /s
rd __history

cd ..
cd dcu
del *.dcu /q /s
del __history\*.* /q /s

cd ..\Demo
del *.exe /q/s

cmdex cleanup(".\")
pause