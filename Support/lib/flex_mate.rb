#!/usr/bin/env ruby -wKU

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
			str.gsub!( /([a-zA-Z0-9\:\.\*]+?)([,\)])/ ) {
				"${" + String(i+=1) + ":" + $1 + "}" + $2
			}
			str
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
  puts FlexMate.snippetize_method_params( "method(one:Number,two:String,three:*, four:Test, ...rest)")
  puts FlexMate.snippetize_method_params( "method(one:Number,
												  two:String,
												  three:*,
												  four:Test, ...rest);")

end
