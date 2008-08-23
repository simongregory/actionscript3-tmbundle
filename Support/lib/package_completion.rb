#!/usr/bin/env ruby -wKU

require File.dirname(__FILE__) + '/flex_env.rb'

$project  = ENV['TM_PROJECT_DIRECTORY']
$help_toc = File.dirname(__FILE__) + '/../data/doc_dictionary.xml'

# Returns an colon seperated list of directory names 
# that are commonly used as the root directory for source files.
def common_src_dir_list
	src_dirs = ENV['TM_AS3_USUAL_SRC_DIRS']
	src_dirs = "src:lib:source:test" if src_dirs == nil
	src_dirs
end

# Returns an array of directory names that are commonly used
# as the root directory for source files.
def common_src_dirs
	src_dirs_matches = common_src_dir_list.split(":")
	src_dirs_matches
end

# Finds, and where sucessful returns, the package path for the specified 
# class (word is used as parameter here as it may be a partial class name).
# Packages paths are resolved via doc_dictionary.xml, which contains flash, fl, 
# and mx paths, and the current tm project (when available). 
#
# Where mulitple possible matches are found these are presented to the user 
# using Textmate::UI.menu with the most probable match at the top of the menu.
def find_package(word)
	
	TextMate.exit_show_tool_tip("Please select a class to\nlocate the package path for.") if word.empty?
	
	package_paths = []
	best_paths = []
	
	# Collect all .as and .mxml files with a filename that contains the search
	# term. When used outside a project this step is skipped.
	TextMate.each_text_file do |file|
		
		if file =~ /\b#{word}\w*\.(as|mxml)$/
			
			path = file.sub( $project, "" );
			
			common_src_dirs.each do |remove|
				path = path.gsub( /^.*\b#{remove}\b\//, '' );
			end

			path = path.gsub(/\.(as|mxml)$/,'').gsub( "/", ".").sub(/^\./,'')

			if path =~ /\.#{word}$/
				best_paths << path
			else
				package_paths << path
			end
			
		end
		
	end

	# Open Help dictionary and find matching lines
	toc = ::IO.readlines($help_toc)
	toc.each do |line|
		if line =~ /href='([a-zA-Z0-9\/]*\b#{word}\w*)\.html'/
			
			path = $1.gsub( "/", ".")
			
			if path =~ /\.#{word}$/
				best_paths << path
			else
				package_paths << path
			end
			
		end
	end

	package_paths.uniq!
	best_paths.uniq!
	
	if package_paths.size > 0 and best_paths.size > 0
		package_paths = best_paths + ['-'] + package_paths
	else
		package_paths = best_paths + package_paths
	end

	TextMate.exit_show_tool_tip "Class not found" if package_paths.empty?

	if package_paths.size == 1

		package_paths.pop
	
	else
		
		# Move any exact hits to the top of the list.
		best_paths = package_paths.grep( /\.#{word}$/ )
		
		i = TextMate::UI.menu(package_paths)
		TextMate.exit_discard() if i == nil
		package_paths[i]

	end

end

	