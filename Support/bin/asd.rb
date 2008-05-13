#!/usr/bin/env ruby

# This script is responsible for generating the <body/> for a "Search ActionScript 3 Flex Documentation"
#
# Improvements:
# A way to search for odd characters. Eg, * or mx:Metadata
# Use the Flash CS3 Help system. 

SUPPORT    = ENV['TM_SUPPORT_PATH']
FX_HELPDIR = ENV['TM_FLEX_PATH'] + '/docs/langref/'
FX_HELPTOC = ENV['TM_BUNDLE_SUPPORT'] + '/data/flex_help_index.xml'
FL_HELPDIR = '/Library/Application Support/Adobe/Flash CS3/en/Configuration/HelpPanel/help/ActionScriptLangRefV3/'
FL_HELPTOC = FL_HELPDIR+'help_toc.xml'

require "rexml/document"
require SUPPORT + '/lib/exit_codes'
require SUPPORT + "/lib/escape"
require SUPPORT + "/lib/progress"
require SUPPORT + "/lib/web_preview"

flex_lang_ref = "<a href=\"tm-file://#{FX_HELPDIR}index.html\" title=\"Flex SDK - Flex 2 Language Reference Index\">Flex&trade; 2 Language Reference</a><br>" if ENV['TM_FLEX_PATH']
flash_lang_ref = "<a href=\"tm-file://#{FL_HELPDIR}index.html\" title=\"Flash CS3 - ActionScript 3.0 Language and Components Reference\">ActionScript 3.0 Language Reference</a><br>" if File.exist?(FL_HELPTOC)

WORD = STDIN.read.strip

#This shouldn't happen as we're running all the necessary environment checks in the Bundle command.
# if !FX_HELPDIR
# 
#     puts "<h1>Search failed for #{WORD}</h1>"

if WORD.empty?
    
    puts html_head( :title => "Error", :sub_title => "ActionScript 3 / Flex Dictionary" )        
    puts flex_lang_ref
    puts "<br>"
    puts flash_lang_ref
    puts "<h1>Please specify a search term.</h1>"
    #exit
    html_footer
    TextMate.exit_show_html

end

puts html_head( :title => "Documentation for ‘#{WORD}’", :sub_title => "ActionScript 3 / Flex Dictionary" )

puts "<h1>Search results for <span class=\"search\">‘#{WORD}’</span></h1><span class=\"search_results\"><p>"

if ENV['TM_FLEX_PATH'] and File.exist?( FX_HELPDIR )

    # Open TOC
    toc_lines = IO.readlines(FX_HELPTOC)    
    
    # find matching lines
    search_results = []
    toc_lines.each do |line|
        search_results << line.strip if line[/name=\"#{WORD}/]
    end

    if search_results.size == 1
        
        puts "<b>#{WORD}</b> Found, redirecting..."        
        xml_line = REXML::Document.new(search_results[0])            
        puts "<meta http-equiv=\"refresh\" content=\"0; tm-file://#{FX_HELPDIR}#{xml_line.root.attributes['href']}\">"

		exit

    elsif search_results.size > 0
        
        puts flex_lang_ref
        puts "<ul>"

        # parse results for links
        search_results.each do |line|
            xml_line = REXML::Document.new(line)
            help_path = xml_line.root.attributes['href']
            help_class = xml_line.root.attributes['name']
            class_path = `echo "#{help_path}" | tr / .`
            class_path['.html'] = ""
            puts "<li><a title=\"#{class_path}\" href=\"tm-file://#{FX_HELPDIR}#{help_path}\">#{help_class}</a></li>"
        end

        puts "</ul></p>"

    else
	
        # or display error if no matches
        puts flex_lang_ref
        puts "<ul><li>No results</li></ul><br>"


    end

end

#+++++++++++++ CHECK FOR FLASH CS3 +++++

if File.exist?( FL_HELPTOC )
    
    puts flash_lang_ref
    #puts "<ul><li>Flash CS3 search coming soon.</li></ul>"
 
    # Open TOC
    toc_lines = IO.readlines( FL_HELPTOC )
        
    # find matching lines
    search_results = []
    toc_lines.each do |line|
        search_results << line.strip if line[/name=\"#{WORD}/]
    end
    
    if search_results.size > 0
    
        puts "<p><ul>"    
        #parse results for links        
        search_results.each do |line|
            xml_line = REXML::Document.new(line)
            help_path = xml_line.root.attributes['href']
            help_class = xml_line.root.attributes['name']
            class_path = `echo "#{help_path}" | tr / .`
            class_path['.html'] = ""
            puts "<li><a title=\"#{class_path}\" href=\"tm-file://#{FL_HELPDIR}#{help_path}\">#{help_class}</a></li>"
        end    
        puts "</ul></p>"

	else    	
        puts "<ul><li>No results</li></ul><br>"
    end

end

puts "<a title=\"Search Adobe Livedocs for #{WORD}\" href=\"http://livedocs.adobe.com/cfusion/search/index.cfm?loc=en_US&termPrefix=site%3Alivedocs.macromedia.com%2Fflex%2F201++&term=site%3Alivedocs.macromedia.com%2Fflex%2F201++%22#{WORD}%22&area=&search_text=#{WORD}&action=Search\">Search Livedocs</a></p>"

html_footer
TextMate.exit_show_html
