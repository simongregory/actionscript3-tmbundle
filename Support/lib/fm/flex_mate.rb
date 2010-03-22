#!/usr/bin/env ruby -wKU
# encoding: utf-8

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
			unless ENV[evar]

				TextMate::HTMLOutput.show(:title => "Missing Environment Variable", :sub_title => "" ) do |io|

					io << '<h2>Environment var missing</h2>'
					io << "<p>Please define the environment variable <code>#{evar}</code>.<br><br>"
					io << configuration_help()
					io << "</p>"

				end

			end
		end

		# Make sure a file exists at the defined location.
		#
		def require_file(file)
			unless File.exist?(file)

				TextMate::HTMLOutput.show(:title => "File not found", :sub_title => "" ) do |io|

					io << "<h2>#{file} 404</h2>"
					io << "<p>The environment variable <code>#{file}</code> does not resolve to an actual file.<br><br>"
					io << configuration_help()
					io << "</p>"

				end

			end
		end

		# Preferences window
		#
		def opt_in_to_completions

			# To revert for testing use:
			#defaults write com.macromates.textmate.flexmate autocomplete_on 'false'

			unless `defaults read com.macromates.textmate.flexmate autocomplete_on`.chop! == "true"

				TextMate::HTMLOutput.show(:title => "Autocompletion Preferences", :sub_title => "" ) do |io|

					io << "<h2>Enable Auto Completion</h2>"
					io << "<p>Completion support is in an <b>experiemental alpha</b> state, which means:</p>"
					io << "<ul>"
					io << "<li>It is very likely to break.</li>"
					io << "<li>Functionality will change.</li>"
					io << "<li>Help and support is thin on the ground.</li>"
					io << "<li>Feedback &amp; Patches are most welcome.</li>"
					io << "</ul>"
					io << "<p><div id='msg'>If you are happy with this state of affairs please click <a href='javascript:optIn()'>here</a> to enable it.</div>"
					io << "</p>"
					io << '<script type="text/javascript" charset="utf-8">function optIn(){TextMate.system(\'defaults write com.macromates.textmate.flexmate autocomplete_on true\', null); document.getElementById(\'msg\').innerText="Happy Coding!";}</script>'

				end

				TextMate.exit_show_html

			end

		end

		# Checks that the supplied environmental variables and files that they point
		# to exist. When they don't a html window is invoked and each failure is
		# listed.
		#
		def required_settings(settings={})

			failed_evars = []
			failed_files = []
			
			base_path = settings[:base_path] || ''
			files = settings[:files] || []
			evars = settings[:evars] || []

      base_path += '/' unless base_path =~ /\/$/
      
			files.each { |f|				
				failed_files << f unless ENV[f]
				failed_files << f unless File.exist?( base_path + ENV[f].to_s || "" )
			}

			evars.each { |e|
				failed_evars << e unless ENV[e]
			}

			unless failed_evars.empty? && failed_files.empty?

				TextMate::HTMLOutput.show(:title => "Missing Settings", :sub_title => "" ) do |io|

					io << "<h2>Missing Settings</h2>"

					failed_files.each { |f| io << "<p>The environment variable <code>#{f}</code> does not resolve to an actual file.<br>" }
					failed_evars.each { |e| io << "<p>The environment variable <code>#{e}</code> was not defined.<br>" }

					io << '<br/>'+configuration_help

				end

				TextMate.exit_show_html

			end

		end

		# Returns html link to configuration help.
		#
		def configuration_help
			"Configuration help can be found <a href='tm-file://#{e_url(ENV['TM_SUPPORT_PATH'])}/html/help.html#conf'>here.</a>"
		end

		# As many of the commands only work from a project scope this runs a check
		# that TM_PROJECT_DIRECTORY exist before continuing.
		#
		def require_tmproj

			unless ENV['TM_PROJECT_DIRECTORY']
				TextMate.exit_show_tool_tip "This Command should only be run from within a saved TextMate Project."
			end

		end
		
		# When using fcsh a path will fail if it contains a space.
		#
		def check_valid_paths(paths)
			
			paths.each { |p|
				if p =~ /\s/
				
					TextMate::HTMLOutput.show(:title => "FCSH Path Error", :sub_title => "" ) do |io|

						io << "<h2>FCSH Path Error</h2>"
						io << "<p>Warning fsch cannot handle paths containing a space."
						io << " "
						io << "/path_to/app.mxml works"
						io << "/path to/app.mxml fails as there is a space between path and to"
						io << " "
						io << "The path that caused the problem was"
						io << " "
						io << "#{p}"
						io << " "
						io << "See bundle help for more information."		
						io << "</p>"

					end
				
				end
			}
			
		end
		
		# ============================
		# = AUTOCOMPLETION SHORTCUTS =
		# ============================
		
		# The scopes this method should be triggered from are auto-generated using the same 
		# data source completions.txt is derived from. As completions.txt doesn't include 
		# any methods which contain parameters we can safely insert a set of empty brackets
		# when a match is not found. 
		#
		# Custom methods with the same signature will be ignored in favour of the
		# predetermined completions list.
		#
		# TODO: support.class.flash.actionscript.3, support.class.fl.actionscript.3, 
		#       support.class.mx.actionscript.3, support.class.top-level.actionscript.3
		#
		# DONE: support.function.top-level.actionscript.3, 
		#       support.function.flash.actionscript.3, support.function.fl.actionscript.3, 
		#       support.function.mx.actionscript.3, support.function.global.actionscript.3
		#
    def complete_by_scope

			words = `grep "^$TM_CURRENT_WORD\(" "$TM_BUNDLE_PATH/support/data/completions.txt"`.split("\n")

			TextMate.exit_insert_snippet("()${1:;}") if words.empty?

			if words.size > 1

				i = TextMate::UI.menu(words)
				TextMate.exit_discard() if i == nil
				choice = words[i]

			else
				choice = words.pop
			end

			snip = choice[ENV['TM_CURRENT_WORD'].length..-1]
			snip = FlexMate.snippetize_method_params(snip)
			
			TextMate.exit_insert_snippet(snip)
			
		end
		
		# Auto completes the import statement for the given word. Where word is partial,
		# or multiple matches are found a list of possible completions is presented
		# to the user for selection. 
		#
		def complete_import(word)
			
			scope  = ENV['TM_SCOPE']
			line   = ENV['TM_CURRENT_LINE']
			cp     = SourceTools.find_package(word)
      
			if scope =~ /asdoc/
				cp = "@see #{cp}"
			else
				cp = "import #{cp}" unless line =~ /^\s*import/
			end

			TextMate.exit_insert_snippet("#{cp};")
			
		end
		
		# =================
		# = SNIPPET UTILS =
		# =================

		# Converts ActionScript 3 method paramaters and 'snippetises' them for use
		# with TextMate.
		#
		def snippetize_method_params(str)
			i=0
			str.gsub!( /\n|\s/,"")
			str.gsub!( /([a-zA-Z0-9_'"\:\.\*=]+?)([,\)])/ ) {
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

			return unless message

			if has_dialog2
				`"$DIALOG" tooltip --text "#{message}"`
			end

		end

		# Invoke the completions dialog.
		#
		# This method is a customised version of the complete method found in ui.rb
		# in the main support folder. It double checks incoming data, links
		# images to Dialog 2 and automatically snippetizes output when a method is
		# selected by the user.
		#
		def complete(choices,filter=nil,exit_message=nil, &block)

			TextMate.exit_show_tool_tip("Completions need DIALOG2 to function.") unless self.has_dialog2

			if choices[0]['display'] == nil
				puts "Error, was expecting Dialog2 compatable data."
				exit
			end

			self.register_completion_images

			pid = fork do

				STDOUT.reopen(open('/dev/null'))
				STDERR.reopen(open('/dev/null'))

				command = "#{TM_DIALOG} popup --returnChoice"
				command << " --alreadyTyped #{e_sh filter}" if filter != nil
				command << " --additionalWordCharacters '_'"

				to_insert = ''
				result    = nil

				::IO.popen(command, 'w+') do |io|
					io << { 'suggestions' => choices }.to_plist
					io.close_write
					result = OSX::PropertyList.load io rescue nil
				end

				# Use a default block if none was provided
				block ||= lambda do |choice|

					suffix = choice['data'].sub!("#{choice['match']}", '')
					suffix = self.snippetize_method_params(suffix)
					suffix += ";" if choice['typeof'] == 'void'
					suffix
					
				end

				# The block should return the text to insert as a snippet
				to_insert << block.call(result).to_s

				# Insert the snippet if necessary
				`"$DIALOG" x-insert --snippet #{e_sh to_insert}` unless to_insert.empty?

				self.tooltip(exit_message)

			end

		end
		
		# Register the completions menu icons with TM DIALOG.
		#
		def register_completion_images

			icon_dir = File.expand_path(File.dirname(__FILE__)) + "/../../icons"

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

			`"$DIALOG" images --register  '#{images.to_plist}'`

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

		# ====================
		# = User Preferences =
		# ====================

		def get_preference(key)
			p = self.preferences
			p.transaction { p[key] }
		end

		def set_preference(key,value)
			p = self.preferences
			p.transaction { p[key] = value }
		end

		def preferences
			require "pstore"
			PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.flexmate"))
		end

	end

end

if __FILE__ == $0

  require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
  require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'
  require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
  require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'

	print "\ncheck_for_leopard: "
	puts FlexMate.check_for_leopard

	puts "\nhas_dialog2:"
	puts FlexMate.has_dialog2.to_s
	
	#FIX: This test hangs TM.
	FlexMate.tooltip("Test Message")  

	#ENV['TM_FLEX_FILE_SPECS'] = '/Users/simon/Desktop/golf_plus.xml'
	#ENV['TM_FLEX_OUTPUT'] = '/Users/simon/Desktop/golf_plus.swf'
	#
	#v = ['TM_FLEX_OUTPUT']
	#f = ['TM_FLEX_FILE_SPECS']
	#s = { :files => f, :evars => v }
	##s = {}
	#
	#FlexMate.required_settings(s)

end
