#!/usr/bin/env ruby -wKU

# Designed to scan from the caret location within the current document and 
# output a string that can be used by the class parser to load and store the 
# properteries, methods etc of the resulting class reference.
module AsPropertyInspector

		# Finds and returns a 'Property Chain' ie foo.bar.baz based on the 
		# current line. 
		#
		# Where it finds an object that has been type cast it's
		# class is insterted into the chain not it's property name. So
		# foo.( bar as Sprite ).baz becomes foo.Sprite.baz
		def self.property_chain
			
			li = ENV['TM_LINE_INDEX'] 
			ln = ENV['TM_CURRENT_LINE']
			la = ln.split("")
			i = li.to_i-1
			
			# When we are on a completly blank line return "this"
			if ln =~ /^\s*$/
				return "this"
			end
			
			# Stop looking when we hit these chars.
			stop_match = /[\s=;,:"']/
			
			# Casting using the as operator.
			as_regexp = /\bas\b\s+(\w+)/
			
			# Holds the cars found
			found = []
			bracket_contents = []
			
			# int to track the level of nesting.
			nests = 0;

			while i >= 0

				current_letter = la[i]

				# Make sure we stop if we hit a closing nest char.
				break if current_letter == "("
				
				if current_letter =~ /\)/
					
					while i >= 0
						
						current_letter = la[i]
						i -= 1
						
						if current_letter =~ /\)/
							nests += 1
						elsif current_letter =~ /\(/
							nests -= 1
						end	
						
						if nests == 0
							
							if bracket_contents.reverse.to_s =~ as_regexp
								found << $1
							end
							break
							
						end
						
						bracket_contents << current_letter
						
					end
				end
				
				break if current_letter =~ stop_match
				next if current_letter =~ /[()]/
				found << current_letter
				i -= 1

			end

			found.reverse!
			
			# Searches forward from the caret. 
			#i = li.to_i
			#while i < la.length
			#	
			# 	current_letter = la[i]
			# 	break if current_letter =~ stop_match
			# 	break if current_letter == "("
			# 	found << current_letter
			# 	i += 1
			#
			#end

			# Search for casting.
			if found.empty?
				if bracket_contents.reverse.to_s =~ as_regexp
					return $1
				end
			end
			
			return nil if found.empty?
			
			chain = found.to_s
			chain.chop! if chain =~ /\.$/
			
			return chain
		
		end
		
		# Tests to see if the caret is currently at a class reference or a 
		# property instance name.
		#
		# NOTE: Relies entierly on the convention that classes start with an 
		# uppercase character.
		def self.is_static

			li = ENV['TM_LINE_INDEX'] 
			ln = ENV['TM_CURRENT_LINE']
			la = ln.split("")
			i = li.to_i-1

			last_c = ""
			
			while i >= 0
				
				c = la[i]
				
				unless c =~ /[\w.]/
					if last_c =~ /[A-Z]/
						before = la[0..i].join()
						return false if before =~ /new\s+$/
						return true 
					end
					return false
				end
				
				last_c = c
				i -= 1
				
			end
			return false
		end
		
		# Return a boolean depending on whether the caret is just after a '.'
		def self.at_dot
			li = ENV['TM_LINE_INDEX'] 
			ln = ENV['TM_CURRENT_LINE']
			la = ln.split("")
			i = li.to_i-1
			return true if la[i] == "."
			return false
		end
		
		# Should autocompletion insert a dot before the completed statement. 
		def self.insert_dot
			li = ENV['TM_LINE_INDEX'] 
			ln = ENV['TM_CURRENT_LINE']
			la = ln.split("")
			i = li.to_i-1
			return false if la[i] =~ /(\.|\s)/
			return true
		end
		
end
 
if __FILE__ == $0
	
	ENV['TM_CURRENT_LINE'] = <<-EOF
  basicMethod( One(one), [[two,three], "four"] )    Sprite.  
	EOF
	
	ENV['TM_LINE_INDEX'] = '48'
	puts "Property Chain: " + AsPropertyInspector.property_chain.to_s
	
	ENV['TM_LINE_INDEX'] = '59'
	puts "Is Static: " + AsPropertyInspector.is_static.to_s
	puts "\nStarting Tests:"
	
	require "test/unit"
	
	class TestAsPropertyInspector < Test::Unit::TestCase
		
		# ========================
		# = property_chain Tests =
		# ========================
		
		def test_property
			
			ENV['TM_CURRENT_LINE'] = <<-EOF
      basicProperty.                           
			EOF
			
			ENV['TM_LINE_INDEX']   = '19'
			assert_equal 'basicProperty', AsPropertyInspector.property_chain

			ENV['TM_LINE_INDEX']   = '20'
			assert_equal 'basicProperty', AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX']   = '0'
			assert_equal nil, AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX']   = '5'
			assert_equal nil, AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX']   = '47'
			assert_equal nil, AsPropertyInspector.property_chain
			
		end
		
		def test_method
			
			ENV['TM_LINE_INDEX']   = '20'
			ENV['TM_CURRENT_LINE'] = <<-EOF
      simpleMethod()
			EOF
			
			assert_equal 'simpleMethod', AsPropertyInspector.property_chain
			
		end
		
		def test_method_with_basic_parameters
			
			ENV['TM_LINE_INDEX']   = '47'
			ENV['TM_CURRENT_LINE'] = <<-EOF
      parameterisedMethodCall( "hello", world )
			EOF
			
			assert_equal 'parameterisedMethodCall', AsPropertyInspector.property_chain
			
		end

		def test_method_with_nested_parameters
			
			ENV['TM_LINE_INDEX']   = '60'
			ENV['TM_CURRENT_LINE'] = <<-EOF
      paramaterisedMethodCall( ["hello" , 'world' ], foo() )
			EOF
			
			assert_equal 'paramaterisedMethodCall', AsPropertyInspector.property_chain

		end
		
		def test_property_chain
			
			ENV['TM_CURRENT_LINE'] = <<-EOF
      one.two().three.four( TypeCast(five) )
			EOF
			
			ENV['TM_LINE_INDEX']   = '26'
			assert_equal 'one.two.three.four', AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX']   = '44'
			assert_equal 'one.two.three.four', AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX']   = '42'
			assert_equal 'TypeCast', AsPropertyInspector.property_chain
			
		end
		
		def test_as_cast
			
			ENV['TM_LINE_INDEX']   = '24'
			ENV['TM_CURRENT_LINE'] = <<-EOF
      ( hello as World )
			EOF
			
			assert_equal 'World', AsPropertyInspector.property_chain
			
		end
		
		def test_with_nested_casting
			
			ENV['TM_LINE_INDEX']   = '35'
			ENV['TM_CURRENT_LINE'] = <<-EOF
      a.big.( hello as World ).here
			EOF
			
			assert_equal 'a.big.World.here', AsPropertyInspector.property_chain
			
		end
		
		def test_with_nested_comments
			
			ENV['TM_LINE_INDEX']   = '54'
			ENV['TM_CURRENT_LINE'] = <<-EOF
      doSomething( /* with some (annoying) content*/ )
			EOF
			
			assert_equal 'doSomething', AsPropertyInspector.property_chain
			
		end
		
		def test_new_constructor
			
			ENV['TM_CURRENT_LINE'] = <<-EOF
      var e:TypicalEvent = new TypicalEvent( TypicalEvent.SAY_HELLO );
			EOF
			
			ENV['TM_LINE_INDEX'] = '11'
			assert_equal 'e', AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '69'
			assert_equal 'TypicalEvent', AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '58'
			assert_equal 'TypicalEvent', AsPropertyInspector.property_chain

			ENV['TM_LINE_INDEX'] = '67'
			assert_equal 'TypicalEvent.SAY_HELLO', AsPropertyInspector.property_chain
			
		end
		
		def test_multliline_method
			
			ENV['TM_CURRENT_LINE'] = <<-EOF
      "foo" ).here
			EOF
			
			ENV['TM_LINE_INDEX']   = '18'
			assert_equal '.here', AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX']   = '13'
			assert_equal nil, AsPropertyInspector.property_chain
			
		end
		 
		def test_blank
			
			ENV['TM_CURRENT_LINE'] = <<-EOF
                                        
			EOF
			
			ENV['TM_LINE_INDEX'] = '0'
			assert_equal "this", AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '20'
			assert_equal "this", AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '40'
			assert_equal "this", AsPropertyInspector.property_chain
			
		end

		def test_no_whitespace
			
			ENV['TM_CURRENT_LINE'] = <<-EOF
      _menu.removeEventListener(MenuEvent,handleMenuClosed);
			EOF
			
			ENV['TM_LINE_INDEX'] = '12'
			assert_equal "_menu", AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '31'
			assert_equal "_menu.removeEventListener", AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '41'
			assert_equal "MenuEvent", AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '42'
			assert_equal nil, AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '58'
			assert_equal "handleMenuClosed", AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '59'
			assert_equal "_menu.removeEventListener", AsPropertyInspector.property_chain
			
			ENV['TM_LINE_INDEX'] = '60'
			assert_equal nil, AsPropertyInspector.property_chain
			
		end
		
		# ===================
		# = is_static tests =
		# ===================
		
		def test_static
			
			ENV['TM_CURRENT_LINE'] = <<-EOF
      Math. notStatic     Math().   new Bottle().cider
			EOF
			
			ENV['TM_LINE_INDEX'] = '11'
			assert_equal true, AsPropertyInspector.is_static
			
			ENV['TM_LINE_INDEX'] = '10'
			assert_equal true, AsPropertyInspector.is_static
			
			ENV['TM_LINE_INDEX'] = '21'
			assert_equal false, AsPropertyInspector.is_static
			
			ENV['TM_LINE_INDEX'] = '24'
			assert_equal false, AsPropertyInspector.is_static
			
			ENV['TM_LINE_INDEX'] = '33'
			assert_equal false, AsPropertyInspector.is_static
			
			ENV['TM_LINE_INDEX'] = '31'
			assert_equal false, AsPropertyInspector.is_static
			
			ENV['TM_LINE_INDEX'] = '30'
			assert_equal true, AsPropertyInspector.is_static
			
			ENV['TM_LINE_INDEX'] = '46'
			assert_equal false, AsPropertyInspector.is_static
			
			ENV['TM_LINE_INDEX'] = '54'
			assert_equal false, AsPropertyInspector.is_static
			
		end

		# ====================
		# = insert_dot tests =
		# ====================
		
		def test_insert_dot
			
			ENV['TM_CURRENT_LINE'] = <<-EOF
      property. property            
			EOF
			
			ENV['TM_LINE_INDEX'] = '6'
			assert_equal false, AsPropertyInspector.insert_dot
			
			ENV['TM_LINE_INDEX'] = '24'
			assert_equal true, AsPropertyInspector.insert_dot
			
			ENV['TM_LINE_INDEX'] = '15'
			assert_equal false, AsPropertyInspector.insert_dot
			
			ENV['TM_LINE_INDEX'] = '30'
			assert_equal false, AsPropertyInspector.insert_dot
			
		end
		
  end

end
