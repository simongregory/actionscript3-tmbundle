#!/usr/bin/env ruby -w

# TODO: Add exit status then reinstate this in the compile and build commands where appropriate.
#if [ "$?" == "0" ]; then
#	open "${TM_FILEPATH%.*}.swf";
#	delayedJS "5000" "window.close()"
#fi

STDOUT.sync = true

error_count = 0;
error_and_warn_regex = /(\/.*?)(\(([0-9]+)\)|):.*(Error|Warning):\s*(.*)$/
config_file_regex = /(^Loading configuration file )(.*)$/
recompile_file_regex = /(^Recompile: )(.*)$/
reason_file_regex = /(^.*, )(.*,)(.*)$/

#Constants to track switches in matches - to introduce extra breaks.
CONFIGURATION_MATCH = "configuration_match"
ERROR_WARN_MATCH = "error_warn_match"
RECOMPILE_REASON_MATCH = "recompile_reason_match"

last_match = ""

ARGF.each do |line|

    match = error_and_warn_regex.match( line )

    unless match === nil
        print "<br/>" if last_match != ERROR_WARN_MATCH        
        print 'Error <a title="Click to show error." href="txmt://open?url=file://' + match[1] + 
              '&line='+ match[3] + 
              '" >' + match[5] + 
              '</a> at line ' + match[3] + 
              ' in <a title="'+match[1] + 
              '" href="txmt://open?url=file://' + match[1] + '">' +
              File.basename( match[1] ) + '</a><br/>'
        error_count += 1
        last_match = ERROR_WARN_MATCH
        next
    end

    match = config_file_regex.match( line )
    unless match === nil
        print "<br/>" if last_match != CONFIGURATION_MATCH
        print 'Loading configuration file: <a title="Click to open ' + match[2] + 
        '" href="txmt://open?url=file://' + match[2] + '" >' + File.basename( match[2] ) +'</a><br/>'
        last_match = CONFIGURATION_MATCH
        next
    end

    match = recompile_file_regex.match( line )
    unless match === nil
        print "<br/>" if last_match != RECOMPILE_REASON_MATCH
        print 'Recompiling: <a title="Click to open ' + match[2] + 
        '" href="txmt://open?url=file://' + match[2] + '" >' + File.basename( match[2] )+'</a><br/>'
        last_match = RECOMPILE_REASON_MATCH
        next
    end

    match = reason_file_regex.match(line)
    unless match === nil
        print "<br/>" if last_match != RECOMPILE_REASON_MATCH
        print match[1]+'<a title="Click to open ' + match[2] + '" href="txmt://open?url=file://' + match[2] + 
        '" >' + File.basename( match[2] )+'</a> ' + match[3] + '<br/>'
        last_match = RECOMPILE_REASON_MATCH
        next
    end

    if line =~ /\.swf \([0-9]/
        puts "<br/>" +line + "<br/>"
    end
    
end

print '<br/>Build complete, ' + error_count.to_s + ' error(s) occured.'
