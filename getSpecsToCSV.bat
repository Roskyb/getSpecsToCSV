@echo off

echo Recopilando informacion [Equipo: %computername%]...
echo Por favor espere....

REM Get Computer Name
FOR /F "tokens=2 delims='='" %%A in ('wmic OS Get csname /value') do SET system=%%A

REM Get Computer Model
FOR /F "tokens=2 delims='='" %%A in ('wmic ComputerSystem Get Model /value') do SET model=%%A

REM Get Computer Manufacturer
FOR /F "tokens=2 delims='='" %%A in ('wmic ComputerSystem Get Manufacturer /value') do SET manufacturer=%%A

REM Get Computer Serial Number
FOR /F "tokens=2 delims='='" %%A in ('wmic Bios Get SerialNumber /value') do SET serialnumber=%%A

rem ProductNumber
for /f "tokens=2 delims==" %%a in ('wmic /namespace:\\root\wmi path MS_SystemInformation get SystemSKU /Format:List ^| findstr /I "SystemSKU="') do set productNumber=%%a
for /f "tokens=1 delims=#" %%a in ("%productNumber%") do set parsedPN=%%a

REM Get Computer OS
FOR /F "tokens=2 delims='='" %%A in ('wmic os get Name /value') do SET osname=%%A
FOR /F "tokens=1 delims='|'" %%A in ("%osname%") do SET osname=%%A

REM Get RAM
FOR /F "tokens=2 delims='='" %%A in ('wmic os get TotalVisibleMemorySize /value') do SET ram=%%A

REM NETWORK IP
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a

if %networkIP% == no (set type=Static) else (set type=Dinamic) 

REM check for ip type
for /f "tokens=2 delims=:" %%a in ('ipconfig /all ^|find "DHCP habilitado"')  do set dhcp=%%a

REM get processor model
FOR /F "tokens=2 delims='='" %%A in ('wmic CPU get NAME /value') do SET processor=%%A


REM Get hard disk capacity
FOR /F "tokens=2 delims='='" %%A in ('wmic diskDRIVE get size /value') do SET hd=%%A


echo  %system%;%model%;%serialnumber%;%parsedPN%;%processor%;%ram%;%hd%;%networkIP%;%type%;%osname%;%username%; >> %computername%.csv

pause

