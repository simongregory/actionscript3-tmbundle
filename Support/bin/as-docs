#!/usr/bin/env ruby -wKU
# encoding: utf-8

scope = ENV['TM_SCOPE']

require ENV['TM_SUPPORT_PATH']   + '/lib/exit_codes'
require ENV['TM_SUPPORT_PATH']   + '/lib/escape'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/fm/fcd'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/fm/asd'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/fm/sdk'

if scope =~ /text\.xml\.flex-config/
	TextMate.exit_show_tool_tip FlexConfigDoc.new.find(scope)
end

FlexMate::SDK.set_tm_flex_path
FlexMate::ASD.find(STDIN.read.strip)
