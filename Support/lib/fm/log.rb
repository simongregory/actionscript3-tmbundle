#!/usr/bin/env ruby -wKU

module FlexMate

  module Log

    class << self
    	
			LOG_FILE = "#{e_sh ENV['HOME']}/Library/Logs/TextMate ActionScript 3.log"

			# initilialize/clear the log.
			#
			def initialize
				f = File.open(LOG_FILE, "w")
				f.close			
			end

			# Appends the given text to the ActionScript 3 Bundle log file.
			#
			def puts(text)

				initialize_log unless File.exist?(LOG_FILE)

			  f = File.open(LOG_FILE, "a")
			  f.puts Time.now.strftime("\n[%m/%d/%Y %H:%M:%S]") + " TextMate::ActionScript 3.tmbundle"
			  f.puts text
			  f.flush
			  f.close

			end

		end
		
  end

end

if __FILE__ == $0

	FlexMate::Log.puts("Test Text")

end
