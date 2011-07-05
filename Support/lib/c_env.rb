#!/usr/bin/env ruby -wKU
# encoding: utf-8

# Used as a common require to set up the environment for completion commands.
$: << File.expand_path(File.dirname(__FILE__))

require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

require 'fm/flex_mate'
require 'fm/log'
require 'fm/sdk'
require 'fm/as3project'

require 'as3/completions_list'
require 'as3/parsers/class_parser'
require 'as3/parsers/config'
require 'as3/parsers/property_inspector'
require 'as3/source_tools'
