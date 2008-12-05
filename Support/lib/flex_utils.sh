#!/bin/bash

. "$TM_SUPPORT_PATH/lib/html.sh";
. "$TM_SUPPORT_PATH/lib/webpreview.sh"

#Search locations for the flex sdk
FLEX_DIRS=( "/Developer/SDKs/flex_sdk_3.2.0" \
			"/Developer/SDKs/flex_sdk_3.1.0" \
			"/Developer/SDKs/flex_sdk_3.0.0" \
			"/Applications/flex_sdk_3" \
			"/Applications/Adobe Flex Builder 3/sdks/3.0.0" \
			"/Applications/Adobe Flex Builder 3/sdks/2.0.1" \
			"/Applications/flex_sdk_2" \
			"/Applications/FlexSDK2" \
			"/Applications/Flex" \
			"/Applications/FlexSDK2.0.1" \
			"/Applications/Adobe Flex Builder 2/Flex SDK 2" \
			"~/Flex" \
			"~/flex_sdk_2" \
			"/Developer/SDKs/flex_sdk_2" \
			"/Developer/SDKs/Flex" \
			"/Developer/SDKs/FlexSDK2" \
			"/Developer/Applications/Flex" \
			"/Developer/Applications/flex_sdk_2" \
			"/Developer/Applications/FlexSDK2" \
			"/Developer/Applications/Adobe Flex Builder 2/Flex SDK 2" );

FLEX_COMMANDS=( "mxmlc" "compc" "asdoc" "fdb" "fcsh" "acompc" "adl" "adt" );

#Print the first Flex SDK directory found in the list.
dir_check () {
	for name in "${FLEX_DIRS[@]}"
	do
		if [[ -d "$name" ]]; then
			echo "$name";
			break
		fi
	done
}

#Print the Dirs searched to try and find the users Flex SDK.
show_search_list () {
	for name in "${FLEX_DIRS[@]}"
	do
		echo "$name";
	done
}

# Search FLEX_DIRS list for the Flex SDK, if it exists then set it to the the TM_FLEX_PATH variable.
# returns 0 for success, 1 for failure.
set_TM_FLEX_PATH () {

	if [[ "$TM_FLEX_PATH" == "" ]]; then
		TM_FLEX_PATH=$(dir_check)
	fi

	if [[ "$TM_FLEX_PATH" == "" ]]; then
		return 1; #Fail
	else
		return 0; #Succeed
	fi

}

# Attempts to find the Flex SDK directory and set it to $TM_FLEX_PATH.
# If it fails then a html help window is shown to the user, 
# or if -t is supplied then a tooltip.
set_flex_path () {

	set_TM_FLEX_PATH

	export TM_FLEX_PATH="$TM_FLEX_PATH";

	if [ "$?" == "1" ]; then

		if [ "$1" == "-t" ]; then
			echo "Please define the environment variable TM_FLEX_PATH and point it to your Flex SDK directory."
			exit_show_tool_tip;
		fi

		html_header "Help files 404";

		cat <<-HTMOUT
				<h2>Help not found</h2>
				<p>Please define the environment variable <code>TM_FLEX_PATH</code> and point it to your Flex SDK directory.<br>
			  	Installation and configuration help can be found <a href="$TM_BUNDLE_SUPPORT/html/help.html#installation">here.</a></p>
		HTMOUT
		html_footer
		exit_show_html
	fi

}

# Searches flex install directory list and adds the first found_dir/bin to the PATH.
# This should mean that mxmlc, fcsh etc are invokeable.
try_to_add_flex_bin_to_PATH () {

	if [[ "$TM_FLEX_PATH" == "" ]]; then
		TM_FLEX_PATH=$(dir_check)
	fi

	if [[ "$TM_FLEX_PATH" == "" ]]; then
		#Fail
		return 1;
	else
		#Succeed
		PATH="$PATH:$TM_FLEX_PATH/bin"
		return 0;
	fi

}

#Checks to see if the command is available or not and the result is printed to screen.
cmd_check () {
	if ! type -p "$1" >/dev/null; then
		echo "$1 not available"
		return 1;
	else
		echo "$1 ok"
		return 2;
	fi
}

#Opens one of the help pdf files included in the standard flex documentation.
show_help_pdf () {

	if [ "$1" == "" ]; then
		echo "Please specify a help document to open."
		exit 206;
	fi

	set_flex_path

	local HELP_PDF="$TM_FLEX_PATH/docs/$1"

	if [[ -f "$HELP_PDF" ]]; then
		open "$HELP_PDF"
	else

		echo "<p>$1 not found. Please make sure you have downloaded it...</p>"
		echo "<p>PATH searched: $HELP_PDF</p>"
		echo "<p>See bundle help for setup and configuration details</p>"

		cat <<-HTMOUT
				<h2>PDF not found</h2>
				<p></p>;
				<p>Download the Flex SDK from <a href="">here</a></p>
		HTMOUT

		html_footer		
		exit_show_html;

	fi

}

#Many of the commands only work from a project scope.
#This checks for the existence of a project, then sets $TM_PROJECT_DIR to work from.
cd_to_tmproj_root(){
	if [ "$TM_PROJECT_FILEPATH" == "" ]; then
		exit_show_tool_tip "This Command should only be run from within a saved TextMate Project.";
	fi
	TM_PROJECT_DIR=`dirname "$TM_PROJECT_FILEPATH"`;
	cd "$TM_PROJECT_DIR";
}

#Make sure an environment variable is set.
require_var (){
	if [ "$2" == "" ]; then
		
		#echo "Please define the environment variable $1, see Bundle > Help for details."
		html_header "Missing Environment Variable";

		cat <<-HTMOUT
				<h2>Environement var missing</h2>
				<p>Please define the environment variable <code>\$$1</code>.
				<br>
				<br>
				Configuration help can be found <a href="tm-file://$TM_BUNDLE_SUPPORT/html/help.html#conf">here.</a></p>
		HTMOUT
		html_footer
		exit_show_html
	fi
}

#Make sure a file exists at the defined location.
require_file (){

	#if [[ !(-f "$2") ]]; then
	if [[ !(-f "$2") ]]; then		
	#if [ -f "$2" ]; then 		

		html_header "File not found";

		cat <<-HTMOUT
				<h2>$1 404</h2>
				<p>The environment variable <code>\$$1</code> does not resolve to an actual file.
				<br>
				<br>
				Configuration help can be found <a href="tm-file://$TM_BUNDLE_SUPPORT/html/help.html#conf">here.</a></p>
		HTMOUT
		
		html_footer
		
		exit_show_html

	fi
}

echoIn (){
	echo "$1"
}

