#!/bin/bash

#Use at your own risk.

if [ "$1" == "" ] 
	then
	echo "Please define the location you wish the libraries to be checked out to."
	exit 0;
else 
	AS3_LIB="$1"
fi

mkdir -p "$AS3_LIB/com"
cd "$AS3_LIB/com/"

echo '<h1>Checkout ActionScript3 &amp; Flex Libraries</h1>';

#------- core

echo '<a href="http://code.google.com/p/as3corelib/">corelib</a> - General Utility classes and APIs</li><pre>'
svn checkout http://as3corelib.googlecode.com/svn/trunk/src/com/adobe

#------ web/apis

cd "adobe/webapis/"

mkdir -p "flickr"
echo '</pre><a href="http://code.google.com/p/as3flickrlib/">Flickr</a> - Flickr API<pre>'
svn checkout http://as3flickrlib.googlecode.com/svn/trunk/src/com/adobe/webapis/flickr flickr/

mkdir -p "mappr"
echo '</pre><a href="http://code.google.com/p/as3mapprlib/">Mappr</a> - Mappr API<pre>'
svn checkout http://as3mapprlib.googlecode.com/svn/trunk/src/com/adobe/webapis/mappr mappr/

mkdir -p "odeo"
echo '</pre><a href="http://code.google.com/p/as3odeolib/">Odeo</a> - Odeo Podcast API<pre>'
svn checkout http://as3odeolib.googlecode.com/svn/trunk/src/com/adobe/webapis/odeo odeo/

mkdir -p "youtube"
echo '</pre><a href="http://code.google.com/p/as3youtubelib/">YouTube</a> - YouTube Video API<pre>'
svn checkout http://as3youtubelib.googlecode.com/svn/trunk/src/com/adobe/webapis/youtube youtube/

mkdir -p "ebay"
echo '</pre><a href="http://code.google.com/p/as3ebaylib/">Ebay</a> - Ebay API<pre>'
svn checkout http://as3ebaylib.googlecode.com/svn/trunk/src/com/adobe/webapis/ebay/ ebay/

# -------- xml/syndication

cd "$AS3_LIB/com/adobe/"
mkdir -p "xml"
echo '</pre><a href="http://code.google.com/p/as3syndicationlib/">RSS and Atom Libraries</a> -  RSS and Atom Parsing APIs<pre>'
svn checkout http://as3syndicationlib.googlecode.com/svn/trunk/src/com/adobe/xml xml/

#------- flex unit 
cd "$AS3_LIB/"

mkdir -p "flexunit"
echo "</pre><a href="http://code.google.com/p/as3flexunitlib/">FlexUnit</a> - Flex and ActionScript 3 Unit Testing framework.<pre>"
svn checkout http://as3flexunitlib.googlecode.com/svn/trunk/src/flexunit/ flexunit/

#------- flexlib

mkdir -p "flexlib"
echo "</pre><a href="http://code.google.com/p/flexlib/">FlexLib</a> - Open Source Flex 2 Component Library.<pre>"
svn checkout http://flexlib.googlecode.com/svn/trunk/src/flexlib/ flexlib/

#------- PaperVision3D

cd "$AS3_LIB/"
mkdir -p "org/papervision3d"
echo "</pre><a href="http://www.osflash.org/papervision3d/">PaperVision3D</a><pre>"
svn checkout http://svn1.cvsdude.com/osflash/papervision3d/as3/trunk/src/org/papervision3d org/papervision3d/

echo "Checkout complete."
