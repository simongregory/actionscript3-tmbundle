#!/bin/bash

if [ "$1" == "" ]
	then
	echo "Please define the location of the library to be updated."
	exit 0;
else 
	AS3_LIB="$1"
fi

echo "<h1>Updating ActionScript3 &amp; Flex Libraries</h1>"

#------- core

cd "$AS3_LIB/com/adobe/"

echo "Core...<pre>"
svn update
echo "</pre>"
#------ web/apis

echo "<br>Flickr...<pre>"
cd "webapis/flickr"
svn update
echo "</pre>"

echo "<br>Mappr...<pre>"
cd "../mappr"
svn update
echo "</pre>"

echo "<br>Odeo...<pre>"
cd "../odeo"
svn update
echo "</pre>"

echo "<br>YouTube...<pre>"
cd "../youtube"
svn update
echo "</pre>"

echo "<br>Ebay...<pre>"
cd "../ebay"
svn update
echo "</pre>"

# -------- xml/syndication

echo "<br>Atom...<pre>"
cd "$AS3_LIB/com/adobe/xml/syndication"
svn update
echo "</pre>"

#------- flex unit 
#add flexunit here if checked out

#------- PaperVision3D
echo "<br>PaperVision3D..<pre>"
cd "$AS3_LIB/org/papervision3d"
svn update
echo "</pre>"

#-------- FAR falsh archive
echo "<br>FAR..<pre>"
cd "$AS3_LIB/org/vanrijkom"
svn update
echo "</pre>"

#-------- Tweener flash archive
echo "<br>Tweener..<pre>"
cd "$AS3_LIB/caurina"
svn update
echo "</pre>"

#-------- Vegas

echo "<br>Asgard..<pre>"
cd "$AS3_LIB/asgard"
svn update
echo "</pre>"

echo "<br>Ekameleon..<pre>"
cd "$AS3_LIB/net/ekameleon"
svn update
echo "</pre>"

echo "<br>Pegas..<pre>"
cd "$AS3_LIB/pegas"
svn update
echo "</pre>"

echo "<br>Vegas..<pre>"
cd "$AS3_LIB/vegas"
svn update
echo "</pre>"

#--------- guasax

echo "<br>GUASAX..<pre>"
cd "$AS3_LIB/es/guasax"
svn update
echo "</pre>"

#--------- as3httpclient

echo "<br>AS3 HTTP Client..<pre>"
cd "$AS3_LIB/com/abdulqabiz"
svn update
echo "</pre>"



echo "<br><br>Update complete."
