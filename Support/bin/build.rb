#!/usr/bin/env ruby
# encoding: utf-8

require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'

require File.expand_path(File.dirname(__FILE__)) + '/../lib/add_lib'

require 'find'
require 'fm/flex_mate'
require 'fm/sdk'
require 'fm/compiler'
require 'fm/settings'
require 'as3/source_tools'

#Check for custom build files and execute them where they exist.
custom = "#{ENV['TM_PROJECT_DIRECTORY']}/#{ENV['TM_FLEX_BUILD_FILE']}"
if File.file?(custom)

  if custom =~ /\.y(a)?ml$/

    require ENV['TM_BUNDLE_SUPPORT'] + '/bin/fcshd.rb'
    require ENV['TM_BUNDLE_SUPPORT'] + '/bin/as3project.rb'

    #Require being in a project
    FlexMate.require_tmproj

    #Add flex to path
    FlexMate::SDK.add_flex_bin_to_path

    #Generate the beautiful header
    FCSHD.generate_view

    #Eun the compiler and print filtered error messages
    FCSHD_SERVER.start_server if not FCSHD_SERVER.running
    AS3Project.compile
    
  elsif File.executable?(custom)
    TextMate::Process.run(custom) do |str|
      STDOUT << str
    end
  else
    puts "WARNING: #{custom} not executable."
  end
  TextMate.exit_show_html

elsif ENV['TM_PROJECT_DIRECTORY'] && (ENV['TM_FLEX_USE_FCSH'] == 'true')
  
  #Requires are needed by FlexMate.required_settings + check_valid_paths
  require ENV['TM_SUPPORT_PATH'] + '/lib/web_preview'
  require ENV['TM_SUPPORT_PATH'] + '/lib/tm/htmloutput'

  c = FlexMate::FcshCompiler.new
  c.build
  
  TextMate.exit_discard
  
else
  
  STDOUT.sync = true

  c = FlexMate::Compiler.new
  c.build
  
  #TODO: Get the html window to show immediately.
  TextMate.exit_show_html

end