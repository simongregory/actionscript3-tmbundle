#!/usr/bin/env ruby -wKU
# encoding: utf-8

module FlexMate

  class Compiler

    def initialize
      FlexMate::SDK.add_flex_bin_to_path
    end

    # Run mxmlc to compile a swf adapting to the current environment as
    # necessary.
    #
    def build
      
      bin = 'mxmlc'
      
      TextMate.require_cmd(bin)
      
      s = FlexMate::Settings.new
      
      cmd = MxmlcCommand.new
      cmd.file_specs = s.file_specs
      cmd.o = s.flex_output
      
      init_html(bin,cmd)
      
      exhaust = get_exhaust

      TextMate::Process.run(cmd.line) do |str|
        STDOUT << exhaust.line(str)
      end

      STDOUT << exhaust.complete

      html_footer

    end
    
    protected
    
    # Print initial html header.
    #
    def init_html(bin,cmd)
      
      require ENV['TM_SUPPORT_PATH'] + '/lib/web_preview'

      puts html_head( :window_title => "ActionScript 3 Build Command",
                      :page_title => "Build (#{bin})",
                      :sub_title => cmd.file_specs_name )

      puts "<h2>Building...</h2>"
      puts "<p><pre>-file-specs=#{cmd.file_specs}"
      puts "-o=#{cmd.o}</pre></p>"      
      
    end
    
    # Create the object responsible for parsing the compiler output.
    #
    def get_exhaust
      require 'fm/mxmlc_exhaust'
      MxmlcExhaust.new
    end

  end
  
  class FcshCompiler < Compiler
    def initialize
      super
    end
    
    # Run mxmlc inside the fcsh wrapper to compile.
    #
    def build
      
      bin = 'fcsh'
      
      TextMate.require_cmd(bin)
      
      s = FlexMate::Settings.new

      { :files => s.file_specs, :evars => s.flex_output }

      ENV['TM_FLEX_FILE_SPECS'] = s.file_specs
      ENV['TM_FLEX_OUTPUT'] = s.flex_output
      
      FlexMate.required_settings({ :files => ['TM_FLEX_FILE_SPECS'],
                                   :evars => ['TM_FLEX_OUTPUT'] })
      
      cmd = MxmlcCommand.new
      cmd.file_specs = s.file_specs
      cmd.o = s.flex_output      
      
      fcsh = e_sh(ENV['TM_FLEX_PATH'] + '/bin/fcsh')

      #Make sure there are no spaces for fcsh to trip up on.
      FlexMate.check_valid_paths([s.file_specs,s.flex_output,fcsh])
      
      init_html(bin,cmd)
      
      `osascript -e 'tell application "Terminal" to activate'` unless ENV['TM_FLEX_BACKGROUND_TERMINAL']
      `#{e_sh ENV['TM_BUNDLE_SUPPORT']}/lib/fcsh_terminal \"#{fcsh}\" \"#{cmd.line}\" >/dev/null;`
      
      html_footer
      
    end
    
  end
end

# Object to encapsulate a mxmlc command with arguments.
#
class MxmlcCommand
  
  attr_accessor :file_specs
  attr_accessor :o

  def line
    "mxmlc -file-specs=#{e_sh file_specs} -o=#{e_sh o}"
  end

  def file_specs_name
    File.basename(file_specs)
  end

end

if __FILE__ == $0

  require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
  require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
  require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
  require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'

  require '../add_lib'
  require 'fm/sdk'
  require 'fm/settings'
  require 'as3/source_tools'
  
  #There's no error checking at any point so we fall back on TM_CURRENT_FILE 
  #and mxmlc is perfectly happy to compile some ruby! If only :)
  FlexMate::Compiler.new.build
  
  #FlexMate::FcshCompiler.new.build

end
