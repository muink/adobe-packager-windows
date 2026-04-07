#!/bin/bash

products=("APRO:Acrobat Pro DC" "AEFT:After Effects" "AUDT:Audition" "KBRG:Bridge" "CHAR:Character Animator" "ILST:Illustrator" "AICY:InCopy" "IDSN:InDesign" "LTRM:Lightroom Classic" "PHSP:Photoshop" "PPRO:Premiere Pro" "AME:Media Encoder")

mkdir \#packages 2>/dev/null
mkdir \#products 2>/dev/null
mkdir \#resources 2>/dev/null

for product in "${products[@]}"; do
	shortName="${product%:*}"
	fullName="${product#*:} $(date +%Y)"

	echo \>\> $fullName \<\<

	ln -s ../\#packages "$fullName"/packages
	mkdir -p "$fullName"/products 2>/dev/null
	mkdir -p "$fullName"/resources/content/images 2>/dev/null

	mv -fT ${shortName}-Driver.xml "$fullName"/products/Driver.xml
	mv -f --target-directory="$fullName"/products/ ${shortName}

	ln -sf ../../../../\#resources/icons/${shortName,,}96x96.png   "$fullName"/resources/content/images/appicon.png
	ln -sf ../../../../\#resources/icons/${shortName,,}192x192.png "$fullName"/resources/content/images/appicon2x.png

	ln -sf ../../\#resources/carousel                              "$fullName"/resources/carousel
	ln -sf ../../\#resources/AdobePIM.dll                          "$fullName"/resources/AdobePIM.dll
	ln -sf ../../\#resources/Config.xml                            "$fullName"/resources/Config.xml

	ln -sf ../\#resources/Set-up.exe                               "$fullName"/Set-up.exe
done

mv -f --target-directory="\#resources"/ icons 2>/dev/null
mv -f --target-directory="\#products"/ ACR 2>/dev/null
mv -f --target-directory="\#products"/ CO* 2>/dev/null

echo -e "\nProcessing complete!";
read -p "Press any key to continue... " -n1 -s
