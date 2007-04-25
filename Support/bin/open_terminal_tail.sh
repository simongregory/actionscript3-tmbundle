#!/bin/bash

TAIL_FILE="$1"
WINDOW_NAME="$2"

if [ "$TAIL_FILE" == "" ]; then
	echo "Please specify a file to tail"
	exit 1;
fi

#'/Users/$USER/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt'

osascript <<EOF | tr "\r" "\n"
tell application "Terminal"
	activate
	with timeout of 1800 seconds
		do script with command "tail -f '$TAIL_FILE'"
		tell window 1
			set title displays shell path to false
			set title displays window size to false
			set title displays device name to true
			set title displays file name to true
			set title displays custom title to true
			set custom title to "$WINDOW_NAME"
			set number of columns to 80
			set number of rows to 20
		end tell
	end timeout
end tell
EOF`

exit 0;
