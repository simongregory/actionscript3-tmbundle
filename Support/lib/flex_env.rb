#!/usr/bin/env ruby -wKU

SUPPORT = "#{ENV['TM_SUPPORT_PATH']}"
BUN_SUP = File.dirname(__FILE__)

require SUPPORT + '/lib/escape'
require SUPPORT + '/lib/exit_codes'
require SUPPORT + '/lib/textmate' 
require SUPPORT + '/lib/ui'

require BUN_SUP + '/as_completions_list'
require BUN_SUP + '/class_parser'
require BUN_SUP + '/flex_mate'
