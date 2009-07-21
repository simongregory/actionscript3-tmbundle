#!/usr/bin/env ruby
# encoding: utf-8

require ENV['TM_BUNDLE_SUPPORT'] + '/lib/c_env'

begin
  
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
	else
		FlexMate.tooltip c.exit_message || 'No completions.'
	end
	
rescue SystemExit	=> e

  #recognise and pass on any legitimate exit messages (ie TextMate.exit_type)
  exit e.status
  
rescue Exception => e
	
	require ENV['TM_SUPPORT_PATH'] + '/lib/tm/htmloutput'
	
  html_out = TextMate::HTMLOutput.show(
    :title => "AutoCompletion Error",
    :sub_title => "ActionScript 3"
  ) do |io|
    io << <<-HTML		
			<h2>Exception</h2>
      <pre>#{e}</pre>
			<h2>Location</h2>
			<pre>#{e.backtrace.join("\n")}</pre>
    HTML
  end
	
  TextMate.exit_show_html(html_out)

end

