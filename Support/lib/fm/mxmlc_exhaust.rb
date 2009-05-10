# encoding: utf-8

# Parses output from the mxmlc compiler and html formats it for use with the
# TextMate HTML output window.
#
class MxmlcExhaust

	# Constants to track switches in matches (to prettify output).
	CONFIGURATION_MATCH    = "configuration_match"
	ERROR_WARN_MATCH       = "error_warn_match"
	RECOMPILE_REASON_MATCH = "recompile_reason_match"

	# Instance initialisation. Creates the regex objects once, and set's the
	# error counter to 0. One instance should be created per mxmlc compile
	# otherwise the error counter will be inaccurate.
	#
	def initialize()

		@error_count = 0
		@last_match = ""

		@error_and_warn_regex = /(\/.*?)(\(([0-9]+)\)|):.*(Error|Warning):\s*(.*)$/
		@config_file_regex    = /(^Loading configuration file )(.*)$/
		@recompile_file_regex = /(^Recompile: )(.*)$/
		@reason_file_regex    = /(^.*, )(.*,)(.*)$/

	end

	# Processes a single line of mxmlc compiler output. HTML is generated with
	# links back to source and configuration files where appropriate.
	#
	def line(str)

		match = @error_and_warn_regex.match(str)

		begin

			unless match === nil
				print "<br/>" if @last_match != ERROR_WARN_MATCH
				if match[3] == nil
					print 'Error ' + match[5] +
					      ' in <a title="'+match[1] +
					      '" href="txmt://open?url=file://' + match[1] + '">' +
					      File.basename( match[1] ) + '</a><br/>'
				else
					print 'Error <a title="Click to show error." href="txmt://open?url=file://' + match[1] +
					      '&line='+ match[3] +
					      '" >' + match[5] +
					      '</a> at line ' + match[3] +
					      ' in <a title="'+match[1] +
					      '" href="txmt://open?url=file://' + match[1] + '">' +
					      File.basename( match[1] ) + '</a><br/>'
				end
				@error_count += 1
				@last_match = ERROR_WARN_MATCH
				return
			end

			match = @config_file_regex.match(str)
			unless match === nil
			    print "<br/>" if @last_match != CONFIGURATION_MATCH
			    print 'Loading configuration file: <a title="Click to open ' + match[2] +
			    '" href="txmt://open?url=file://' + match[2] + '" >' + File.basename( match[2] ) +'</a><br/>'
			    @last_match = CONFIGURATION_MATCH
			    return
			end

			match = @recompile_file_regex.match(str)
			unless match === nil
			    print "<br/>" if @last_match != RECOMPILE_REASON_MATCH
			    print 'Recompiling: <a title="Click to open ' + match[2] +
			    '" href="txmt://open?url=file://' + match[2] + '" >' + File.basename( match[2] )+'</a><br/>'
			    @last_match = RECOMPILE_REASON_MATCH
			    return
			end

			match = @reason_file_regex.match(str)
			unless match === nil
			    print "<br/>" if @last_match != RECOMPILE_REASON_MATCH
			    print match[1]+'<a title="Click to open ' + match[2] + '" href="txmt://open?url=file://' + match[2] +
			    '" >' + File.basename( match[2] )+'</a> ' + match[3] + '<br/>'
			    @last_match = RECOMPILE_REASON_MATCH
			    return
			end

			if str =~ /^(.*\.swf)( \([0-9].*$)/
			    cmd = "open #{e_sh($1)}"
          puts '<script type="text/javascript" charset="utf-8">function openSwf(){TextMate.system(\''+cmd+'\', null);}</script>'
			    puts "<br/><a href='javascript:openSwf()' title='Click to run (if there is space in the file path this may not work).'>#{$1}</a>#{$2}<br/>"
			end

		rescue TypeError

				puts "WARNING, TextMate ActionScript 3 Bundle Error, Unable to parse mxmlc output: <br/><br/>"
				puts "#{str}<br/>"

				@error_count += 1

		end

	end

	# This method should be called once compilations is complete. It outputs
	# formatted html that describes the number of errors encountered.
	#
	def complete
		err = (@error_count == 1) ?  "error" : "errors"
		print "<br/>Build complete, #{ @error_count.to_s } #{err} occured."
	end

end

if __FILE__ == $0

	exhaust = MxmlcExhaust.new
	exhaust.line("Loading configuration file /Developer/SDKs/flex_sdk_3.1.0/frameworks/flex-config.xml")
	exhaust.line("Loading configuration file /Users/simon/Documents/Code2/textmate/as3_bundle_tests/compiler/src/CompileTest-config.xml")
	exhaust.line("deploy/CompileTest.swf (417 bytes)")
	exhaust.complete

	puts "\n\n"

	exhaust.line("/Users/simon/Documents/code/actionscript_3/flex_unit/trunk/FlexUnitTest/src/FlexUnitTestRunner.mxml: Error: Unable to locate specified base class 'FlexUnitTestRunnerApplication' for component class 'FlexUnitTestRunner'.")

end
