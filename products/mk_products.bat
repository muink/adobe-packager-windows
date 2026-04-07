@echo off&title mk_products
%~1 mshta vbscript:createobject("shell.application").shellexecute("%~f0","::","","runas",1)(window.close)&exit

set products="APRO:Acrobat Pro DC" "AEFT:After Effects" "AUDT:Audition" "KBRG:Bridge" "CHAR:Character Animator" "ILST:Illustrator" "AICY:InCopy" "IDSN:InDesign" "LTRM:Lightroom Classic" "PHSP:Photoshop" "PPRO:Premiere Pro" "AME:Media Encoder"

for /f %%a in ('powershell -Command "Get-Date -Format yyyy"') do set YEAR=%%a

if not exist "#packages" md "#packages" 2>nul
if not exist "#products" md "#products" 2>nul
if not exist "#resources" md "#resources" 2>nul

setlocal enabledelayedexpansion
for %%P in (%products%) do (
	for /f "tokens=1,2 delims=:" %%a in ("%%~P") do (
		set "shortName=%%a"
		set "fullName=%%b %YEAR%"
	)

	echo ^>^> !fullName! ^<^<

	if not exist "!fullName!\packages" mklink /d "!fullName!\packages" "..\#packages"
	if not exist "!fullName!\products" md "!fullName!\products" 2>nul
	if not exist "!fullName!\resources\content\images" md "!fullName!\resources\content\images" 2>nul

	if exist "!shortName!-Driver.xml" move /y "!shortName!-Driver.xml" "!fullName!\products\Driver.xml" >nul
	if exist "!shortName!" move /y "!shortName!" "!fullName!\products\" >nul

	set "L_SN=!shortName!"
	for %%L in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "L_SN=!L_SN:%%L=%%L!"

	if not exist "!fullName!\resources\content\images\appicon.png" (
		mklink "!fullName!\resources\content\images\appicon.png" "..\..\..\..\#resources\icons\!L_SN!96x96.png" 2>nul
	)
	if not exist "!fullName!\resources\content\images\appicon2x.png" (
		mklink "!fullName!\resources\content\images\appicon2x.png" "..\..\..\..\#resources\icons\!L_SN!192x192.png" 2>nul
	)

	if not exist "!fullName!\resources\carousel" (
		mklink /d "!fullName!\resources\carousel" "..\..\#resources\carousel" 2>nul
	)
	if not exist "!fullName!\resources\AdobePIM.dll" (
		mklink "!fullName!\resources\AdobePIM.dll" "..\..\#resources\AdobePIM.dll" 2>nul
	)
	if not exist "!fullName!\resources\Config.xml" (
		mklink "!fullName!\resources\Config.xml" "..\..\#resources\Config.xml" 2>nul
	)

	if not exist "!fullName!\Set-up.exe" (
		mklink "!fullName!\Set-up.exe" "..\#resources\Set-up.exe" 2>nul
	)
)

if exist "icons" move /y "icons" "#resources\" >nul
if exist "ACR" move /y "ACR" "#products\" >nul
move /y CO* "#products\" >nul

echo.
echo Processing complete^!
pause
