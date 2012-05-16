#!/usr/bin/env ruby -wKU
# encoding: utf-8

module FlexMate

  module Log

    class << self

      def log_file
        "#{ENV['HOME']}/Library/Logs/TextMate\ ActionScript\ 3.log"
      end

      # Initilialise/clear the log.
      #
      def init
        f = File.open(log_file, "w")
        f.close
      end

      # Appends the given text to the ActionScript 3 Bundle log file.
      #
      def puts(text)

        init unless File.exist?(log_file)

        f = File.open(log_file, "a")
        f.puts Time.now.strftime("\n[%m/%d/%Y %H:%M:%S]") + " TextMate::ActionScript 3.tmbundle"
        f.puts text
        f.flush
        f.close

      end

    end

  end

end
