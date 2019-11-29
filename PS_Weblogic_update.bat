call net stop "ORACLE ProcMGR V12.2.2.0.0_VS2015"
timeout 10
aws s3 cp s3://xxx/Windows/7zip/7z920.exe e:\temp\
aws s3 cp s3://xxx/Oracle/weblogic/patch/p29814665_122130_Generic.zip e:\temp\
aws s3 cp s3://xxx/Oracle/opatch/p28186730_139400_Generic.zip e:\temp\
aws s3 cp s3://xxx/Oracle/opatch/p29909359_139400_Generic.zip e:\temp\
cd e:\temp
call 7z920.exe /S /D="C:\Program Files (x86)\7-Zip"
timeout 5
call "C:\Program Files (x86)\7-Zip\7z.exe" x E:\temp\p28186730_139400_Generic.zip
call "C:\Program Files (x86)\7-Zip\7z.exe" x E:\temp\p29814665_122130_Generic.zip
call "C:\Program Files (x86)\7-Zip\7z.exe" x E:\temp\p29909359_139400_Generic.zip
timeout 5
call "C:\Program Files (x86)\7-Zip\Uninstall.exe" /S
call java -jar E:\temp\6880880\opatch_generic.jar -silent oracle_home=e:\pt857\pt\bea
timeout 10
cd e:\temp
call e:\pt857\pt\bea\OPatch\opatch.bat apply 29909359 -jre E:\pt857\pt\jdk8\jre -oh e:\pt857\pt\bea -oop
timeout 10
cd e:\temp\29814665
call e:\pt857\pt\bea\OPatch\opatch.bat apply -oh e:\pt857\pt\bea -silent
timeout 10
del E:\temp\7z920.exe
del E:\temp\p28186730_139400_Generic.zip
del E:\temp\p29814665_122130_Generic.zip
del E:\temp\p29909359_139400_Generic.zip
rmdir /S /Q e:\temp\29814665
rmdir /S /Q E:\temp\29909359
rmdir /S /Q E:\temp\6880880
cd e:\pt857\pt\bea\opatch 
call e:\pt857\pt\bea\opatch\opatch.bat lsinventory -oh e:\pt857\pt\bea
