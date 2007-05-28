<?xml version="1.0" encoding="UTF-8"?>

This document describes the commands of the TextMate ActionScript 3 bundle, how to [install] the tools it uses, and how you can [configure] their behavior.

For general ActionScript 3 and Flex help and tutorials, you should consult the [Adobe developer website](http://www.adobe.com/devnet/).

# Installation

To begin working with the bundle it is necessary to download and install the Flex SDK or Flex Builder from [here](http://www.adobe.com/products/flex/downloads/). If you do not place the Flex SDK in one of [these][TM_FLEX_PATH] directories then you need to set the TextMate shell variable `TM_FLEX_PATH` to your chosen directory.  


Documentation is available [here](http://www.adobe.com/support/documentation/en/flex/), a zip file containing all documentation can be [downloaded here](http://www.adobe.com/go/flex_documentation_zip). Once downloaded please rename the unzipped directory 'docs' and place it in your Flex SDK directory.


To dramatically speed up compilation you can use [fcsh](http://labs.adobe.com/wiki/index.php/Flex_Compiler_Shell) and [iTerm](http://iterm.sourceforge.net). The fcsh binary needs to be copied to your Flex SDK bin directory.  

A full archive of flash players can be found [here](http://www.adobe.com/cfusion/knowledgebase/index.cfm?id=tn_14266), please note that debugger versions of the player are needed to trace output and display runtime errors.  

# Commands

## Auto Complete Function

**Target:** current word  
**Key Equivalent:**  ⌥⎋  
Attempts to auto complete the function you have partially typed.

## Build

**Target:** active project  
**Key Equivalent:**  ⌘B  
Builds the currently active project. The project needs to be correctly configured for success. See the [configuration options] below.  
	
## Checkout AS3 Libs

A svn utility to which will check out open source AS3 Libraries available from adobe. The command will target

[`$TM_AS3_LIB_PATH`]. The following libraries are checked out:

* [corelib](http://code.google.com/p/as3corelib/) General Utility classes and APIs.
* [Ebay](http://code.google.com/p/as3ebaylib/) Ebay API.
* [FlexLib](http://code.google.com/p/flexlib/) Open Source Flex 2 Component Library.
* [FlexUnit](http://code.google.com/p/as3flexunitlib) Flex and ActionScript 3 Unit Testing framework.
* [Flickr](http://code.google.com/p/as3flickrlib/) Flickr API.
* [Mappr](http://code.google.com/p/as3mapprlib/) Mappr API.
* [Odeo](http://code.google.com/p/as3odeolib/) Odeo Podcast API</li>
* [PaperVision3D](http://www.osflash.org/papervision3d/)
* [RSS and Atom Libraries](http://code.google.com/p/as3syndicationlib/) RSS and Atom Parsing APIs.
* [YouTube](http://code.google.com/p/as3youtubelib/) YouTube Video API.

## Compile Current Class

**Target:** selected file or the active file if it doesn't belong to a project.  
**Key Equivalent:** ⇧⌘B  
Compiles using mxmlc.  

## Getter Setter
	
**Target:** Current Word  
**Key Equivalent:** ⌃⌥G  
Creates a getter setter function from the selected word.  

## Help

**Target:** Current Word  
**Key Equivalent:** ⌃H  
Searches the help files for the selected word. <a href="javascript:goTo(&quot;goto_tm_flex_path&quot;);">$TM_FLEX_PATH</a> may need to be specified.  

## Run Project

**Target:**	Current Project  
**Key Equivalent:**	⌘R  
See the [configuration options] below.  

# Configuration Options

These environment variables allow you to define or customise the behavior of certain commands. For help on setting them up please see [TextMate help](?environment_variables).

## `$TM_FLEX_PATH`  
the path to your Flex SDK installation directory. There is no default, however the following directories are searched if the variable is not specified (the first match is used):

* /Applications/flex_sdk_2
* /Applications/FlexSDK2
* /Applications/Flex
* /Applications/FlexSDK2.0.1
* /Applications/Adobe Flex Builder 2/Flex SDK 2
* ~/Flex
* ~/flex_sdk_2
* /Developer/SDKs/flex_sdk_2
* /Developer/SDKs/Flex
* /Developer/SDKs/FlexSDK2
* /Developer/Applications/Flex
* /Developer/Applications/flex_sdk_2
* /Developer/Applications/FlexSDK2
* /Developer/Applications/Adobe Flex Builder 2/Flex SDK 2

Please note:  
If you have added `[flex_sdk]/bin` to your [PATH](http://en.wikipedia.org/wiki/Environment_variable#Examples_of_UNIX_environment_variables") manually via the shell profile only a limited number of bundle commands can make use of it.

## `$TM_FLEX_FILE_SPECS`  
**default** None  
The project directory relative path to the file to compile. Ideally this should be a [Project Dependent Variable](?project_dependent_variables)

## `$TM_FLEX_OUTPUT`  
**default** main.swf  
The project directory relative path to the file to create when you compile. Ideally this should be a [Project Dependent Variable](?project_dependent_variables).

## `$TM_FLEX_BUILD_FILE`  
**default** None  
The project directory relative path to the build file you wish to use to override default behaviour.

## `$TM_AS3_LIB_PATH`  
**default** `/Users/Shared/AS3Lib`  
The root path to your central ActionScript library.

## `$TM_ORGANIZATION_NAME`  
**default** None  
Name used in copyright notices in most templates.

# Known Issues

* fsch doesn't accept escaped or quoted directory names properly, if they have space it fails.  
The only solution is to use paths that don't contain spaces.
* Certain Bundle items won't work with Leopard as it doesn't support niutil.

# Contributors

Whether they know it or not...

[Simon Gregory](http://blog.simongregory.com)  
Chris Jenkins  
[Daniel Parnell](http://blog.danielparnell.com/?p=22)  
[Theo Hultberg](http://blog.iconara.net/2007/02/23/textmate-flex-tips/)  
[Mark Llobrera](http://www.dirtystylus.com/blog/)  
[Joachim](http://4d.ratubagus.net/node/4)  
[ChromaticRain](http://blog.chromaticrain.com/?p=3)  
[Thomas Aylott](http://subtlegradient.com/)  
