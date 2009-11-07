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
    @config_file_regex    = /(^Loading configuration file )(.*)$/
    @recompile_file_regex = /(^Recompile: )(.*)$/
    @reason_file_regex    = /(^.*, )(.*,)(.*)$/

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
  
  protected
  
  def parse_line(str)
    @line_count += 1
    match = @error_and_warn_regex.match(str)
    out = ""
    
    begin

      unless match === nil
        out << "<br/>" if @last_match != ERROR_WARN_MATCH
        if match[3] == nil
          out << 'Error ' + match[5] +
                ' in <a title="'+match[1] +
                '" href="txmt://open?url=file://' + match[1] + '">' +
                File.basename( match[1] ) + '</a><br/>'
        else
          out << 'Error <a title="Click to show error." href="txmt://open?url=file://' + match[1] +
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

if __FILE__ == $0

  require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
  
  require "test/unit"
  
  class TestSettings < Test::Unit::TestCase
    
    def in_out
      [
        { :in => 'Loading configuration file /Developer/SDKs/flex_sdk_3.1.0/frameworks/flex-config.xml',
          :out => '<br/>Loading configuration file: <a title="Click to open /Developer/SDKs/flex_sdk_3.1.0/frameworks/flex-config.xml" href="txmt://open?url=file:///Developer/SDKs/flex_sdk_3.1.0/frameworks/flex-config.xml" >flex-config.xml</a><br/>'
        },
        {
          :in => "/Users/simon/Documents/code/actionscript_3/flex_unit/trunk/FlexUnitTest/src/FlexUnitTestRunner.mxml: Error: Unable to locate specified base class 'FlexUnitTestRunnerApplication' for component class 'FlexUnitTestRunner'.",
          :out => "<br/>Error Unable to locate specified base class 'FlexUnitTestRunnerApplication' for component class 'FlexUnitTestRunner'. in <a title=\"/Users/simon/Documents/code/actionscript_3/flex_unit/trunk/FlexUnitTest/src/FlexUnitTestRunner.mxml\" href=\"txmt://open?url=file:///Users/simon/Documents/code/actionscript_3/flex_unit/trunk/FlexUnitTest/src/FlexUnitTestRunner.mxml\">FlexUnitTestRunner.mxml</a><br/>", 
        },
        {
          :in => "deploy/CompileTest.swf (417 bytes)",
          :out => "<script type=\"text/javascript\" charset=\"utf-8\">function openSwf(){TextMate.system('open deploy/CompileTest.swf', null);}</script><br/><a href='javascript:openSwf()' title='Click to run (if there is space in the file path this may not work).'>deploy/CompileTest.swf</a> (417 bytes)<br/>"
        },
        {
          :in => "Error: could not find source for class BlahBlah:mxml",
          :out => "<pre>Error: could not find source for class BlahBlah:mxml</pre>"
        },
        {
          :in => " ",
          :out => "<!-- empty -->"
        },
        {
          :in => "Adobe Compc (Flex Component Compiler)",
          :out => "Adobe Compc (Flex Component Compiler)<br/>"
        },
        {
          :in => "Version 3.4.0 build 9271",
          :out => "Version 3.4.0 build 9271<br/>"
        },
        {
          :in => "Copyright (c) 2004-2007 Adobe Systems, Inc. All rights reserved.",
          :out => "Copyright (c) 2004-2007 Adobe Systems, Inc. All rights reserved.<br/>"
        }
      ]
    end
    
    def test_exhaust
      
      exhaust = MxmlcExhaust.new
      
      in_out.each { |e|
        assert_equal(e[:out], exhaust.line(e[:in]))
      }
      
      assert_equal(2, exhaust.error_count)
      assert_equal(in_out.length, exhaust.line_count) 
      
      assert_equal(in_out.map { |e| e[:in] }.to_s, exhaust.input.to_s)
      
    end
    
  end
  
end
