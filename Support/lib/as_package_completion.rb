#!/usr/bin/env ruby -wKU

SUPPORT = ENV['TM_SUPPORT_PATH']
PROJECT = ENV['TM_PROJECT_DIRECTORY']
HELPTOC = BUNDLE_SUPPORT + '/data/doc_dictionary.xml'

require SUPPORT + '/lib/exit_codes'
require SUPPORT + '/lib/escape'
require SUPPORT + '/lib/ui'
require SUPPORT + '/lib/textmate'
require "rexml/document"
require 'find'

def find_package(word)

	# Places to search for source..
	common_src_directories = ENV['TM_ACTIONSCRIPT_3_COMMON_SOURCE_DIRECTORIES']
	common_src_directories = "src:lib:source:test" if common_src_directories == nil

	TextMate.exit_show_tool_tip("Please select a term to look up.") if word.empty?

	project_paths = []
	project_path_matches = common_src_directories.split(":")

	# Collect all .as and .mxml files in the project src dir. Then filter for word.
	TextMate.each_text_file do |file|
	       path = file.sub( PROJECT, "" );
	       project_path_matches.each do |remove|
	           path = path.gsub( /^.*\b#{remove}\b\//, "" );
	       end
	       #remove extension and replace slashes with dots
	       path = path.gsub(/\.(as|mxml)$/,"").gsub( "/", ".");
	       project_paths.push(path) if File.extname(file) == ".as" || File.extname(file) == ".mxml";
	end

	project_paths = project_paths.grep(/#{word}/)

	# Open Help toc and find matching lines
	toc_lines = IO.readlines(HELPTOC)
	search_results = []
	library_paths = []
	toc_lines.each do |line|
		search_results << line.strip if line[/#{word}/]
	end

	# For each line add the path to the documentation.html file
	search_results.each do |line|
		xml_line = REXML::Document.new(line)
		help_path = xml_line.root.attributes['href']
		class_path = help_path.tr( '/', '.' ).chomp.sub('package-detail','*').sub('.html','')
	    library_paths.push(class_path)
	end

	TextMate.exit_show_tool_tip "Import not found" if library_paths.empty? and project_paths.empty?

	#When there are multiple matches as the user to pick, otherwise return the match.
	if library_paths.size == 1 and project_paths.empty?    
	    choice = library_paths.pop    
	elsif project_paths.size == 1 and library_paths.empty?    
	    choice = project_paths.pop
	else

	    split_marker = []
	    split_marker.push('-') if library_paths.size > 0 and project_paths.size > 0
	    all_paths = library_paths.concat( split_marker.concat(project_paths) )
    
	    indx = TextMate::UI.menu(all_paths)
	    TextMate.exit_discard() if indx == nil
	    choice = all_paths[indx]

	end

end
