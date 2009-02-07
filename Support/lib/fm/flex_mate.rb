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
			unless ENV[evar]

				TextMate::HTMLOutput.show(:title => "Missing Environment Variable", :sub_title => "" ) do |io|

					io << '<h2>Environment var missing</h2>'
					io << "<p>Please define the environment variable <code>#{evar}</code>.<br><br>"
					io << configuration_help()
					io <<	"</p>"

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
					io <<	"</p>"

        end

			end
		end

		# Checks that the supplied environmental variables and files that they point
		# to exist. When they don't a html window is invoked and each failure is
		# listed.
		#
		def required_settings(settings={})

			failed_evars = []
			failed_files = []

			files = settings[:files] || []
			evars = settings[:evars] || []

			files.each { |f|
				failed_files << f unless File.exist?( ENV[f] || "" )
			}

			evars.each { |e|
				failed_evars << e unless ENV[e]
			}

			unless failed_evars.empty? && failed_files.empty?

				TextMate::HTMLOutput.show(:title => "Required Settings Missing", :sub_title => "" ) do |io|

					io << "<h2>Required Setting Missing</h2>"

					failed_files.each { |f| io << "<p>The environment variable <code>#{f}</code> does not resolve to an actual file.<br>" }
					failed_evars.each { |e| io << "<p>The environment variable <code>#{e}</code> was not defined.<br>" }

					io << configuration_help

				end
				
				TextMate.exit_show_html

			end

		end

		# Returns html link to configuration help.
		#
		def configuration_help
			"Configuration help can be found <a href='tm-file://#{e_url(ENV['TM_SUPPORT_PATH'])}/html/help.html#conf'>here.</a>"
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
		def complete(choices,filter=nil,exit_message=nil)
      
			TextMate.exit_show_tool_tip("Completions need DIALOG2 to function.") unless self.has_dialog2

			if choices[0]['display'] == nil
				puts "Error, was expecting Dialog2 compatable data."
				exit
			end

			pid = fork do

				STDOUT.reopen(open('/dev/null'))
				STDERR.reopen(open('/dev/null'))

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

				`"$DIALOG" images --register  '#{images.to_plist}'`

				command = "#{TM_DIALOG} popup --returnChoice"
				command << " --alreadyTyped #{e_sh filter}" if filter != nil
				command << " --additionalWordCharacters '_'"
         
				result = nil

				plist = { 'suggestions' => choices }
				plist['images'] = images

				::IO.popen(command, 'w+') do |io|
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

				# Insert the snippet if necessary
				`"$DIALOG" x-insert --snippet #{e_sh to_insert}` unless to_insert.empty?

				self.tooltip(exit_message)

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

	require "../flex_env"

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
