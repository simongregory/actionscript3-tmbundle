#!/usr/bin/env ruby -wKU

class AsCompletionsList

	def initialize(class_parser)
		@cp = class_parser
		@m = []
	end
	
	# Creates a list that specifically can be used with the TextMate::UI.menu.
	def list
		@m = []		
		add(@cp.properties)
		add(@cp.static_properties)
		add_method(@cp.methods)
		add_method(@cp.static_methods)
		return @m
	end
	
	def add(items)
		return if items == nil
	    if items.size > 0		
	        add_seperator if @m.size > 0
	        items.each do |i|
				mi = menu_item(i)
				@m << mi unless mi == nil
			end			
	    end
	
	end
	
	def add_method(items)
		return if items == nil
	    if items.size > 0
	        add_seperator if @m.size > 0
			items.each do |i|
				mi =  method_item(i)
				@m << mi unless mi == nil
			end
	    end
	end
	
	def add_seperator
		@m.push(menu_item('-'))
	end	
	
	def menu_item member
		return nil if member == ""
		{ 'title' => member, 'data' => member.to_s }
	end
	
	def method_item member

		return nil if member == ""
		
		if member =~ /(\b\w+)\s*\((.*)\)(\s*:\s*(\w+|\*))?/
			title = $1 + "()"
			typeof = $4 == nil ? "" : $4
			data = $1+"("+$2+")"
		end
    
		return nil if title.to_s == ""
	  { 'title' => title, 'data' => data, 'typeof' => typeof  }
		
	end
	
	def list_to_log
		list.each do |o|
			puts "Title: '" 	+ o['title'].to_s		+ "'"
			puts "Data: '" 		+ o['data'].to_s 		+ "'"
			puts "Typeof: '" 	+ o['typeof'].to_s 	+ "'"
		end
	end
	
end




=begin rdoc

	# Create a command with the following, tab triggered on . to view the current
	# state of autcompletion for the AS3 Bundle.
	
	#!/usr/bin/env ruby

	require ENV['TM_BUNDLE_SUPPORT']+'/lib/flex_env'

	ref = ENV['TM_CURRENT_WORD']

	c = AsClassParser.new
	c.load(STDIN.read.strip,ref)

	FlexMate.write_to_log_file(c.log)

	a = AsCompletionsList.new(c)
	m = a.list

	r = TextMate::UI.menu(m) if m.size > 0

	FlexMate.tooltip(c.exit_message)

	out = "."

	if r != nil

		out += r['data']
		out = FlexMate.snippetize_method_params(out)
		out += ";" if r['typeof'] == "void"
		TextMate.exit_insert_snippet(out)

	else
		out = ";" if c.return_type_void
		TextMate.exit_insert_text(out)
	end
	
=end