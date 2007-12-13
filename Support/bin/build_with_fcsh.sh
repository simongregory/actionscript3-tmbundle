#!/bin/bash

. "$TM_BUNDLE_SUPPORT/lib/flex_utils.sh";

OS=$(defaults read /System/Library/CoreServices/SystemVersion ProductVersion)

function checkForSpaces {
	if [[ "$1" != "$2" ]]; then
		echo "Warning fsch cannot handle paths containing a space."
		echo " "
		echo "/path_to/app.mxml works"
		echo "/path to/app.mxml fails as there is a space between path and to"
		echo " "
		echo "The path that caused the problem was"
		echo " "
		echo "$1"
		echo " "
		echo "See bundle help for more information."		
		exit 206;
	fi	
}

#Only check for iTerm when the OS is Tiger.
if [[ "$OS" != 10.4.* ]]; then
	
	if find_app >/dev/null iTerm; then
		#All is ok.
		do_nothing_variable="TODO remove this by checking the negative"
	else
		echo "This command requires iTerm to be installed."
		echo "See bundle help for more information."
		exit 206;
	fi

fi

#search for the flex install directory.
set_flex_path -t

#Set and cd to TM_PROJECT_DIR 
cd_to_tmproj_root

if [ "$TM_FLEX_FILE_SPECS" == "" ]; then
	echo "Please specify a document to compile (using the variable TM_FLEX_FILE_SPECS)."
	exit 206;
fi

if [[ !(-f "$TM_PROJECT_DIR/$TM_FLEX_FILE_SPECS") ]]; then 
	echo "The TM_FLEX_FILE_SPECS file:"
	echo "    $TM_FLEX_FILE_SPECS"
	echo "cannot be found."
	exit 206;
fi

if [ "$TM_FLEX_OUTPUT" == "" ]; then
	echo "Please specify the location and name of the swf to create (using the variable TM_FLEX_OUTPUT)."
	exit 206;
fi

#TM_PROJECT_DIR=`dirname "$TM_PROJECT_FILEPATH"`;

FCSH=$(echo "$TM_FLEX_PATH/bin/fcsh" | sed 's/ /\\ /g');
MXMLC_O=$(echo "$TM_PROJECT_DIR/$TM_FLEX_OUTPUT" | sed 's/ /\\ /g');
MXMLC_FS=$(echo "$TM_PROJECT_DIR/$TM_FLEX_FILE_SPECS" | sed 's/ /\\ /g');
MXMLC_SP=$(echo "$TM_AS3_LIB_PATH" | sed 's/ /\\ /g');

checkForSpaces "$TM_PROJECT_DIR/$TM_FLEX_OUTPUT" "$MXMLC_O"
checkForSpaces "$TM_PROJECT_DIR/$TM_FLEX_FILE_SPECS" "$MXMLC_FS"
checkForSpaces "$TM_AS3_LIB_PATH" "$MXMLC_SP"

MXMLC_ARGS="mxmlc -o=$MXMLC_O -file-specs=$MXMLC_FS"

if [ "$TM_AS3_LIB_PATH" != "" ]; then
	MXMLC_ARGS="$MXMLC_ARGS -sp+=$TM_AS3_LIB_PATH"
fi
	
if [[ "$OS" != 10.4.* ]]; then
    "$TM_BUNDLE_SUPPORT/lib/fcsh_terminal" "$FCSH" "$MXMLC_ARGS" >/dev/null; 
else
	osascript "$TM_BUNDLE_SUPPORT/lib/fsch_iTerm.applescript" "$FCSH" "$MXMLC_ARGS" >/dev/null;
fi

exit 200;
