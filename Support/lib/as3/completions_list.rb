#!/usr/bin/env ruby -wKU
# encoding: utf-8
  
################################################################################
#
#		Copyright 2009 Simon Gregory
#		
#		This program is free software: you can redistribute it and/or modify
#		it under the terms of the GNU General Public License as published by
#		the Free Software Foundation, either version 3 of the License, or
#		(at your option) any later version.
#		
#		This program is distributed in the hope that it will be useful,
#		but WITHOUT ANY WARRANTY; without even the implied warranty of
#		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#		GNU General Public License for more details.
#		
#		You should have received a copy of the GNU General Public License
#		along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

# Data provider for DIALOG and DIALOG2 Menu's.
#
# Created to translate the values stored within an instance of ClassParser.
#
class CompletionsList

	private
	
	def initialize(class_parser)
		@cp = class_parser
		@m = []
	end
	
	public
	
	# Creates a list of class members that can be used with the TextMate::UI.menu.
	#
	def list
		@m = []		
		add(@cp.properties)
		add(@cp.gettersetters)		
		add_method(@cp.methods)
		add(@cp.static_properties)		
		add_method(@cp.static_methods)
		return @m
	end
	
	# Creates a list of class memebers that is compatible with DIALOG2
	#
	def list_d2
		@m = []		
		add_d2(@cp.properties)
		add_d2(@cp.gettersetters)		
		add_method_d2(@cp.methods)
		add_d2(@cp.static_properties, "Constant")		
		add_method_d2(@cp.static_methods)
		return @m
	end
	
	# List of overridable getters, setters and methods.
	#
	def overridables
		@m = []
		add(@cp.gettersetters)
		add_method(@cp.methods)
		return @m
	end
	
	# List of properties.
	#
	def properties
		@m = []
		add(@cp.properties)
		return @m
	end
	
	# List of properities that can be used as attributes in a mxml tag.
	#
	def attributes
		@m = []
		add(@cp.properties)
		add(@cp.gettersetters)
		add(@cp.events)
		add(@cp.styles)
		add(@cp.effects)
		return @m
	end
	
	def attributes_d2
		@m = []		
		add_d2(@cp.properties, 'Property')
		add_d2(@cp.gettersetters, 'Property')
		add_d2(@cp.effects, 'Effect')
		add_d2(@cp.events, 'Event')
		add_d2(@cp.styles, 'Style')
		return @m
	end
	
	private
	
	# ==========
	# = DIALOG =
	# ==========
	
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
				mi = method_item(i)
				@m << mi unless mi == nil
			end
		end
	end
	
	def add_seperator
		@m.push(menu_item('-'))
	end	
	
	def menu_item(member)
		return nil if member.to_s == ""
		{ 'title' => member, 'data' => member.to_s }
	end
	
	def method_item(member)

		return nil if member.to_s == ""
		
		if member =~ /(\b\w+)\s*\((.*)\)(\s*:\s*(\w+|\*))?/
			title = $1 + "()"
			typeof = $4 == nil ? "" : $4
			data = $1+"("+$2+")"
		end
		
		return nil if title.to_s == ""
		
		{ 'title' => title, 'data' => data, 'typeof' => typeof }
		
	end
	
	# ===========
	# = DIALOG2 =
	# ===========
	
	def add_d2(items, category='Property')
		return if items == nil
	  items.each do |i|
			mi = menu_item_d2(i,category)
			@m << mi unless mi == nil
		end			
	end
	
	def menu_item_d2(member, category='Property')
		return nil if member.to_s == ""
		{ 'display' => member, 'data' => member.to_s, 'match' => member.sub(/\W.*$/,""), 'image' => "#{category}" }
	end
	
	def add_method_d2(items, category='Method')
		return if items == nil
		items.each do |i|
			mi = method_item_d2(i,category)
			@m << mi unless mi == nil
		end
	end
	
	def method_item_d2(member, category='Method')

		return nil if member.to_s == ""
		
		if member =~ /(\b\w+)\s*\((.*)\)(\s*:\s*(\w+|\*))?/
			display = $1 + "()"
			typeof = $4 == nil ? "" : $4
			data = $1+"("+$2+")"
			match = display.sub(/\W.*$/,"")
		end
		
		return nil if display.to_s == ""
		
		{ 'display' => display, 'data' => data, 'typeof' => typeof, 'match' => match, 'image' => "#{category}"  }
		
	end
	
	public
	
	def list_to_log
		list.each do |o|
			puts "Title: '" 	+ o['title'].to_s		+ "'"
			puts "Data: '" 		+ o['data'].to_s 		+ "'"
			puts "Typeof: '" 	+ o['typeof'].to_s 	+ "'"
		end
	end
	
end

if __FILE__ == $0
		
	require "test/unit"
	
	class MockClassParser
		attr_accessor :properties, :gettersetters, :methods
		attr_accessor :static_properties, :static_methods
		attr_accessor :effects, :events, :styles
	end              
	                 
	class TestCompletionsList < Test::Unit::TestCase
				
		def test_dialog
			
			c = MockClassParser.new
			c.properties = [ "testProperty" ]
			c.gettersetters = [ "testGetter", nil ]
			c.methods = [ 'paramaterless():Boolean', 'methodWithParams(a:Number,b:String):void', 'willFailToList' ]
			c.static_properties = [ "TEST_STATIC" ]
			c.static_methods = [ 'staticMethod():void', "", nil, "willFailToList"]

			l = CompletionsList.new(c)
			
			list = l.list
			#list.each_with_index { |o,i| puts "#{i} Title: '#{o['title']}' Data: '#{o['data']}' Type: '#{o['typeof']}'" }
			
			assert_equal('testProperty',  		 								  list[0]['title'])
			assert_equal('-', 					  		 								  list[1]['title'])
			assert_equal('testGetter', 	  		 								  list[2]['title'])
			assert_equal('-', 	 				  		 								  list[3]['title'])
			assert_equal('paramaterless()', 	 								  list[4]['title'])
			assert_equal('paramaterless()', 	 								  list[4]['data'])
			assert_equal('Boolean', 	 								  			  list[4]['typeof'])
			assert_equal('methodWithParams()', 								  list[5]['title'])
			assert_equal('methodWithParams(a:Number,b:String)', list[5]['data'])
			assert_equal('void', 																list[5]['typeof'])
			assert_equal('-', 	  						 									list[6]['title'])
			assert_equal('TEST_STATIC',   		 									list[7]['title'])
			assert_equal('-',  					  		 									list[8]['title'])
			assert_equal('staticMethod()', 		 									list[9]['title'])			
			
		end

		def test_dialog_2
			
			c = MockClassParser.new
			c.properties = [ "testProperty" ]
			c.gettersetters = [ "testGetter", nil ]
			c.methods = [ 'paramaterless():Boolean', 'methodWithParams(a:Number,b:String):void', 'willFailToList' ]
			c.static_properties = [ "TEST_STATIC" ]
			c.static_methods = [ 'staticMethod():void', "", nil, "willFailToList" ]

			l = CompletionsList.new(c)
			
			list = l.list_d2
			#list.each_with_index { |o,i| puts "#{i} Display: '#{o['display']}' Data: '#{o['data']}' Type: '#{o['typeof']}'" }
			
			assert_equal('testProperty',  		 								  list[0]['display'])
			assert_equal('testProperty',  		 								  list[0]['match'])
			assert_equal('Property', 														list[0]['image'])
			
			assert_equal('testGetter',	  		 								  list[1]['display'])
			assert_equal('testGetter',	  		 								  list[1]['match'])
			assert_equal('Property', 														list[1]['image'])
			
			assert_equal('paramaterless()', 	 								  list[2]['display'])
			assert_equal('paramaterless()', 	 								  list[2]['data'])			
			assert_equal('paramaterless', 	 								  	list[2]['match'])			
			assert_equal('Boolean', 	 								  			  list[2]['typeof'])
			assert_equal('Method',															list[2]['image'])
						
			assert_equal('methodWithParams()', 								  list[3]['display'])
			assert_equal('methodWithParams(a:Number,b:String)', list[3]['data'])
			assert_equal('methodWithParams', 										list[3]['match'])			
			assert_equal('void', 																list[3]['typeof'])
			assert_equal('Method', 														  list[3]['image'])
			
			assert_equal('TEST_STATIC',   		 									list[4]['display'])
			assert_equal('TEST_STATIC',   		 									list[4]['match'])
			assert_equal('Property', 														list[4]['image'])
						
			assert_equal('staticMethod()', 		 									list[5]['display'])			
			assert_equal('staticMethod', 		 										list[5]['match'])			
			assert_equal('Method', 															list[5]['image'])
			
		end
		
		def test_attributes_d2
			
			c = MockClassParser.new
			
			c.properties    = [ "testProperty" ]
			c.gettersetters = [ "testGetter", nil ]
			c.effects       = [ 'testEffect' ]
			c.events        = [ 'testEvent' ]
			c.styles        = [ 'testStyle' ]
			
			l = CompletionsList.new(c)
			
			list = l.attributes_d2			
			
			assert_equal('testEffect', list[2]['display'])
			assert_equal('testEffect', list[2]['match'])			
			assert_equal('Effect', 		 list[2]['image'])

			assert_equal('testEvent',	list[3]['display'])
			assert_equal('testEvent',	list[3]['match'])			
			assert_equal('Event', 		list[3]['image'])

			assert_equal('testStyle',	list[4]['display'])
			assert_equal('testStyle',	list[4]['match'])
			assert_equal('Style', 		list[4]['image'])			
						
		end				
		
  end

end

