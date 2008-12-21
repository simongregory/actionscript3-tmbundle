#!/usr/bin/env ruby -wKU

# Used as a common require to set up the env for commands. 

SUPPORT = "#{ENV['TM_SUPPORT_PATH']}"
BUN_SUP = File.dirname(__FILE__)

require SUPPORT + '/lib/escape'
require SUPPORT + '/lib/exit_codes'
require SUPPORT + '/lib/textmate' 
require SUPPORT + '/lib/ui'

require BUN_SUP + '/fm/flex_mate'
require BUN_SUP + '/fm/log'
require BUN_SUP + '/fm/sdk'

require BUN_SUP + '/as3/tools/source_tools'

require BUN_SUP + '/as3/parsers/class_parser'
require BUN_SUP + '/as3/parsers/property_inspector'

require BUN_SUP + '/as3/completions/completions_list'

require BUN_SUP + '/as3/templates/snippet_builder'
require BUN_SUP + '/as3/templates/snippet_provider'
require BUN_SUP + '/as3/templates/snippet_controller'