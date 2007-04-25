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

echo "<br><br>Update complete."
