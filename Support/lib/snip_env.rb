#!/usr/bin/env ruby -wKU

# Used as a common require to set up the environment for snippets.
$: << File.expand_path(File.dirname(__FILE__))

require 'as3/templates/as3_snippets'
require 'as3/templates/snippet_builder'
require 'as3/templates/snippet_provider'

require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
