#!/usr/bin/env ruby -wKU

# Data provider for DIALOG and DIALOG2 Menu's.
#
# Created to translate the values stored within an instance of AsClassParser.
class AsCompletionsList

	private
	
	def initialize(class_parser)
		@cp = class_parser
		@m = []
	end
	
	public
	
	# Creates a list of class members that can be used with the TextMate::UI.menu.
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
	def list_d2
		@m = []		
		add_d2(@cp.properties)
		add_d2(@cp.gettersetters)		
		add_method_d2(@cp.methods)
		add_d2(@cp.static_properties)		
		add_method_d2(@cp.static_methods)
		return @m
	end
	
	# List of overridable getters, setters and methods.
	def overridables
		@m = []
		add(@cp.gettersetters)
		add_method(@cp.methods)
		return @m
	end
	
	# List of properties.
	def properties
		@m = []
		add(@cp.properties)
		return @m
	end
	
	private
	
	# ==========
	# = DIALOG =
	# ==========
	
	def add items
		return if items == nil
	  if items.size > 0		
			add_seperator if @m.size > 0
	  	items.each do |i|
				mi = menu_item(i)
				@m << mi unless mi == nil
			end			
	 	end
	end
	
	def add_method items
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
	
	def menu_item member
		return nil if member.to_s == ""
		{ 'title' => member, 'data' => member.to_s }
	end
	
	def method_item member

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
	
	def add_d2 items
		return if items == nil
	  items.each do |i|
			mi = menu_item_d2(i)
			@m << mi unless mi == nil
		end			
	end
	
	def menu_item_d2 member
		return nil if member.to_s == ""
		{ 'display' => member, 'data' => member.to_s, 'match' => member.sub(/\W.*$/,""), 'image' => 'Property' }
	end
	
	def add_method_d2 items
		return if items == nil
		items.each do |i|
			mi = method_item_d2(i)
			@m << mi unless mi == nil
		end
	end
	
	def method_item_d2 member

		return nil if member.to_s == ""
		
		if member =~ /(\b\w+)\s*\((.*)\)(\s*:\s*(\w+|\*))?/
			display = $1 + "()"
			typeof = $4 == nil ? "" : $4
			data = $1+"("+$2+")"
			match = display.sub(/\W.*$/,"")
		end
		
		return nil if display.to_s == ""
		
		{ 'display' => display, 'data' => data, 'typeof' => typeof, 'match' => match, 'image' => 'Method'  }
		
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
	
	class DummyClassParser
		attr_accessor :properties, :gettersetters, :methods
		attr_accessor :static_properties, :static_methods
	end
	
	class TestAsCompletionsList < Test::Unit::TestCase
				
		def test_dialog
			
			c = DummyClassParser.new
			c.properties = [ "testProperty" ]
			c.gettersetters = [ "testGetter", nil ]
			c.methods = [ 'paramaterless():Boolean', 'methodWithParams(a:Number,b:String):void', 'willFailToList' ]
			c.static_properties = [ "TEST_STATIC" ]
			c.static_methods = [ 'staticMethod():void', "", nil, "willFailToList"]

			l = AsCompletionsList.new(c)
			
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
			
			c = DummyClassParser.new
			c.properties = [ "testProperty" ]
			c.gettersetters = [ "testGetter", nil ]
			c.methods = [ 'paramaterless():Boolean', 'methodWithParams(a:Number,b:String):void', 'willFailToList' ]
			c.static_properties = [ "TEST_STATIC" ]
			c.static_methods = [ 'staticMethod():void', "", nil, "willFailToList" ]

			l = AsCompletionsList.new(c)
			
			list = l.list_d2
			#list.each_with_index { |o,i| puts "#{i} Display: '#{o['display']}' Data: '#{o['data']}' Type: '#{o['typeof']}'" }
			
			assert_equal('testProperty',  		 								  list[0]['display'])
			assert_equal('testProperty',  		 								  list[0]['match'])
			
			assert_equal('testGetter',	  		 								  list[1]['display'])
			assert_equal('testGetter',	  		 								  list[1]['match'])
			
			assert_equal('paramaterless()', 	 								  list[2]['display'])
			assert_equal('paramaterless()', 	 								  list[2]['data'])			
			assert_equal('paramaterless', 	 								  	list[2]['match'])			
			assert_equal('Boolean', 	 								  			  list[2]['typeof'])
			
			assert_equal('methodWithParams()', 								  list[3]['display'])
			assert_equal('methodWithParams(a:Number,b:String)', list[3]['data'])
			assert_equal('methodWithParams', 										list[3]['match'])			
			assert_equal('void', 																list[3]['typeof'])
			
			assert_equal('TEST_STATIC',   		 									list[4]['display'])
			assert_equal('TEST_STATIC',   		 									list[4]['match'])
			
			assert_equal('staticMethod()', 		 									list[5]['display'])			
			assert_equal('staticMethod', 		 										list[5]['match'])			
			
		end				
		
  end

end

