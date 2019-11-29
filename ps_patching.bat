rem PeopleTool Patching 11/5/2019
@echo off
@echo Stop Processes > e:\temp\ps_patching.log
call net stop "ORACLE ProcMGR V12.2.2.0.0_VS2015"
call net stop "psHRPROD-WebLogicAdmin"
call net stop "psPORTPROD-WebLogicAdmin"
call net stop "psTAMPROD-WebLogicAdmin"
call net stop "psELMPROD-WebLogicAdmin"
call net stop "psHRPROD-PIA"
call net stop "psPORTPROD-PIA"
call net stop "psTAMPROD-PIA"
call net stop "psELMPROD-PIA"
timeout 10
@echo Download Files >> e:\temp\ps_patching.log
aws s3 cp s3://cap-sw/Windows/7zip/7z920.exe e:\temp\
aws s3 cp "s3://cap-sw/Java/pt-jdk8 (8u231).zip" e:\temp\jdk8.zip
aws s3 cp s3://cap-sw/Oracle/weblogic/patch/12.2.1.3.0/p30386660_122130_Generic.zip e:\temp\
cd e:\temp
@echo Install 7zip >> e:\temp\ps_patching.log
call "e:\temp\7z920.exe" /S /D="C:\Program Files (x86)\7-Zip"
timeout 5
@echo Extract Files >> e:\temp\ps_patching.log
call "C:\Program Files (x86)\7-Zip\7z.exe" x E:\temp\p30386660_122130_Generic.zip
call "C:\Program Files (x86)\7-Zip\7z.exe" x -oE:\pt857\pt\jdk8 -y E:\temp\jdk8.zip
timeout 5
@echo Uninstall 7zip >> e:\temp\ps_patching.log
call "C:\Program Files (x86)\7-Zip\Uninstall.exe" /S
timeout 5
cd e:\temp\30386660
@echo Apply Patch >> e:\temp\ps_patching.log
call "e:\pt857\pt\bea\OPatch\opatch.bat" apply -oh e:\pt857\pt\bea -silent >> e:\temp\ps_patching.log
timeout 10
@echo Remove Files >> e:\temp\ps_patching.log
del E:\temp\7z920.exe
del E:\temp\jdk8.zip
del E:\temp\p30386660_122130_Generic.zip
timeout 5
rmdir /S /Q e:\temp\30386660
cd e:\pt857\pt\bea\opatch
call "e:\pt857\pt\bea\opatch\opatch.bat" lsinventory -oh e:\pt857\pt\bea >> e:\temp\ps_patching.log
