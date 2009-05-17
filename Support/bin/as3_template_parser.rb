#!/usr/bin/env ruby -wKU
# encoding: utf-8

require File.expand_path(File.dirname(__FILE__)) + '/../lib/flex_env'

m = ActionScript3TemplateMachine.new
c = m.process(STDIN.read)

%x{cat > #{ENV['TM_NEW_FILE']} <<GENERATED_FILE
#{c}
GENERATED_FILE}
