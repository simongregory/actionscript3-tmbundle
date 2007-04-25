on run argv
	compileWithFcsh( "fcsh", item 1 of argv, item 2 of argv )
end run

--set found_session to compileWithFcsh( "fcsh" )

on compileWithFcsh(search_name, fcsh_path, mxmlc_args )
	tell application "iTerm"
		--activate
		--See appended comments.
		--tell application "System Events" to keystroke "K" using {command down}
		(* Start by searching all terminal windows for an instance of fcsh *)
		set terminal_list to terminals
		repeat with terminal_windows in terminal_list
			set terminal_sessions to sessions of terminal_windows
			repeat with terminal_session in terminal_sessions
				set session_name to name of terminal_session
				if session_name is search_name then
					--select is optional.
					select terminal_session
					tell terminal_session
						write text "compile 1"
					end tell
					return terminal_session
				end if
			end repeat
		end repeat
		(* If we've got this far then the fsch window hasn't be found so we need to create it.*)
		set new_terminal to (make new terminal)
		tell new_terminal
			set new_session to (make new session)
			tell new_session
				delay 1
				exec command "/bin/bash"
				delay 1
				set name to "fcsh"
				delay 1
				write text fcsh_path
				delay 2
				write text mxmlc_args
			end tell
		end tell
	end tell
	return null
end compileWithFcsh

(*
if found_session is null then
	display dialog "Session not found"
else
	set the_session_name to name of found_session
	display dialog "Found: " & the_session_name
end if
*)


(*
	Here I'd like to invoke the key-command command-K to clear the window of previous output..
	Theoretically the following should work but doesn't. The closest I got was to use:

	tell application "System Events"
		key down command
		key down "K"
	end tell
	
	iTerm responds and clears the screen. However this leaves the command key pressed and effectively cripples the machine.
	Unfortunately:
	
	tell application "System Events"
		key down command
		key down "K"
		delay 1
		key up "K"
		key up command
	end tell
	
	Doesn't work.
*)