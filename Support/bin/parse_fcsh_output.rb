#!/usr/bin/env ruby18 -wKU
# encoding: utf-8

SUPPORT = ENV['TM_SUPPORT_PATH']
BUN_SUP = File.expand_path(File.dirname(__FILE__)) + '/..'

require SUPPORT + '/lib/exit_codes'
require SUPPORT + '/lib/textmate'
require SUPPORT + '/lib/web_preview'
require BUN_SUP + '/lib/fm/mxmlc_exhaust'

puts html_head(:window_title => "ActionScript 3", :page_title => "Format fcsh Output" );

fcsh_output = `"#{BUN_SUP}/lib/read_fcsh_terminal_output"`

TextMate.exit_show_tool_tip fcsh_output if fcsh_output =~ /fcsh terminal window not found./

compile = []

#flag to determine how many instances of (fcsh) we have encountered
store = false

#starting at the bottom of the file, mark the first (fcsh), store intermediate 
#lines, then stop at the next (fcsh)
fcsh_output.split( "\n" ).reverse.each do |line|
    if line =~ /^\(fcsh\)/
        break if store
        store = true
    elsif store
        compile << line
    end
end

ex = MxmlcExhaust.new
compile.reverse.each { |ln| ex.line(ln) }
ex.complete
