<?xml version="1.0" encoding="UTF-8"?>

# Installation

To begin working with the bundle it is necessary to download and install the Flex SDK or Flex Builder from [here](http://www.adobe.com/products/flex/downloads/). Bundle commands will search the following directories in an attempt to find the sdk:

* `/Applications/flex_sdk_2`
* `/Applications/FlexSDK2`
* `/Applications/Flex`
* `/Applications/FlexSDK2.0.1`
* `/Applications/Adobe Flex Builder 2/Flex SDK 2`
* `~/Flex`
* `~/flex_sdk_2`
* `/Developer/SDKs/flex_sdk_2`
* `/Developer/SDKs/Flex`
* `/Developer/SDKs/FlexSDK2`
* `/Developer/Applications/Flex`
* `/Developer/Applications/flex_sdk_2`
* `/Developer/Applications/FlexSDK2`
* `/Developer/Applications/Adobe Flex Builder 2/Flex SDK 2`

If you do not place the Flex SDK in one of these directories then you need to set the TextMate shell variable `TM_FLEX_PATH` to your chosen directory. Please note that if you have added `[flex_sdk]/bin` to your [PATH](http://en.wikipedia.org/wiki/Environment_variable#Examples_of_UNIX_environment_variables") manually only a limited number of bundle commands make use of it.

Documentation is available [here](http://www.adobe.com/support/documentation/en/flex/), a zip file containing all documentation can be [downloaded here](http://www.adobe.com/go/flex_documentation_zip). Once downloaded please rename the unzipped directory `docs` and place it in your Flex SDK directory.

Compilation speed can be increased by using [fcsh](http://labs.adobe.com/wiki/index.php/Flex_Compiler_Shell) and [iTerm](http://iterm.sourceforge.net). The downloaded files need to be moved to their corresponding `lib` and `bin` Flex SDK directories.  

A full archive of flash players can be found [here](http://www.adobe.com/cfusion/knowledgebase/index.cfm?id=tn_14266), debugger versions of the player are needed to trace output and display runtime errors.  

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

A svn utility which checks out various open source AS3 Libraries (to the directory specified by `TM_AS3_LIB_PATH`). 

## Compile Current Class

**Target:** selected file or the active file if it doesn't belong to a project.  
**Key Equivalent:** ⇧⌘B  
Compiles using mxmlc.

## Documentation for word
	
**Target:** Current Word  
**Key Equivalent:** ⌃H  
Searches the help files for the selected word. 

## Getter Setter
	
**Target:** Current Word  
**Key Equivalent:** ⌃⌥G  
Creates a getter setter function from the selected word.  

## Open Super Class

**Target:** current document  
**Key Equivalent:** ⇧⌘D  
Attempts to locate the current Classes super class and opens it.  

## Run Project

**Target:**	Current Project  
**Key Equivalent:**	⌘R  
See the [configuration options] below.  

# Configuration Options

These environment variables allow you to define or customise the behavior of certain commands. For help on setting them up please see [TextMate help](?environment_variables).

## `TM_FLEX_PATH`
the path to your Flex SDK installation directory. If it is not in one of the default locations (see Installation section).

## `TM_FLEX_FILE_SPECS`  
The project directory relative path to the file to compile. Ideally this should be a [Project Dependent Variable](?project_dependent_variables)

## `TM_FLEX_OUTPUT`

The project directory relative path to the file to create when you compile. Ideally this should be a [Project Dependent Variable](?project_dependent_variables).

## `TM_FLEX_BUILD_FILE`  
The project directory relative path to the build file you wish to use to override default behaviour.

## `TM_AS3_LIB_PATH`  
**default** `/Users/Shared/AS3Lib`  
The root path to your central ActionScript 3 / Flex library.

## `TM_ORGANIZATION_NAME`
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
