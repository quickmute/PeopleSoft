rem PeopleTool UnPatching 11/5/2019 v4
@echo off
@echo Stop Processes > e:\temp\ps_patching.log
call net stop "ORACLE ProcMGR V12.2.2.0.0_VS2015"
timeout 10
@echo Download Files >> e:\temp\ps_patching.log
aws s3 cp s3://XXX/Windows/7zip/7z920.exe e:\temp\
aws s3 cp "s3://XXX/Java/pt-jdk8 (8u221).zip" e:\temp\jdk8.zip
aws s3 cp s3://XXX/Oracle/weblogic/patch/12.2.1.3.0/p30386660_122130_Generic.zip e:\temp\
cd e:\temp
@echo Install 7zip >> e:\temp\ps_patching.log
call "e:\temp\7z920.exe" /S /D="C:\Program Files (x86)\7-Zip"
timeout 5
@echo Extract Files >> e:\temp\ps_patching.log
call "C:\Program Files (x86)\7-Zip\7z.exe" x E:\temp\p30386660_122130_Generic.zip
call "C:\Program Files (x86)\7-Zip\7z.exe" x -oE:\pt857\pt\jdk8_221 -y E:\temp\jdk8.zip
mv E:\pt857\pt\jdk8_221\jdk1.8.0_221 E:\pt857\pt\jdk1.8.0_221 
mv E:\pt857\pt\jdk8 E:\pt857\pt\jdk1.8.0_231
mv E:\pt857\pt\jdk1.8.0_221 E:\pt857\pt\jdk8
timeout 5
@echo Uninstall 7zip >> e:\temp\ps_patching.log
call "C:\Program Files (x86)\7-Zip\Uninstall.exe" /S
timeout 5
cd e:\temp\30386660
@echo UnApply Patch >> e:\temp\ps_patching.log
call "e:\pt857\pt\bea\OPatch\opatch.bat" rollback -id 30386660 -oh e:\pt857\pt\bea
timeout 5
