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
require  SUPPORT + '/lib/exit_codes'

flex_lang_ref = "<a href=\"tm-file://#{FX_HELPDIR}index.html\" title=\"Flex SDK - Flex 2 Language Reference Index\">Flex&trade; 2 Language Reference</a><br>"

WORD = STDIN.read.strip

#This shouldn't happen as we're running all the necessary environment checks in the Bundle command.
if !FX_HELPDIR

    puts "<h1>Search failed for #{WORD}</h1>"

elsif WORD.empty?

  puts "<h1>Please specify a search term.</h1>"
  puts flex_lang_ref;

else

    # Open TOC
    toc_lines = IO.readlines(FX_HELPTOC)    
    
    # find matching lines
    search_results = []
    toc_lines.each do |line|
        search_results << line.strip if line[/name=\"#{WORD}/]
    end

    if search_results.size == 1

        #This obviously isn't the way to do this... but i'm new to Ruby.
        search_results.each do |line|
            xml_line = REXML::Document.new(line)
            puts "<meta http-equiv=\"refresh\" content=\"0; tm-file://#{FX_HELPDIR}#{xml_line.root.attributes['href']}\">";
        end

    elsif search_results.size > 0

        # parse results for links
        links = []

        puts "<h1>Search results for <span class=\"search\">‘#{WORD}’</span></h1><span class=\"search_results\"><p>"
        puts flex_lang_ref
        puts "<ul>"

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
        puts "<h1>No results for: <span class=\"search\">‘#{WORD}’</span></h1>"
        puts flex_lang_ref

    end
    
    #+++++++++++++ CHECK FOR FLASH CS3 +++++
    
    if File.exist?( FL_HELPTOC )
        
        puts "<a href=\"tm-file://#{FL_HELPDIR}index.html\" title=\"Flash CS3 - ActionScript 3.0 Language and Components Reference\">ActionScript 3.0 Language Reference</a><br>"
        puts "<ul><li>Flash CS3 search coming soon.</li></ul>"

         
        # Open TOC
        #toc_lines = IO.readlines(FL_HELPTOC)    
    
        # find matching lines
        #search_results = []
        #toc_lines.each do |line|
        #    search_results << line.strip if line[/name=\"#{WORD}/]
        #end
        
        #if search_results.size > 0
        #
        #    # parse results for links
        #    links = []
        #    puts "<a href=\"tm-file://#{FL_HELPDIR}index.html\" title=\"Flash CS3 - ActionScript 3.0 Language and Components Reference\">ActionScript 3.0 Language Reference</a><br>"
        #    puts "<ul>"
        #
        #    search_results.each do |line|
        #        xml_line = REXML::Document.new(line)
        #        help_path = xml_line.root.attributes['href']
        #        help_class = xml_line.root.attributes['name']
        #        class_path = `echo "#{help_path}" | tr / .`
        #        class_path['.html'] = ""
        #        puts "<li><a title=\"#{class_path}\" href=\"tm-file://#{FL_HELPDIR}#{help_path}\">#{help_class}</a></li>"
        #    end
        #
        #    puts "</ul></p>"
        #
        #end
    
    end
    
    puts "<a title=\"Search Adobe Livedocs for #{WORD}\" href=\"http://livedocs.adobe.com/cfusion/search/index.cfm?loc=en_US&termPrefix=site%3Alivedocs.macromedia.com%2Fflex%2F201++&term=site%3Alivedocs.macromedia.com%2Fflex%2F201++%22#{WORD}%22&area=&search_text=#{WORD}&action=Search\">Search Livedocs</a>"

end

