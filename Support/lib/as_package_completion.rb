#!/usr/bin/env ruby -wKU

SUPPORT = ENV['TM_SUPPORT_PATH']
PROJECT = ENV['TM_PROJECT_DIRECTORY']
HELPTOC = ENV['TM_BUNDLE_SUPPORT'] + '/data/doc_dictionary.xml'

require SUPPORT + '/lib/exit_codes'
require SUPPORT + '/lib/textmate'
require SUPPORT + '/lib/ui'

def find_package(word)
	
	TextMate.exit_show_tool_tip("Please select a term to look up.") if word.empty?
	
	# Places to search for source..
	common_src_directories = ENV['TM_AS3_USUAL_SRC_DIRS']
	common_src_directories = "src:lib:source:test" if common_src_directories == nil
	common_src_dir_matches = common_src_directories.split(":")
	package_paths = []
	
	# Collect all .as and .mxml files in the project src dir. Then filter for word.
	TextMate.each_text_file do |file|

		if file =~ /\b#{word}\w*\.(as|mxml)$/
	       path = file.sub( PROJECT, "" );
	       common_src_dir_matches.each do |remove|
	           path = path.gsub( /^.*\b#{remove}\b\//, "" );
	       end
	       package_paths << path.gsub(/\.(as|mxml)$/,"").gsub( "/", ".")
		end
		
	end

	# Open Help dictionary and find matching lines
	toc = IO.readlines(HELPTOC)
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

	    i = TextMate::UI.menu(package_paths)
	    TextMate.exit_discard() if i == nil
	    package_paths[i]

	end

end
