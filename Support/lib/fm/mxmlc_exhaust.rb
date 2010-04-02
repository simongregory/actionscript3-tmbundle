#!/usr/bin/env ruby -wKU
# encoding: utf-8

# Parses output from the mxmlc compiler and html formats it for use with the
# TextMate HTML output window.
#
class MxmlcExhaust

  attr_accessor :print_output
  attr_reader :error_count
  attr_reader :line_count
  attr_reader :input
  
  # Constants to track switches in matches (to prettify output).
  CONFIGURATION_MATCH    = "configuration_match"
  ERROR_WARN_MATCH       = "error_warn_match"
  RECOMPILE_REASON_MATCH = "recompile_reason_match"
  UNABLE_TO_OPEN_MATCH   = "unable_to_open_match"

  # Instance initialisation. Creates the regex objects once, and set's the
  # error counter to 0. One instance should be created per mxmlc compile
  # otherwise the error counter will be inaccurate.
  #
  def initialize()
    
    @line_count = 0
    @error_count = 0
    @last_match = ""
    @print_output = false 
    @input = []

    @error_and_warn_regex = /(\/.*?)(\(([0-9]+)\)|):.*(Error|Warning):\s*(.*)$/
    @config_file_regex    = /(^\s*Loading configuration file )(.*)$/
    @recompile_file_regex = /(^Recompile: )(.*)$/
    @reason_file_regex    = /(^.*, )(.*,)(.*)$/
    @unable_to_open_regex = /(^Error: unable to open).*/

  end

  # Processes a single line of mxmlc compiler output. HTML is generated with
  # links back to source and configuration files where appropriate.
  #
  def line(str)
    @input << str
    output = parse_line(str)
    print output if print_output
    output
  end

  # This method should be called once compilations is complete. It outputs
  # formatted html that describes the number of errors encountered.
  #
  def complete
    output = ""
    output << "<br/> WARNING no output recieved" if @line_count == 0
    err = (@error_count == 1) ?  "error" : "errors"
    output << "<br/>Build complete, #{ @error_count.to_s } #{err} occured."
    print output if print_output
    output
  end
  
  def raw(id='z')
    output = ""
    output << '<br/><div class="raw_out_#{id}"><span class="showhide">'
    output << "<a href=\"javascript:hideElement('raw_out_#{id}')\" id='raw_out_#{id}_h' style='display: none;'>&#x25BC; Hide Raw Output</a>"
    output << "<a href=\"javascript:showElement('raw_out_#{id}')\" id='raw_out_#{id}_s' style=''>&#x25B6; Show Raw Output</a>"
    output << '</span></div>'
    output << '<div class="inner" id="raw_out_'+id+'_b" style="display: none;"><br/>'
    output << "<pre><code>#{input.to_s}</code></pre><br/></div>"
    print output if print_output
    output    
  end
  
  protected
  
  def parse_line(str)
    @line_count += 1
    match = @error_and_warn_regex.match(str)
    out = ""
    
    begin

      unless match === nil
        out << "<br/>" if @last_match != ERROR_WARN_MATCH
        if match[3] == nil
          out << match[4] + ' ' + match[5] +
                ' in <a title="'+match[1] +
                '" href="txmt://open?url=file://' + match[1] + '">' +
                File.basename( match[1] ) + '</a><br/>'
        else
          out << match[4] + ' <a title="Click to show error." href="txmt://open?url=file://' + match[1] +
                '&line='+ match[3] +
                '" >' + match[5] +
                '</a> at line ' + match[3] +
                ' in <a title="'+match[1] +
                '" href="txmt://open?url=file://' + match[1] + '">' +
                File.basename( match[1] ) + '</a><br/>'
        end
        @error_count += 1
        @last_match = ERROR_WARN_MATCH
        return out
      end
      
      match = @unable_to_open_regex.match(str)
      unless match === nil
        @error_count += 1
        @last_match = UNABLE_TO_OPEN_MATCH
        out = "\n <h4>File does not exist</h4>\n #{out}"
        return out
      end

      match = @config_file_regex.match(str)
      unless match === nil
          out << "<br/>" if @last_match != CONFIGURATION_MATCH
          out << 'Loading configuration file: <a title="Click to open ' + match[2] +
          '" href="txmt://open?url=file://' + match[2] + '" >' + File.basename( match[2] ) +'</a><br/>'
          @last_match = CONFIGURATION_MATCH
          return out
      end

      match = @recompile_file_regex.match(str)
      unless match === nil
          out << "<br/>" if @last_match != RECOMPILE_REASON_MATCH
          out << 'Recompiling: <a title="Click to open ' + match[2] +
          '" href="txmt://open?url=file://' + match[2] + '" >' + File.basename( match[2] )+'</a><br/>'
          @last_match = RECOMPILE_REASON_MATCH
          return out
      end

      match = @reason_file_regex.match(str)
      unless match === nil
          out << "<br/>" if @last_match != RECOMPILE_REASON_MATCH
          out << match[1]+'<a title="Click to open ' + match[2] + '" href="txmt://open?url=file://' + match[2] +
          '" >' + File.basename( match[2] )+'</a> ' + match[3] + '<br/>'
          @last_match = RECOMPILE_REASON_MATCH
          return out
      end

      if str =~ /^(.*\.swf)( \([0-9].*$)/
          cmd = "open #{e_sh($1)}"
          out << '<script type="text/javascript" charset="utf-8">function openSwf(){TextMate.system(\''+cmd+'\', null);}</script>'
          out << "<br/><a href='javascript:openSwf()' title='Click to run (if there is space in the file path this may not work).'>#{$1}</a>#{$2}<br/>"
      elsif str =~ /Error:/
        out << "<pre>#{str}</pre>"
        @error_count += 1
      elsif str =~ /^\s*$/
        out << "<!-- empty -->"
      elsif str =~ /Nothing has changed since the last compile\. Skip\.\.\./
        out << "<br/>#{str}"
      elsif str =~ /^(Copyright|Version|Adobe)/
         out << "#{str}<br/>"
      end

    rescue TypeError

        out << "WARNING, TextMate ActionScript 3 Bundle Error, Unable to parse mxmlc output: <br/><br/>"
        out << "#{str}<br/>"

        @error_count += 1

    end
    
    out
    
  end

end

# if __FILE__ == $0
#     
# end
