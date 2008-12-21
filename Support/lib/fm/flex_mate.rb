#!/usr/bin/env ruby -wKU

# Utility module which collects together common tasks used by commands within the
# ActionScript 3 and Flex Bundles.
#
module FlexMate

	class << self
		
		# ==================
		# = TEXTMATE UTILS =
		# ==================
		
		# Make sure an environment variable is set.
		#
		def require_var(evar)
			if !ENV[evar]

				puts html_head(:window_title => "Missing Environment Variable", :page_title => "Missing Environment Variable", :sub_title => "")

				puts <<-HTMOUT
					<h2>Environement var missing</h2>
					<p>Please define the environment variable <code>#{evar}</code>.
					<br><br>
					Configuration help can be found <a href="tm-file://$TM_BUNDLE_SUPPORT/html/help.html#conf">here.</a></p>
				HTMOUT

				TextMate.exit_show_html

			end
		end

		# Make sure a file exists at the defined location.
		#
		def require_file(file)

			if !File.exist?(file)

				puts html_head(:window_title => "File not found", :page_title => "File not found", :sub_title => "")

				print <<-HTMOUT
					<h2>#{file} 404</h2>
					<p>The environment variable <code>#{file}</code> does not resolve to an actual file.
					<br><br>
					Configuration help can be found <a href="tm-file://#{ENV['TM_BUNDLE_SUPPORT']}/html/help.html#conf">here.</a></p>
				HTMOUT

				TextMate.exit_show_html

			end
		end
		
		# Many of the commands only work from a project scope.
		#
		# This checks for the existence of a project, then sets $TM_PROJECT_DIR 
		# to work from.
		#
		def cd_to_tmproj_root

		  unless ENV['TM_PROJECT_FILEPATH']
		      TextMate.exit_show_tool_tip "This Command should only be run from within a saved TextMate Project."
		  end

		  ENV['TM_PROJECT_DIR'] = File.dirname( ENV['TM_PROJECT_FILEPATH'] )

		  #TODO: IS THIS EQUIVALENT POSSIBLE/USEFUL...
		  `cd #{ENV['TM_PROJECT_DIR']}`

		end
		
		# =================
		# = SNIPPET UTILS =
		# =================
		
		def snippetize_method_params(str)
			i=0
			str.gsub!( /\n|\s/,"")
			str.gsub!( /([a-zA-Z0-9\:\.\*=]+?)([,\)])/ ) {
				"${" + String(i+=1) + ":" + $1 + "}" + $2
			}
			str
		end
		
		# ===============
		# = UI + DIALOG =
		# ===============
		
		# Show a DIALOG 2 tool tip if dialog 2 is available.
		# Used where a tooltip needs to be displayed in conjunction with another
		# exit type.
		#
		def tooltip(message)

			return if message.to_s == ""
			
			if has_dialog2
				`"$DIALOG" tooltip <<< "#{message}"`
			end
			
		end
		
		# Invoke a completions dialog.
		#
		def complete(choices,filter=nil,exit_message=nil)
			
			if choices[0]['display'] == nil
				puts "Error, was expecting Dialog2 compatable data."
				exit
			end

			pid = fork do
      	
				STDOUT.reopen(open('/dev/null'))
      	STDERR.reopen(open('/dev/null'))			

				if has_dialog2

					# "$DIALOG" help popup
					# Presents the user with a list of items which can be filtered down by typing to select the item they want.
					# 
					# popup usage:
					# "$DIALOG" popup «options» <<<'{ suggestions = ( { title = "foo"; }, { title = "bar"; } ); }'
					# 
					# Options:
					#  -f, --initial-filter       Sets the text which will be used for initial filtering of the suggestions.
					#  -s, --static-prefix        A prefix which is used when filtering suggestions.
					#  -e, --extra-chars          A string of extra characters which are allowed while typing.
					#  -i, --case-insensitive     Case is ignored when comparing typed characters.
					#  -x, --shell-cmd            When the user selects an item, this command will be passed the selection on STDIN, and the output will be written to the document.
					#  -w, --wait                 Causes the command to not return until the user has selected an item (or cancelled).

					# Although the above help command says to use 'title', it appears (if you
					# look in the review ui.rb) that 'display' is needed.
										
					icon_dir = "#{BUN_SUP}/../icons"
					
					images = {
			      "Method"   => "#{icon_dir}/Method.png",
			      "Property" => "#{icon_dir}/Property.png",
			      "Effect"   => "#{icon_dir}/Effect.png",
			      "Event"    => "#{icon_dir}/Event.png",
			      "Style"    => "#{icon_dir}/Style.png",
			      "Constant" => "#{icon_dir}/Constant.png",
			      "Getter"   => "#{icon_dir}/Getter.png",
			      "Setter"   => "#{icon_dir}/Setter.png"
			    }					
					
					command = "#{TM_DIALOG} popup --wait"					
					command << " --alreadyTyped #{e_sh filter}" if filter != nil
					command << " --additionalWordCharacters '_'"

					result = nil
					
					plist = { 'suggestions' => choices }
					plist['images'] = images
					
					IO.popen(command, 'w+') do |io|
            io << plist.to_plist
            io.close_write
            result = OSX::PropertyList.load io rescue nil
          end
					
					return nil if result == nil
					return nil unless result.has_key? 'index'
	        i = result['index'].to_i
					r = choices[i]
					m = r['match']
					
					to_insert = r['data']
					to_insert.sub!( "#{m}", "")
					to_insert = self.snippetize_method_params(to_insert)
					to_insert += ";" if r['typeof'] == "void" 
					
					self.tooltip exit_message
          
					# Insert the snippet if necessary
          `"$DIALOG" x-insert #{e_sh to_insert}` unless to_insert.empty?

				else

					 self.tooltip "Dialog2 is required for this command.\n:)"
					
				end
			end

		end
		
		# Returns true if Dialog 2 is available.
		#
		def has_dialog2
			tm_dialog = e_sh ENV['DIALOG']
			! tm_dialog.match(/2$/).nil? 
		end
		
		# ======================
		# = SYSTEM/ENVIRONMENT =
		# ======================
		
		# Returns true if OS X 10.5 (Leopard) is available.
		#
		def check_for_leopard
			
			os = `defaults read /System/Library/CoreServices/SystemVersion ProductVersion`
			
			return true if os =~ /10\.5\./
			return false
			
		end
		
	end

end   

if __FILE__ == $0
  	
  puts "\nsnippetize_method_params:"
  puts FlexMate.snippetize_method_params( "method(one:Number,two:String,three:*, four:Test=10, ...rest)")  
  puts FlexMate.snippetize_method_params( "method(one:Number,
												  two:String,
												  three:*,
												  four:Test, ...rest);")
	
	#TODO/FIX: Following line fails.
	puts FlexMate.snippetize_method_params( "method(zero:Number,four:String=\"chalk\",six:String=BIG_EVENT,three:Boolean=true)")												

	print "\ncheck_for_leopard: "
	puts FlexMate.check_for_leopard

	FlexMate.tooltip("Test Message")
	
	puts "\nhas_dialog2:"
	puts FlexMate.has_dialog2.to_s
   
end
