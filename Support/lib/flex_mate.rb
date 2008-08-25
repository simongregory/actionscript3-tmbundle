#!/usr/bin/env ruby -wKU

# Utility module which collects together common tasks used by commands within the
# ActionScript 3 and Flex Bundles.
module FlexMate

	class << self

		# Fallback Search locations for the flex sdk if they are not specified in the 
		# environmental variable TM_FLEX_SDK_SEARCH_PATHS
		FLEX_DIRS = [ "/Developer/SDKs/flex_sdk_3",
									"/Developer/SDKs/flex_sdk_3.0.2",
									"/Applications/flex_sdk_3",
									"/Applications/flex_sdk_2",
									"/Applications/flex_sdk_2.0.1",
									"/Applications/FlexSDK2",
									"/Applications/Flex",
									"/Applications/FlexSDK2.0.1",
									"/Applications/Adobe Flex Builder 3/sdks/3.0.0",
									"/Applications/Adobe Flex Builder 3/sdks/2.0.1",
									"/Applications/Adobe Flex Builder 2/Flex SDK 2",
									"/Developer/Applications/Adobe Flex Builder 2/Flex SDK 2",
									"/Developer/SDKs/flex_sdk_2",
									"/Developer/SDKs/Flex",
									"/Developer/SDKs/FlexSDK2",
									"/Developer/Applications/Flex",
									"/Developer/Applications/flex_sdk_2",
									"/Developer/Applications/FlexSDK2" ]

		SDK_SRC_PATHS = [ "/frameworks/source/mx/", "/frameworks/projects/framework/src" ]
		
		LOG_FILE = "#{e_sh ENV['HOME']}/Library/Logs/TextMate ActionScript 3.log"

		#Return the first Flex SDK directory found in the list.
		def dir_check
		    return sdk_dir_arr.find { |dir| File.directory? dir }
		end

		# Returns a : seperated list of locatons the flex sdk may commonly be found.
		def sdk_dir_list
			src_dirs = ENV['TM_FLEX_SDK_SEARCH_PATHS']
			src_dirs = FLEX_DIRS.join(":") if src_dirs == nil
			src_dirs
		end

		def sdk_dir_arr
			sdk_dir_list.split(":")
		end

		def find_sdk
	
			user_path = ENV['TM_FLEX_PATH']
			if user_path
				return user_path if File.directory? user_path
			end

			return dir_check
	
		end

		def find_sdk_src
   
			sdk_path = find_sdk
			unless sdk_path == nil
				SDK_SRC_PATHS.each { |sp|
					p = sdk_path+sp
					return p if File.directory? p
				}
			end
 
		end
		
		def snippetize_method_params(str)
			i=0
			str.gsub!( /\n|\s/,"")
			str.gsub!( /([a-zA-Z0-9\:\.\*=]+?)([,\)])/ ) {
				"${" + String(i+=1) + ":" + $1 + "}" + $2
			}
			str
		end
		
		# initilialize / clear the log.
		def initialize_log
			f = File.open(LOG_FILE, "w")
			f.close			
		end
		
		def write_to_log_file(text)
			
			initialize_log unless File.exist?(LOG_FILE)
			
			# Append text.
		  f = File.open(LOG_FILE, "a")
		  f.puts Time.now.strftime("\n[%m/%d/%Y %H:%M:%S]") + " TextMate::ActionScript 3.tmbundle"
		  f.puts text
		  f.flush
		  f.close
		
		end
		
		# Show a DIALOG 2 tool tip if dialog 2 is available.
		# Used where a tooltip needs to be displayed in conjunction with another
		# exit type.
		# TODO: Move to seperate ui and extend TextMate::UI
		def tooltip(message)

			return if message.to_s == ""
			
			if is_dialog2
				`"$DIALOG" tooltip <<< "#{message}"`
			end
			
		end
		
		def complete(choices,filter=nil,exit_message=nil)
			
			if choices[0]['display'] == nil
				puts "Error, was expecting Dialog2 compatable data."
				exit
			end

			pid = fork do
      	
				STDOUT.reopen(open('/dev/null'))
      	STDERR.reopen(open('/dev/null'))			

				if is_dialog2

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
					command << " --initial-filter #{e_sh filter}" if filter != nil
					command << " --extra-chars '_'"

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
					
					#`"$DIALOG" tooltip <<< "#{exit_message}"` unless exit_message == nil
					self.tooltip exit_message
          
					# Insert the snippet if necessary
          `"$DIALOG" x-insert #{e_sh to_insert}` unless to_insert.empty?

				else

					 self.tooltip "Dialog2 is required for this command.\n:)"
					
				end
			end

		end
		
		def check_for_leopard
			
			os = `defaults read /System/Library/CoreServices/SystemVersion ProductVersion`
			
			return true if os =~ /10\.5\./
			return false
			
		end
		
		def is_dialog2
			tm_dialog = e_sh ENV['DIALOG']
			! tm_dialog.match(/2$/).nil? 
		end
		
	end

end   

if __FILE__ == $0
  
  puts "\nsdk_dir_list:"
  puts FlexMate.sdk_dir_list

  puts "\nsdk_dir_arr:"
  puts FlexMate.sdk_dir_arr
  
  puts "\ndir_check:"
  puts FlexMate.dir_check.to_s

  puts "\nfind_sdk:"
  puts FlexMate.find_sdk.to_s

  puts "\nfind_sdk_src:"
  puts FlexMate.find_sdk_src
	
  puts "\nsnippetize_method_params:"
  puts FlexMate.snippetize_method_params( "method(one:Number,two:String,three:*, four:Test=10, ...rest)")  
  puts FlexMate.snippetize_method_params( "method(one:Number,
												  two:String,
												  three:*,
												  four:Test, ...rest);")
	
	#TODO/FIX: Following line fails.
	puts FlexMate.snippetize_method_params( "method(zero:Number,four:String=\"chalk\",six:String=BIG_EVENT,three:Boolean=true)")												

  FlexMate.write_to_log_file("Test Text")

	print "\ncheck_for_leopard: "
	puts FlexMate.check_for_leopard

	FlexMate.tooltip("Test Message")
	
	puts "\nis_dialog2:"
	puts FlexMate.is_dialog2.to_s
   
end
