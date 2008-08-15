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
# class (word is used as paramater here as it may be a partial class name).
# Packages paths are resolved via doc_dictionary.xml, which contains flash, fl, 
# and mx paths, and the current tm project (when available). 
#
# Where mulitple possible matches are found these are presented to the user 
# using Textmate::UI.menu.
def find_package(word)
	
	TextMate.exit_show_tool_tip("Please select a term to look up.") if word.empty?
	
	package_paths = []
	
	# Collect all .as and .mxml files with a filename that contains the search
	# term. When used outside a project this step is skipped.
	TextMate.each_text_file do |file|
		
		if file =~ /\b#{word}\w*\.(as|mxml)$/
			path = file.sub( $project, "" );
			common_src_dirs.each do |remove|
				path = path.gsub( /^.*\b#{remove}\b\//, "" );
			end
			package_paths << path.gsub(/\.(as|mxml)$/,"").gsub( "/", ".")
		end
		
	end

	# Open Help dictionary and find matching lines
	toc = ::IO.readlines($help_toc)
	seperator = package_paths.size > 0 ? true : false;
	toc.each do |line|
		if line =~ /href='([a-zA-Z0-9\/]*\b#{word}\w*)\.html'/
			if seperator
				package_paths << "-"
				seperator = false
			end
			package_paths << $1.gsub( "/", ".")
		end
	end

	TextMate.exit_show_tool_tip "Class not found" if package_paths.empty?

	if package_paths.size == 1

		package_paths.pop
	
	else
		
		# Move any exact hits to the top of the list.
		best_paths = package_paths.grep( /\.#{word}$/ )
		unless best_paths.empty?
			package_paths = package_paths - best_paths
			package_paths = best_paths + [ "-" ] + package_paths
		end
		
		i = TextMate::UI.menu(package_paths)
		TextMate.exit_discard() if i == nil
		package_paths[i]

	end

end

	