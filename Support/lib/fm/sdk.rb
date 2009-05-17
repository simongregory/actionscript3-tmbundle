#!/usr/bin/env ruby -wKU
# encoding: utf-8

module FlexMate

	module SDK

    class << self
	
			# Fallback Search locations for the flex sdk if they are not specified in
			# the environmental variable TM_FLEX_SDK_SEARCH_PATHS. See the 'Settings' 
			# bundle preference for the active list.
			#
			FLEX_DIRS = [ "/Developer/SDKs/flex_sdk_3",
                    "/Developer/SDKs/flex_sdk_3.3.0",
                    "/Developer/SDKs/flex_sdk_3.2.0",										
										"/Developer/SDKs/flex_sdk_3.1.0",
                    "/Developer/SDKs/flex_sdk_3.0.2",										
										"/Applications/flex_sdk_3",
										"/Applications/flex_sdk_2",
										"/Applications/Flex",
										"/Applications/Adobe Flex Builder 3/sdks/3.0.0",
										"/Applications/Adobe Flex Builder 3/sdks/2.0.1",
										"/Applications/Adobe Flex Builder 2/Flex SDK 2",
										"/Developer/Applications/Adobe Flex Builder 2/Flex SDK 2",
										"/Developer/SDKs/flex_sdk_2",
										"/Developer/SDKs/Flex",
										"/Developer/SDKs/FlexSDK2",
										"/Developer/Applications/Flex",
										"/Developer/Applications/flex_sdk_2",
										"/Developer/Applications/FlexSDK2"
      ]

			SDK_SRC_PATHS = [ "/frameworks/source/mx/", 
												"/frameworks/projects/framework/src"
			]
		
			# Return the first Flex SDK directory found in the list.
			#
			def dir_check
				return sdk_dir_arr.find { |dir| File.directory? dir }
			end

			# Returns a : seperated list of locations the flex sdk may commonly 
			# be found.
			#
			def sdk_dir_list
				src_dirs = ENV['TM_FLEX_SDK_SEARCH_PATHS'] || FLEX_DIRS.join(":")
				src_dirs
			end
    
			# Returns an array of possilbe Flex SDK paths.
			#
			def sdk_dir_arr
				sdk_dir_list.split(":")
			end
    
			# Returns either the user defined Flex SDK path, or the first sdk found
			# in the FLEX_DIRS array.
			#
			def find_sdk
	
				user_path = ENV['TM_FLEX_PATH']
				if user_path
					return user_path if File.directory? user_path
				end

				return dir_check
	
			end
		
			# Locates the currently specified, or default Flex SDK and returns the 
			# path to it's  source directory.
			#
			def src
   
				sdk_path = find_sdk
				unless sdk_path == nil
					SDK_SRC_PATHS.each { |sp|
						p = sdk_path+sp
						return p if File.directory? p
					}
				end
 
			end
		
			# Search FLEX_DIRS list for the Flex SDK, if it exists then set it to the the TM_FLEX_PATH variable.
			# returns 0 for success, 1 for failure.
			#
			def set_tm_flex_path

				unless ENV['TM_FLEX_PATH']
					ENV['TM_FLEX_PATH'] = e_sh(dir_check)
				end

				if ENV['TM_FLEX_PATH']
					return 0; # Succeed
				else
					return 1; # Fail
				end
			end
		
			# Print the directories searched when trying to find the users Flex SDK.
			#
			def show_search_list
			    sdk_dir_arr.each { |dir| puts dir }
			end
		
			# Attempts to find the Flex SDK directory and set it to $TM_FLEX_PATH.
			# If it fails then a html help window is shown to the user, or if 
			# -t is supplied then a tooltip.
			#
			def set_flex_path(exit_with_tooltip="")

			  if set_tm_flex_path == 1

			      if exit_with_tooltip == "-t"
			          print "Please define the environment variable TM_FLEX_PATH and point it to your Flex SDK directory."
			          TexMate.exit_show_tool_tip;
			      end

			      puts html_head(:window_title => "Help files 404", :page_title => "Help files 404", :sub_title => "")

			      print <<-HTMOUT
			              <h2>Help not found</h2>
			              <p>Please define the environment variable <code>TM_FLEX_PATH</code> and point it to your Flex SDK directory.<br>
			              Installation and configuration help can be found <a href="$TM_BUNDLE_SUPPORT/html/help.html#installation">here.</a></p>
			      HTMOUT

			      TextMate.exit_show_html
			  		#else
			      #`export TM_FLEX_PATH="$TM_FLEX_PATH";`
			  end
			end
		
			# Searches flex install directory list and adds the first found_dir/bin to 
			# the PATH. This should mean that mxmlc, fcsh etc are invokeable.
			#
			def add_flex_bin_to_path

				set_tm_flex_path unless ENV['TM_FLEX_PATH']

				if ENV['TM_FLEX_PATH']
					ENV['PATH'] = "#{ENV['PATH']}:#{ENV['TM_FLEX_PATH']}/bin"
					return true;
				else
					return false;
				end

			end
      
			# Attemps to locate and open the main compiler configuration file.
			#
			# This is normally found at {flex_sdk}/frameworks/flex-config.xml
			#
			def open_flex_config
				
				config = find_sdk + "/frameworks/flex-config.xml"

				if File.exists?(config)
					TextMate.go_to(:file => config)
				else
					TextMate.exit_show_tool_tip('Unable to locate Flex SDK and it\'s associated flex-config.xml file.')
				end				
			end

		end
		
	end
	
end

if __FILE__ == $0
  
	require "#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes"
	require "#{ENV['TM_SUPPORT_PATH']}/lib/textmate"
	
  puts "\nsdk_dir_list:"
  puts FlexMate::SDK.sdk_dir_list

  puts "\nsdk_dir_arr:"
  puts FlexMate::SDK.sdk_dir_arr
  
  puts "\ndir_check:"
  puts FlexMate::SDK.dir_check.to_s

  puts "\nfind_sdk:"
  puts FlexMate::SDK.find_sdk.to_s

  puts "\nsrc:"
  puts FlexMate::SDK.src
  
	FlexMate::SDK.open_flex_config
	
end