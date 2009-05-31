#!/usr/bin/env ruby
# encoding: utf-8

require ENV['TM_BUNDLE_SUPPORT'] + '/lib/c_env'

FlexMate.complete_by_scope if ENV['TM_SCOPE'] =~ /support\.function\.(top-level|flash|fl|mx|global)\.actionscript\.3/

FlexMate.opt_in_to_completions

p = PropertyInspector.capture
TextMate.exit_show_tool_tip("No property found.") if p[:ref] == nil

c = ClassParser.new

#cp = ConfigParser.new(true)
#cp.src_paths.each { |p| puts p }  

if p[:is_static]
	c.load_statics(STDIN.read.strip,p[:ref])
else
	c.load(STDIN.read.strip,p[:ref])
end

FlexMate::Log.puts(c.log)

a = CompletionsList.new(c)

m = a.list_d2
if m.size > 0
	FlexMate.complete(m,p[:filter],c.exit_message)
	exit
end

FlexMate.tooltip c.exit_message || 'No completions.'
