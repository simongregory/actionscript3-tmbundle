#!/usr/bin/env ruby -wKU

SUPPORT        = ENV['TM_SUPPORT_PATH']
BUNDLE_SUPPORT = ENV['TM_BUNDLE_SUPPORT']

require SUPPORT + '/lib/exit_codes'
require SUPPORT + '/lib/textmate'
require SUPPORT + '/lib/web_preview'

puts html_head(:window_title => "ActionScript 3", :page_title => "Format fcsh Output", :sub_title => "__" );

fsch_output_script = "#{BUNDLE_SUPPORT}/lib/read_fcsh_terminal_output"

fcsh_output=`"#{fsch_output_script}"`

TextMate.exit_show_tool_tip fcsh_output if fcsh_output =~ /fcsh terminal window not found./

lastCompile=[]

#Flag to determine how many instances of (fcsh) we have encountered.
foundFirst=0
#Work up from the bottom of the file, mark the first (fcsh) store intermediate lines, then work up to the next (fcsh).
fcsh_output.split( "\n" ).reverse.each do |line|
    if line =~ /^\(fcsh\)/
        break if foundFirst == 1
        foundFirst=1
    elsif foundFirst == 1
        lastCompile.push(line)
    end
end

#TODO: Generic link regex.
error_and_warn_regex =  /(\/.*?)(\(([0-9]+)\)|):.*(Error|Warning):\s*(.*)$/
config_file_regex = /(^Loading configuration file )(.*)$/
recompile_file_regex = /(^Recompile: )(.*)$/
reason_file_regex = /(^.*, )(.*,)(.*)$/
error_count = 0;
lastCompile.reverse.each do |line|

    match = error_and_warn_regex.match( line )
    unless match === nil
        print 'Error <a title="Click to show error and close output" href="txmt://open?url=file://' + match[1] + '&line='+ match[3]+'" onclick="self.close();">'+match[5]+'</a> at line ' + match[3] + ' in <a title="'+match[1]+'" href="'+match[1]+'">'+File.basename( match[1] )+'</a><br/>'
        error_count += 1
        next
    end

    match = config_file_regex.match( line )
    unless match === nil
        print 'Loading configuration file: <a title="Click to open '+match[2]+'" href="txmt://open?url=file://'+match[2]+'" >' + File.basename( match[2] )+'</a><br/>'
        next
    end

    match = recompile_file_regex.match( line )
    unless match === nil
        print 'Recompiling: <a title="Click to open '+match[2]+'" href="txmt://open?url=file://'+match[2]+'" >' + File.basename( match[2] )+'</a><br/>'
        next
    end

    match = reason_file_regex.match(line)
    unless match === nil
        print match[1]+'<a title="Click to open '+match[2]+'" href="txmt://open?url=file://'+match[2]+'" >' + File.basename( match[2] )+'</a> '+match[3]+'<br/>'
        next
    end

    if line =~ /\.swf \([0-9]/
        puts "<br/>" +line + "<br/>"
    end
    
    #Uncomment this to show all output.
    #puts line + "<br/>"
end

print "<br>Build complete, #{error_count} error(s) occured.</code>"
