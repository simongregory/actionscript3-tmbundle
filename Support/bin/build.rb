#!/usr/bin/env ruby
# encoding: utf-8

require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'

require File.expand_path(File.dirname(__FILE__)) + '/../lib/add_lib'

require 'fm/flex_mate'
require 'fm/sdk'
require 'fm/compiler'
require 'as3/source_tools'

if ENV['TM_PROJECT_DIRECTORY'] && ENV['TM_FLEX_USE_FCSH']

  require ENV['TM_SUPPORT_PATH'] + '/lib/web_preview'
  require ENV['TM_SUPPORT_PATH'] + '/lib/tm/htmloutput'

  # Start by trying to add the Flex SDK bin to $PATH then testing for fcsh.
  FlexMate::SDK.add_flex_bin_to_path

  TextMate.require_cmd "fcsh"

  bp = ENV['TM_PROJECT_DIRECTORY']

  # Simple euristic: take the first *.as|mxml file in the root folder
  # and use it if no TM_FLEX_FILE_SPECS is set - from Davide 'Folletto' Casali 
  if !ENV['TM_FLEX_FILE_SPECS']

    src_dir = ENV['TM_PROJECT_DIRECTORY']
    src_prefix = ''
    if File.exist?(ENV['TM_PROJECT_DIRECTORY']+'/src')
      src_dir = ENV['TM_PROJECT_DIRECTORY']+'/src'
      src_prefix = 'src/'
    end
    
    Dir.chdir(src_dir)
    Dir['*.as','*.mxml'].sort.each do |name|	
  		ENV['TM_FLEX_FILE_SPECS'] = src_prefix+name #File.expand_path(name) # full path
  		ENV['TM_FLEX_OUTPUT'] = name[/(.*)\.(as|mxml)$/, 1] + ".swf"
  		break
  	end
  end
  
  #Check for custom build files and execute them where they exist.
  custom = "#{bp}/#{ENV['TM_FLEX_BUILD_FILE']}"
  if File.file?(custom) && File.executable?(custom)    
    TextMate::Process.run(custom) do |str|
      STDOUT << str
    end
    TextMate.exit_show_html
  end
  
  s = { :files => ['TM_FLEX_FILE_SPECS'], 
        :evars => ['TM_FLEX_OUTPUT'],
        :base_path => bp }

  FlexMate.required_settings(s)

  file_specs  = bp + '/' + ENV['TM_FLEX_FILE_SPECS']
  flex_output = bp + '/' + ENV['TM_FLEX_OUTPUT']
  fcsh       = e_sh(ENV['TM_FLEX_PATH'] + '/bin/fcsh')

  FlexMate.check_valid_paths([file_specs,flex_output,fcsh])

  mxmlc_args="mxmlc -o=#{flex_output} -file-specs=#{file_specs}"
  
  `osascript -e 'tell application "Terminal" to activate'` unless ENV['TM_FLEX_BACKGROUND_TERMINAL']
  `#{e_sh ENV['TM_BUNDLE_SUPPORT']}/lib/fcsh_terminal \"#{fcsh}\" \"#{mxmlc_args}\" >/dev/null;`

  TextMate.exit_discard
  
else
  
  STDOUT.sync = true

  c = FlexMate::Compiler.new
  c.build
  
  #TODO: Get the html window to show immediately.
  TextMate.exit_show_html

end