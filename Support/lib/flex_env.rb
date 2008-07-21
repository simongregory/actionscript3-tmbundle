#!/usr/bin/env ruby -wKU

SUPPORT = "#{ENV['TM_SUPPORT_PATH']}"
BUN_SUP = "#{ENV['TM_BUNDLE_SUPPORT']}"

require SUPPORT + '/lib/ui'
require SUPPORT + '/lib/exit_codes'

require BUN_SUP + '/lib/class_parser'
require BUN_SUP + '/lib/flex_mate'
require BUN_SUP + '/lib/as_completions_list'
