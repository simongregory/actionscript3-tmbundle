module FlexMate

	module Compiler
		
		require SUPPORT + '/lib/web_preview'
		
		class << self
			
			def build
				
				FlexMate::SDK.add_flex_bin_to_path				
				TextMate.require_cmd('mxmlc')
				
				v = ['TM_FLEX_OUTPUT', 'TM_FLEX_FILE_SPECS']
				s = { :evars => v }
				
				#FlexMate.required_settings(s)
				
				f = locate_flex_file_specs
				
				o = ENV['TM_PROJECT_DIRECTORY'] + '/' + ENV['TM_FLEX_OUTPUT']
				
				puts html_head( :window_title => "ActionScript 3 Build Command", 
												:page_title => "Build (mxmlc)",
												:sub_title => File.basename(f) )
												
				puts "<h2>Building...</h2>"
				
				mxmlc_parser = MxmlcExhaust.new
				
				TextMate::Process.run("mxmlc -file-specs=#{e_sh f} -o=#{e_sh o}") do |str|
					STDOUT << mxmlc_parser.line(str)
				end
				
				mxmlc_parser.complete
				
				html_footer
				
			end
			
			#mxmlc \
			#	-sp+=$TM_AS3_LIB_PATH \
			#	-file-specs="$TM_FLEX_FILE_SPECS" \
			#	-output="$TM_FLEX_OUTPUT" \
			#	-incremental=true \
			#	-optimize=true 2>&1 | parse_mxmlc_out.rb;
			
			def locate_flex_file_specs

				proj_dir = ENV['TM_PROJECT_DIRECTORY']
				file_specs = ENV['TM_FLEX_FILE_SPECS']
				
				if proj_dir && file_specs
 					file_specs = proj_dir + '/' + file_specs
					return file_specs if File.exist?(file_specs)						
				end
				
				if proj_dir && file_specs.nil?					
					file_specs = guess_file_specs(proj_dir)
					return file_specs unless file_specs.nil?
				end
				
				if file_specs == nil && proj_dir == nil
					puts "Time to compile #{ENV['TM_FILEPATH']}"
				end
				
			end
			
			# Where we have Project Directory but no flex files specs set take a look
			# inside the src/ dir and see if we can work out which file should be 
			# compiled.
			#
			def guess_file_specs(proj_dir)
				
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
	
end

if __FILE__ == $0
	
	require "../flex_env"
	
	FlexMate::Compiler.build
	
end