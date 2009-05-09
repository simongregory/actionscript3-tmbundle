# encoding: utf-8

module FlexMate

	class Compiler

		require SUPPORT + '/lib/web_preview'
			
		# Run mxmlc to compile a swf adapting to the current environment as 
		# necessary.
		#
		def build

			FlexMate::SDK.add_flex_bin_to_path
			TextMate.require_cmd('mxmlc')

			cmd = MxmlcCommand.new
			cmd.file_specs = get_file_specs
			cmd.o = get_flex_output(cmd.file_specs)

			puts html_head( :window_title => "ActionScript 3 Build Command",
											:page_title => "Build (mxmlc)",
											:sub_title => cmd.file_specs_name )

			puts "<h2>Building...</h2>"
			puts "<p><pre>-file-specs=#{cmd.file_specs}"
			puts "-o=#{cmd.o}</pre></p>"

			exhaust = get_exhaust
			
			TextMate::Process.run(cmd.line) do |str|
				STDOUT << exhaust.line(str)
			end

			exhaust.complete

			html_footer

		end
		
		# Create the object responsible for parsing the compiler output.
		#
		def get_exhaust
			MxmlcExhaust.new
		end
		
		private
		
		# Inspects the available environmental variables and gathers the settings 
		# necessary for the compiler to run. 
		#
		def get_file_specs

			proj_dir = ENV['TM_PROJECT_DIRECTORY']
			file_specs = ENV['TM_FLEX_FILE_SPECS']

			if proj_dir && file_specs
				file_specs = proj_dir + '/' + file_specs
				return file_specs if File.exist?(file_specs)
			end

			if proj_dir
				file_specs = guess_file_specs(proj_dir)
				return file_specs unless file_specs.nil? 
			end

			file_specs = ENV['TM_FILEPATH']

		end

		# When TM_FLEX_OUTPUT and TM_PROJECT_DIRECTORY are defined use them to 
		# build flex output. Otherwise derive the output from the file specs.
		#
		def get_flex_output(fs)
			
			flex_output = ENV['TM_FLEX_OUTPUT']
			proj_dir = ENV['TM_PROJECT_DIRECTORY']
			
			if flex_output && proj_dir
				return proj_dir + '/' + flex_output
			end
			
			fs.sub(/\.(mxml|as)/, ".swf")
			
		end

		# Where we have Project Directory but no TM_FLEX_FILE_SPECS set take a look
		# inside the src/ dir and see if we can work out which file should be
		# compiled.
		#
		def guess_file_specs(proj_dir)

			#TODO: Link to src dir list.
			possible_src_dirs = ['src','source']

			src_dir = ""
			fs = []

			possible_src_dirs.each do |d|

				src_dir = proj_dir + '/' + d

				if File.exist?(src_dir)

					Dir.foreach(src_dir) do |f|
						fs << src_dir + '/' + f if f =~ /\.(as|mxml)$/
					end

				end

			end

			return fs[0] if fs.size == 1

		end

	end

end

# Object to encapsulate a mxmlc command with arguments.
#
class MxmlcCommand

	attr_accessor :file_specs
	attr_accessor :o	

	def line
		"mxmlc -file-specs=#{e_sh file_specs} -o=#{e_sh o}"
	end

	def file_specs_name
		File.basename(file_specs)
	end
	
end

if __FILE__ == $0

	require "../flex_env"

	FlexMate::Compiler.build

end
