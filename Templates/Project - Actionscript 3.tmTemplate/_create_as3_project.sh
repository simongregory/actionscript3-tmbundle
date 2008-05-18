#!/bin/bash

#-------------------------------------------------------------------------
#
# New AS3 Project
# 
# v3. Switched from copying a directory structure to a flat 
# Hierarchy as TM doesn't support Template duplication 
# properly when a directory is present.
#
# v4. Removing support for Flex Builder, as Adobe have  
# changed the underlying format between version 3 + 4.
# 
# Also taking the opportunity to use the swfobject as the 
# embed method as it is much cleaner.  
#
# Added ant build file. 
#
#-------------------------------------------------------------------------

defaultProjectName="AS3Project.tmproj";
defaultClassPath="org.domain";

fullProjectPath=$(CocoaDialog filesave \
			--text "Please name your project and select a folder to save it into" \
			--title "Create New Project" \
			--with-extensions .tmproj \
			--with-file "$defaultProjectName");

if [ -n "$fullProjectPath" ]; then
	
	fullProjectPath=$(tail -n1 <<<"$fullProjectPath");
	projectName=`basename "$fullProjectPath" ".tmproj"`;
	projectPath=`dirname "$fullProjectPath"`;
	
	# Now ask what the class path should be, used to create default dirs.
	fullClassPath=$(CocoaDialog standard-inputbox \
				--title "Project Class Path" \
				--text "$defaultClassPath.$projectName" \
				--informative-text "Enter the project class path:");
	
	if [ -n "$fullClassPath" ]; then
		classPath=$(tail -n1 <<<"$fullClassPath");
		classPath=`echo $classPath | tr '.' '/'`;
		classPathDirectory="$projectPath/$projectName/src/$classPath/";
		
		# Create our project directory structure.
		mkdir -p "$projectPath/$projectName/build";
		mkdir -p "$projectPath/$projectName/deploy/assets/common/css";
		mkdir -p "$projectPath/$projectName/deploy/assets/common/js";
		mkdir -p "$projectPath/$projectName/lib/src";
		mkdir -p "$projectPath/$projectName/lib/bin";
		mkdir -p "$projectPath/$projectName/src";		
		
		# This recursively creates all source code folders, 
		# creating any missing directories along the way
		mkdir -p "$classPathDirectory/core";
		mkdir -p "$classPathDirectory/controllers";
		mkdir -p "$classPathDirectory/errors";
		mkdir -p "$classPathDirectory/events";
		mkdir -p "$classPathDirectory/views";
		
		# Gather variables to be substituted.
		TM_NEW_FILE_BASENAME="$projectName";
		
		export TM_YEAR=`date "+%Y"`;
		export TM_DATE=`date "+%d.%m.%Y"`;
		
		# Customise file variables for the new project and rename
		# files to match the project name.
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project.tmproj.xml" > "$projectPath/$projectName/$projectName.tmproj";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "compile.sh" > "$projectPath/$projectName/build/compile.sh";
		perl -pe 's/\%\{([^}]*)\}/$ENV{$1}/g' < "build.xml" > "$projectPath/$projectName/build/build.xml";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project-config.xml" > "$projectPath/$projectName/src/$projectName-config.xml";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project.as" > "$projectPath/$projectName/src/$projectName.as";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "index.html" > "$projectPath/$projectName/deploy/index.html";
		
		# For the debug html version of the modify the file name.
		TM_NEW_FILE_BASENAME="$projectName-debug";
		
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "index.html" > "$projectPath/$projectName/deploy/index-debug.html";				
		# Copy static files.
		
		cp "main.css" "$projectPath/$projectName/deploy/assets/common/css/main.css";
		cp "swfaddress.js" "$projectPath/$projectName/deploy/assets/common/js/swfaddress.js";
		cp "swfobject.js" "$projectPath/$projectName/deploy/assets/common/js/swfobject.js";
		
		# switch off custom compile.sh (disabled so projects will compile independently of a .tmproj file as these are ignored by svn).
		#mv "$projectPath/$projectName/build/compile.sh" "$projectPath/$projectName/build/compile(rename_to_enable).sh";
			
		# Open the project in TextMate.
		open -a "TextMate.app" "$projectPath/$projectName/$projectName.tmproj";
		
	fi

fi