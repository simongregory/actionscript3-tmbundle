#!/usr/bin/env ruby -wKU


# A Object to be used as a data provider for a TextMate::UI.menu.
#
# Created to translate the values stored within an instance of AsClassParser.
class AsCompletionsList

	def initialize(class_parser)
		@cp = class_parser
		@m = []
	end
	
	# Creates a list that specifically can be used with the TextMate::UI.menu.
	def list
		@m = []		
		add(@cp.properties)
		add(@cp.gettersetters)
		add(@cp.static_properties)
		add_method(@cp.methods)
		add_method(@cp.static_methods)
		return @m
	end
	
	def overridables
		@m = []
		add(@cp.gettersetters)
		add_method(@cp.methods)
		return @m
	end
	
	def properties
		@m = []
		add(@cp.properties)
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
